Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVACSE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVACSE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVACRua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:50:30 -0500
Received: from alog0301.analogic.com ([208.224.222.77]:12672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261758AbVACRqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:46:14 -0500
Date: Mon, 3 Jan 2005 12:42:56 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
In-Reply-To: <20050103172839.GE29332@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0501031240420.13106@chaos.analogic.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com>
 <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, William Lee Irwin III wrote:

> The rest of gen_init_cpio.c seems to cast the result of strlen() to
> handle this situation, so this patch follows suit while killing off
> size_t -related printk() warnings.
>
> Signed-off-by: William Irwin <wli@holomorphy.com>
>
> Index: mm1-2.6.10/usr/gen_init_cpio.c
> ===================================================================
> --- mm1-2.6.10.orig/usr/gen_init_cpio.c	2005-01-03 06:45:53.000000000 -0800
> +++ mm1-2.6.10/usr/gen_init_cpio.c	2005-01-03 08:11:18.000000000 -0800
> @@ -86,7 +86,7 @@
> 		0,			/* minor */
> 		0,			/* rmajor */
> 		0,			/* rminor */
> -		(unsigned)strlen(name) + 1, /* namesize */
> +		(unsigned)strlen(name)+1, /* namesize */
> 		0);			/* chksum */
> 	push_hdr(s);
> 	push_rest(name);
> @@ -112,7 +112,7 @@
> 		(long) gid,		/* gid */
> 		1,			/* nlink */
> 		(long) mtime,		/* mtime */
> -		strlen(target) + 1,	/* filesize */
> +		(unsigned)strlen(target)+1, /* filesize */
> 		3,			/* major */
> 		1,			/* minor */
> 		0,			/* rmajor */
> -

The problem is that '1' is an int, not an unsigned int.
So, the correct fix is:

 		strlen(target) + 1U;

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
