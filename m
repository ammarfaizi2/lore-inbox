Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286850AbRLWJeZ>; Sun, 23 Dec 2001 04:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286851AbRLWJeG>; Sun, 23 Dec 2001 04:34:06 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:53445 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S286850AbRLWJeA>;
	Sun, 23 Dec 2001 04:34:00 -0500
Date: Sun, 23 Dec 2001 09:34:39 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Chris Rankin <rankincj@yahoo.com>
cc: linux-kernel@vger.kernel.org, Simon Trimmer <simon@veritas.com>
Subject: Re: Linux IA32 microcode driver
In-Reply-To: <200112221258.fBMCwIVl005421@twopit.underworld>
Message-ID: <Pine.LNX.4.21.0112230931130.607-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Yes, you are missing something, but it is not obvious. It is described in
my article in LJ of last February.

Basically, the design of microcode driver takes advantage of devfs when it
is available but works fine without it when it is not available. This is
so that we can store an extra bit of information in a field not present in
device nodes but present in regular files.  What is this field? File size.

So, your patch is not to be applied. Instead, if you want to, fix the
microcode_ctl startup script to not check if /dev/cpu/microcode is a
character device node.  It's a bug. Simon, I thought you fixed it, no?

Regards,
Tigran




On Sat, 22 Dec 2001, Chris Rankin wrote:

> Hi,
> 
> Am I missing something rather obvious, or is the /dev/cpu/microcode
> device being mis-created under devfs with Linux 2.4.x? I have enclosed
> a patch to ensure that the character device really *is* a character
> device.
> 
> Cheers,
> Chris
> 
> --- linux-2.4.17/arch/i386/kernel/microcode.c.orig	Sat Dec 22 12:37:07 2001
> +++ linux-2.4.17/arch/i386/kernel/microcode.c	Sat Dec 22 12:43:10 2001
> @@ -125,7 +125,7 @@
>  			MICROCODE_MINOR);
>  
>  	devfs_handle = devfs_register(NULL, "cpu/microcode",
> -			DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR | S_IWUSR, 
> +			DEVFS_FL_DEFAULT, 0, 0, S_IFCHR | S_IRUSR | S_IWUSR, 
>  			&microcode_fops, NULL);
>  	if (devfs_handle == NULL && error) {
>  		printk(KERN_ERR "microcode: failed to devfs_register()\n");
> 


