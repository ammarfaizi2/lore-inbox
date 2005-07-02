Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVGBIWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVGBIWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 04:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVGBIWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 04:22:41 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:11533 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261513AbVGBIWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 04:22:35 -0400
Date: Sat, 2 Jul 2005 10:22:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Eric Valette <eric.valette@free.fr>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty /dev
Message-ID: <20050702082218.GM8907@alpha.home.local>
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr> <20050630155453.GA6828@kroah.com> <42C455C1.30503@free.fr> <20050702053711.GA5635@kroah.com> <42C640AC.1020602@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C640AC.1020602@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Sat, Jul 02, 2005 at 09:22:20AM +0200, Eric Valette wrote:
> Greg KH wrote:
> 
> > Why?  Why not put it in ROM with your kernel image, look at how the
> > kernel build process does it with the "built-in" initramfs.
> 
> Well, nowadays, most system have only flash because ROM does not enable
> to do firmware upgrade. Second, putting it in the kernel or as a
> separate flash section or in an initrd does not change the problem :
> something has to be stored on non volatile memory whereas you do not
> need that for devfs (except devfs code itself of course) but then you
> have udev instead of devfs...

Well, although I've never used udev because I've been using sort of an
equivalent called "preinit" for 4 years now, I don't totally agree with
you about the firmware upgrade : when you package your systems to allow
the customer to perform "firmware" upgrades, your image is already very
specific to a hardware model, and I don't see why you would need to
create /dev entries independantly from the kernel or rootfs. Speaking
for myself, my .preinit script which describes how to fill /dev entries
is on the rootfs and does not need to change once packaged.

However, I agree that I encountered difficulties using this system on
more generic hardware, because sometimes the raid devices did not exist,
or things like this caused trouble.

IMHO, a generic system should use a full /dev directory and an embedded
system should use just the strict minimum necessary for the specific
hardware to run.

> > I boot my boxes with nothing in /dev and have been for almost a year
> > now.  udev works just fine for this, and so do some other programs that
> > work like udev does.
> 
> Nothing in /dev but with initramfs. Same cost...
> 
> BTW : valette@tri-yann->df /dev
> Filesystem           1K-blocks      Used Available Use% Mounted on
> tmpfs                    10240      2876      7364  29% /dev
> 
> 
> 2 MB RAM on my PC???  I must be missing something.

I think something went wrong, perhaps something like

   # some_prog >/dev/null 

while null did not exist. My /dev is a tmpfs too, but mounted with size=0,
so that I can only create inodes into it, but cannot write any data. One
other advantage of using size=0 is that "df" does not show it by default.

Cheers,
Willy

