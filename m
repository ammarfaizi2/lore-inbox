Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbQKEWqU>; Sun, 5 Nov 2000 17:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbQKEWqO>; Sun, 5 Nov 2000 17:46:14 -0500
Received: from hera.cwi.nl ([192.16.191.1]:60369 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130065AbQKEWqC>;
	Sun, 5 Nov 2000 17:46:02 -0500
Date: Sun, 5 Nov 2000 23:45:56 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Sean Middleditch <sean.middleditch@iname.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic - weird error
Message-ID: <20001105234556.A14138@veritas.com>
In-Reply-To: <3A05A724.216E04F3@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A05A724.216E04F3@iname.com>; from sean.middleditch@iname.com on Sun, Nov 05, 2000 at 01:29:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 01:29:56PM -0500, Sean Middleditch wrote:

> I've installed the Linux-Mandrake 7.2 distro (which uses kernel version
> 2.2.17) on a PIII system (Asus motherboard, Award Medallion v6.0 BIOS).
> For some reason, neither LILO nor Grub were able to boot off of the
> second hard-drive (where Linux is).  I've copied over the kernel, and a
> few other LILO files to a Windows partition on the primary drive.  Now,
> LILO can load the kernel, and the kernel begins to boot.
> 
> First, I noticed this during the IDE detection:
>   hdd [PTBL] [784/255/53] hdd1 < hdd5 hdd6 >
> I've never seen the "[PTBL] [784/255/53]" part before on any Linux
> system, so I was unsure if this was important.

It says that the disk geometry was taken from the partition table
(instead of using the heuristics that the kernel would use otherwise).
Since nobody except fdisk and lilo use the geometry, this is not
the cause of your booting problem.


> Then, after the raid detection (no, I don't have one, this is a default
> Mandrake kernel), I get this error:
>     "Invalid session number or type of track"
> which, after searching through the kernel sources, I found was an isofs
> error.
> Right after this error, I get a kernel panic, unable to mount root fs...

An ancient bug in the Linux setup is that one doesnt specify the
root filesystem type. Instead, the kernel tries to interpret the
root filesystem in all possible ways until it finds a filesystem type
willing to recognize it.

Thus, if the root filesystem is xiafs and you have no xiafs
compiled into the kernel, things will fail this way.
Or, if the root filesystem is ext2 and ext2 was compiled as
a module, you'll have the same problem.

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
