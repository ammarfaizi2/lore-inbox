Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVHYMqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVHYMqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVHYMqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 08:46:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25493 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964961AbVHYMqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 08:46:46 -0400
Date: Thu, 25 Aug 2005 13:46:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] don't allow sys_readahead() on files opened with O_DIRECT
Message-ID: <20050825124641.GA13502@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Jan Blunck <j.blunck@tu-harburg.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <4305D437.4000703@tu-harburg.de> <20050825012440.66b61cca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825012440.66b61cca.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 01:24:40AM -0700, Andrew Morton wrote:
> > IMO sys_readahead() doesn't make sense if the file is opened with
> > O_DIRECT, because the page cache is stuffed but never used. Therefore
> > this patch changes that by letting the call return with -EINVAL.
> > 
> 
> a) It doesn't hurt, it's just a bit of a silly thing to do.

For ocfs that only allows either direct or buffered I/O on a single
inode at a given time it hurts.  It messes up the synchronization
protocol to be exact..

