Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVDRKxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVDRKxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 06:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVDRKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 06:53:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49361 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262026AbVDRKxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 06:53:05 -0400
Date: Mon, 18 Apr 2005 11:53:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       dwmw2@lists.infradead.org
Subject: Re: [PATC] small VFS change for JFFS2
Message-ID: <20050418105301.GA21878@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Artem B. Bityuckiy" <dedekind@infradead.org>,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	dwmw2@lists.infradead.org
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru> <20050418085121.GA19091@infradead.org> <1113814730.31595.6.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113814730.31595.6.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 12:58:50PM +0400, Artem B. Bityuckiy wrote:
> On Mon, 2005-04-18 at 09:51 +0100, Christoph Hellwig wrote:
> > No, exporting locks is a really bad idea.  Please try to find a better
> > method to fix your problem that doesn't export random kernel symbols.
> > 
> In general it must be true. But this specific case I believe is
> reasonable enough to export the mutext (as an exception).

Umm, no.  It's absolutely not a good reason.  What jffs2 is doing right
now is to poke into VFS internals it shouldn't, and exporting more internals
to prevent it from doing so isn't making the situation any better.

The VFS already has a method for freeing an struct inode pointer, and that
is ->destroy_inode.  You're probably better off updating your GC state from
that place.

