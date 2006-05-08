Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWEHT6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWEHT6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 15:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWEHT6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 15:58:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWEHT6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 15:58:11 -0400
Date: Mon, 8 May 2006 13:00:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Schweizer <genstef@gentoo.org>
Cc: linux-kernel@vger.kernel.org, i4ldeveloper@listserv.isdn4linux.de
Subject: Re: [PATCH 2.6.17-rc3] Fix capi reload by unregistering the correct
 major
Message-Id: <20060508130029.08a9a962.akpm@osdl.org>
In-Reply-To: <e307i4$f1h$1@sea.gmane.org>
References: <e307i4$f1h$1@sea.gmane.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Schweizer <genstef@gentoo.org> wrote:
>
> I am having the bug
> FATAL: Error inserting capi ([..]/capi.ko): Device or resource busy
> when I try to reload capi after loading it.
> in dmesg: capi20: unable to get major 68

This is odd.

> I attached a patch to fix the issue which is caused by setting the major to
> zero when registering the chrdev succeeded. Please apply
> - - Stefan
> 
> errors in the dmesg:
> 
> CAPI Subsystem Rev 1.1.2.8
> capifs: Rev 1.1.2.3
> capi20: Rev 1.1.2.7: started up with major 0 (middleware+capifs)
> <-- here you see that it was set to 0.
> (after unload and retry)
> capi: Rev 1.1.2.7: unloaded
> CAPI Subsystem Rev 1.1.2.8
> capi20: unable to get major 68
> <-- the chrdev has not been unlinked

> --- drivers/isdn/capi/capi.c.orig	2006-04-29 18:40:25.000000000 +0200
> +++ drivers/isdn/capi/capi.c	2006-04-29 18:27:22.000000000 +0200
> @@ -1499,7 +1499,6 @@
>  		printk(KERN_ERR "capi20: unable to get major %d\n", capi_major);
>  		return major_ret;
>  	}
> -	capi_major = major_ret;
>  	capi_class = class_create(THIS_MODULE, "capi");
>  	if (IS_ERR(capi_class)) {
>  		unregister_chrdev(capi_major, "capi20");
> 
> 
> 

What does "unload and retry" mean?

An `rmmod capi;modprobe capi' will reset the major to 68, so you must mean
something else.  What?

