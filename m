Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbSKBSzl>; Sat, 2 Nov 2002 13:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbSKBSzl>; Sat, 2 Nov 2002 13:55:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46084 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261405AbSKBSzk>; Sat, 2 Nov 2002 13:55:40 -0500
Date: Sat, 2 Nov 2002 11:01:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       <hpa@zytor.com>, <viro@math.psu.edu>
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
In-Reply-To: <20021102084226.GA7800@vitelus.com>
Message-ID: <Pine.LNX.4.44.0211021049480.2413-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, Aaron Lehmann wrote:
> 
> Won't the initial userspace be linked into the kernel? If so, why will
> the kernel image get smaller?

Note that the reason I personally really want initramfs is not to make the
kernel boot image smaller, or the kernel sources smaller. That won't
happen for a long time, since I suspect that we'll be carrying the
initramfs user space with us for quite a while (eventually it will
probably split up into a project of its own, but certainly for the
forseeable future it would be very closely tied to the kernel).

The real advantage to me is two-fold:

 - make it easier for people to customize their initial system without 
   having to muck with kernel code or even use a different boot sequence.  
   One example of this is the difference between vendor install kernels 
   (using initrd) and a normal install kernel (which doesn't).

   So I'd much rather see us _always_ using initrd, and the difference 
   between an install kernel and a regular kernel is really just the size 
   of the initrd thing.

 - Many things are much more easily done in user space, because user space 
   has protections, "infinite stack", and in general a lot better 
   infrastructure (ie easier to debug etc). At the same time, many things 
   need to be done _before_ the kernel is fully ready to hand over control 
   to a normal user space: do ACPI parsing so that we can initialize the
   devices so that we can use the "real" user space that is installed on
   disk etc.

   Sometimes there is overlap between these two things (ie the "easier to 
   do in user space" and "needs to be done before normal user space can be
   loaded"). ACPI is one potential example. Mounting the root filesystem 
   over NFS after having done DHCP or other auto-discovery is another.  

So "shrinking the kernel" is not on my list here. It's really a matter of
"some initialization is better done in user space", and not primarily "we
want to make the kernel smaller". I'm not a big believer in microkernels 
and trying to get everything out of the kernel itself, but I _do_ believe 
that sometimes it's easier to just let the user do his own choices (while 
still giving him all the protection implied by running in user space).

		Linus

