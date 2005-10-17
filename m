Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVJQFib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVJQFib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 01:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVJQFia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 01:38:30 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3543 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932209AbVJQFia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 01:38:30 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Felix Oxley <lkml@oxley.org>
Subject: Re: [PATCH 1/1] Kconfig help text for RAM Disk & initrd
Date: Mon, 17 Oct 2005 00:37:36 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       trivial@rustcorp.com.au
References: <200510170102.19717.lkml@oxley.org>
In-Reply-To: <200510170102.19717.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510170037.37034.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 October 2005 19:02, Felix Oxley wrote:
> From: Felix Oxley <lkml@oxley.org>
>
> Amend Kconfig help text for RAM Disk & initrd to suggest that
> these features should be answered Y.
> Remove loadlin as an example of a boot loader, replace with grub.
>
> Signed-off-by: Felix Oxley <lkml@oxley.org>
> ---
> --- ./drivers/block/Kconfig.orig 2005-10-17 00:20:18.000000000 +0100
> +++ ./drivers/block/Kconfig 2005-10-16 23:57:18.000000000 +0100
> @@ -368,9 +368,11 @@ config BLK_DEV_RAM
>     Saying Y here will allow you to use a portion of your RAM memory as
>     a block device, so that you can make file systems on it, read and
>     write to it and do all the other things that you can do with normal
> -   block devices (such as hard drives). It is usually used to load and
> -   store a copy of a minimal root file system off of a floppy into RAM
> -   during the initial install of Linux.
> +   block devices (such as hard drives).
> +
> +   It is usually used to load and store a copy of a minimal root file
> +   system into RAM during the boot sequence. "Inital RAM disk support"
> +   must also be enabled for this option to work.

Actually if this is a patch against 2.6, between ramfs (including initramfs) 
and the ability to loopback mount files, I personally consider ramdisks 
semi-obsolete.  (This might be _why_ it says most normal users won't need 
them.)

>  config BLK_DEV_RAM_COUNT
>   int "Default number of RAM disks" if BLK_DEV_RAM
> @@ -403,11 +407,12 @@ config BLK_DEV_INITRD
>   depends on BLK_DEV_RAM=y
>   help
>     The initial RAM disk is a RAM disk that is loaded by the boot loader
> -   (loadlin or lilo) and that is mounted as root before the normal boot
> +   (lilo or grub) and that is mounted as root before the normal boot
>     procedure. It is typically used to load modules needed to mount the
>     "real" root file system, etc. See <file:Documentation/initrd.txt>
>     for details.
>
> +   Most users will answer Y here.

Again, on 2.6, most users will probably answer N and will instead use 
initramfs.

Rob
