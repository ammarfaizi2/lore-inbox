Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVACSoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVACSoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVACSkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:40:47 -0500
Received: from alog0301.analogic.com ([208.224.222.77]:15232 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261772AbVACShT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:37:19 -0500
Date: Mon, 3 Jan 2005 13:33:40 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
In-Reply-To: <20050103180915.GK29332@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com>
 <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com>
 <41D9881B.4020000@pobox.com> <20050103180915.GK29332@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, William Lee Irwin III wrote:

> On Mon, Jan 03, 2005 at 12:59:55PM -0500, Jeff Garzik wrote:
>> This removes whitespace in the process, violating the file's chosen
>> style (and typical lkml style).
>
> I have no personal interest in the whitespace involved. The following
> amended patch is likely to avoid inconsistencies with the rest of the
> file regarding whitespace.
>
>
> -- wli
>

But it's wrong.
It should be:
> +		strlen(target) + 1U,	/* filesize */

strlen() already returns a size_t. You need an unsigned 1 to
not affect it. As previously stated, an integer constant
is an int, not an unsigned int unless you make it so with
"U".

>
> Index: mm1-2.6.10/usr/gen_init_cpio.c
> ===================================================================
> --- mm1-2.6.10.orig/usr/gen_init_cpio.c	2005-01-03 06:45:53.000000000 -0800
> +++ mm1-2.6.10/usr/gen_init_cpio.c	2005-01-03 09:42:18.000000000 -0800
> @@ -112,7 +112,7 @@
> 		(long) gid,		/* gid */
> 		1,			/* nlink */
> 		(long) mtime,		/* mtime */
> -		strlen(target) + 1,	/* filesize */
> +		(unsigned)strlen(target) + 1,/* filesize */
> 		3,			/* major */
> 		1,			/* minor */
> 		0,			/* rmajor */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
