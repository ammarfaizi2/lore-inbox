Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVCWJE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVCWJE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVCWJE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:04:27 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:64261 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262885AbVCWJEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:04:20 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfs: remove a redundant NULL pointer check prior to kfree()
Date: Wed, 23 Mar 2005 11:04:10 +0200
User-Agent: KMail/1.5.4
Cc: Richard Gooch <rgooch@atnf.csiro.au>
References: <Pine.LNX.4.62.0503222351350.2683@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503222351350.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503231104.10704.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 March 2005 00:55, Jesper Juhl wrote:
> 
> Remove a redundant NULL pointer check prior to kfree(). kfree() has no 
> problem with NULL pointers.
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> --- linux-2.6.12-rc1-mm1-orig/fs/devfs/base.c	2005-03-02 08:37:49.000000000 +0100
> +++ linux-2.6.12-rc1-mm1/fs/devfs/base.c	2005-03-22 23:51:23.000000000 +0100
> @@ -2738,10 +2738,8 @@ static int devfsd_close(struct inode *in
>  	entry = fs_info->devfsd_first_event;
>  	fs_info->devfsd_first_event = NULL;
>  	fs_info->devfsd_last_event = NULL;
> -	if (fs_info->devfsd_info) {
> -		kfree(fs_info->devfsd_info);
> -		fs_info->devfsd_info = NULL;
> -	}
> +	kfree(fs_info->devfsd_info);
> +	fs_info->devfsd_info = NULL;
>  	spin_unlock(&fs_info->devfsd_buffer_lock);
>  	fs_info->devfsd_pgrp = 0;
>  	fs_info->devfsd_task = NULL;

IIRC devfs is deprecated and has less than a year to live.
--
vda

