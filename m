Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280764AbRKKUnl>; Sun, 11 Nov 2001 15:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281055AbRKKUne>; Sun, 11 Nov 2001 15:43:34 -0500
Received: from d-dialin-1179.addcom.de ([62.96.163.227]:35566 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S280764AbRKKUnZ>; Sun, 11 Nov 2001 15:43:25 -0500
Date: Sun, 11 Nov 2001 21:42:34 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Thomas Hood <jdthood@home.dhs.org>
cc: <linux-kernel@vger.kernel.org>, <jdthood@mail.com>
Subject: Re: [PATCH] parport_pc to use pnpbios_register_driver()
In-Reply-To: <20011110053633.D7D8AB70@thanatos.toad.net>
Message-ID: <Pine.LNX.4.33.0111112134430.1518-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001, Thomas Hood wrote:

> > Here's a patch to make parport_pc.c use pnpbios_register_driver()
> instead of pnpbios_find_device.
> 
> 
> [...]
>  
> +#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)

linux/isapnp.h has the following code:

---
#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 
#define __ISAPNP__
---

I believe the pnpbios driver should do things something similar. Users of 
the interface should then only check for #ifdef __PNPBIOS__.

The reasoning behind this is the following: When you have a driver 
built-in, but pnpbios modular, the driver cannot use pnpbios 
functionality. The above definition reflects exactly this.

(BTW: The drivers using ISAPnP functionality seem to generally get this 
wrong, I'll look into cleaning this up. In drivers/scsi/aha152x.c it's 
done right)

--Kai



