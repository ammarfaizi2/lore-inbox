Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVAaOvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVAaOvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVAaOvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:51:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7337 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261225AbVAaOvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:51:03 -0500
Date: Mon, 31 Jan 2005 14:51:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050131145100.GA13161@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Paul Blazejowski <diffie@gmail.com>,
	linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>
References: <9dda349205012923347bc6a456@mail.gmail.com> <20050129235653.1d9ba5a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129235653.1d9ba5a9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 11:56:53PM -0800, Andrew Morton wrote:
> Paul Blazejowski <diffie@gmail.com> wrote:
> >
> > Kernel compile errors here, i think this might be XFS related...
> > 
> >  fs/built-in.o(.text+0x52a93): In function `linvfs_decode_fh':
> >  : undefined reference to `find_exported_dentry'
> >  make: *** [.tmp_vmlinux1] Error 1
> 
> bix:/home/akpm> grep EXPORT x
> CONFIG_XFS_EXPORT=y
> CONFIG_EXPORTFS=m
> 
> That isn't going to work.  Something like this, perhaps?


This patch (implementing Roman's suggestion) should fix it:

--- linux-2.6.11-rc2-mm1/fs/xfs/Kconfig~	2005-01-31 15:56:45.969973712 +0100
+++ linux-2.6.11-rc2-mm1/fs/xfs/Kconfig	2005-01-31 15:57:12.236974472 +0100
@@ -3,6 +3,7 @@
 config XFS_FS
 	tristate "XFS filesystem support"
 	select QSORT
+	select EXPORTFS if NFSD
 	help
 	  XFS is a high performance journaling filesystem which originated
 	  on the SGI IRIX platform.  It is completely multi-threaded, can
