Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUFDV7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUFDV7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUFDV7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:59:42 -0400
Received: from zero.aec.at ([193.170.194.10]:40199 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265974AbUFDV7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:59:41 -0400
To: mike.miller@hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: cciss update for 2.6.7-rc1
References: <23tkF-7Hg-29@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 04 Jun 2004 23:59:17 +0200
In-Reply-To: <23tkF-7Hg-29@gated-at.bofh.it> (mikem@beardog.cca.cpqcorp.net's
 message of "Fri, 04 Jun 2004 22:20:13 +0200")
Message-ID: <m3pt8ff0i2.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem@beardog.cca.cpqcorp.net writes:


> @@ -451,6 +451,140 @@ static int cciss_release(struct inode *i
>  	return 0;
>  }
>  
> +#ifdef __x86_64__
> +/* for AMD 64 bit kernel compatibility with 32-bit userland ioctls */
> +#include <linux/syscalls.h>
> +extern int 
> +register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int,
> +      unsigned int, unsigned long, struct file *));
> +extern int unregister_ioctl32_conversion(unsigned int cmd);

This should be in CONFIG_COMPAT instead of testing for x86-64 
and include  <linux/compat.h> for the prototypes. linux/syscalls.h
should not be needed.

-Andi

