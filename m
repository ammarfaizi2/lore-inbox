Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVAZJnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVAZJnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVAZJnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:43:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19120 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261800AbVAZJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:43:12 -0500
Date: Wed, 26 Jan 2005 09:43:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050126094308.GA7326@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050109194209.GA7588@infradead.org> <1105310650.11315.19.camel@lade.trondhjem.org> <1105345168.4171.11.camel@laptopd505.fenrus.org> <1105346324.4171.16.camel@laptopd505.fenrus.org> <1105367014.11462.13.camel@lade.trondhjem.org> <1105432299.3917.11.camel@laptopd505.fenrus.org> <1105471004.12005.46.camel@lade.trondhjem.org> <1105472182.3917.49.camel@laptopd505.fenrus.org> <20050125185812.GA1499@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125185812.GA1499@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o	vfs_follow_link(): used to interpret symbolic links, which
> 	might point outside of SAN Filesystem.

This one is going away very soon, including the whole old-style
->follow_link support - for technical reasons.

Please convert your driver to put the contents of the symlink into
... and implement ->put_link like all intree filesystems already did.

Without that we can't bump the limit on recursive symlinks, a feature
that IBM has been pushing for very hard, btw..

