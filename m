Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUHNCYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUHNCYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 22:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUHNCYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 22:24:39 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:34969 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S267941AbUHNCY2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 22:24:28 -0400
Subject: Re: [2.6.8-rc4-bk] NFS oops on x86-64
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1092450076.4078.34.camel@lade.trondhjem.org>
References: <411D65B4.4030208@pobox.com>
	 <1092447909.4078.18.camel@lade.trondhjem.org>
	 <1092450076.4078.34.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1092450265.4078.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 22:24:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 13/08/2004 klokka 22:21, skreiv Trond Myklebust:

> --- linux-2.6.8-rc4/fs/nfs/file.c.orig	2004-08-13 14:21:25.000000000 -0400
> +++ linux-2.6.8-rc4/fs/nfs/file.c	2004-08-13 21:50:28.000000000 -0400
> @@ -72,7 +72,7 @@ struct inode_operations nfs_file_inode_o
>  
>  static int nfs_check_flags(int flags)
>  {
> -	if (flags & (O_APPEND | O_DIRECT))
> +	if (flags & (O_APPEND | O_DIRECT) == (O_APPEND | O_DIRECT))
>  		return -EINVAL;
Argh... I'm making mistakes too now...

Should be

	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))

Trond
