Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbUDPV7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbUDPV6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:58:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:46767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263846AbUDPVzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:55:01 -0400
Date: Fri, 16 Apr 2004 14:54:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: fix notify_change() potential null dereference.
In-Reply-To: <20040416213743.GS20937@redhat.com>
Message-ID: <Pine.LNX.4.58.0404161453340.3947@ppc970.osdl.org>
References: <20040416213743.GS20937@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I disagree on this one - at least with the message.

The fact is, "inode" can't be NULL. We have a BUG() check for it, but 
getting a page fault would be equally effective.

		Linus

On Fri, 16 Apr 2004, Dave Jones wrote:
> 
> --- linux-2.6.5/fs/attr.c~	2004-04-16 22:36:00.000000000 +0100
> +++ linux-2.6.5/fs/attr.c	2004-04-16 22:36:37.000000000 +0100
> @@ -130,7 +130,7 @@
>  int notify_change(struct dentry * dentry, struct iattr * attr)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	mode_t mode = inode->i_mode;
> +	mode_t mode;
>  	int error;
>  	struct timespec now = CURRENT_TIME;
>  	unsigned int ia_valid = attr->ia_valid;
> @@ -138,6 +138,7 @@
>  	if (!inode)
>  		BUG();
>  
> +	mode = inode->i_mode;
>  	attr->ia_ctime = now;
>  	if (!(ia_valid & ATTR_ATIME_SET))
>  		attr->ia_atime = now;
> 
