Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUDPWCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbUDPV7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:59:45 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:61703 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263876AbUDPV5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:57:45 -0400
Date: Fri, 16 Apr 2004 22:57:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: fix notify_change() potential null dereference.
Message-ID: <20040416225741.A11576@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040416213743.GS20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040416213743.GS20937@redhat.com>; from davej@redhat.com on Fri, Apr 16, 2004 at 10:37:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:37:43PM +0100, Dave Jones wrote:
> 
> --- linux-2.6.5/fs/attr.c~	2004-04-16 22:36:00.000000000 +0100
> +++ linux-2.6.5/fs/attr.c	2004-04-16 22:36:37.000000000 +0100
> @@ -130,7 +130,7 @@
>  int notify_change(struct dentry * dentry, struct iattr * attr)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	mode_t mode = inode->i_mode;
> +	mode_t mode;

Passing a NULL argument to notify_change() is invalid.

