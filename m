Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWGATrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWGATrF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 15:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWGATrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 15:47:05 -0400
Received: from thunk.org ([69.25.196.29]:12689 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751920AbWGATrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 15:47:03 -0400
Date: Sat, 1 Jul 2006 11:05:07 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Bailey <jbailey@ubuntu.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060701150506.GA10517@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Bailey <jbailey@ubuntu.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
	klibc@zytor.com, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151751417.2553.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 06:56:57AM -0400, Jeff Bailey wrote:
> 
> The Ubuntu initramfs doesn't use kinit, and it would be nice if we
> weren't forced to.  We do a number of things in our initramfs (like a
> userspace bootsplace) which we need done before most of the things kinit
> wants to do take place.
> 

This is going to be a problem given that people are hell-bent at
chucking functionality out of the kernel into userspace.  If various
distributions insist on having their own initramfs/initrd, we're going
to have a maintenance headache where future kernel versions won't work
on distro kernels, which is going to be painful for kernel developers
that want to stay on the bleeding edge.  We are already seeing the
beginnings of this, where the the fact that modern kernels expect the
distro initramfs will wait for the SCSI probe to finish after loading
modules and trying to mount the root filesystem has caused RHEL4
system to be incompatible with modern kernels.  

Fortunately there is a workaround by not building the MPT Fusion
device driver as a module, but if Pavel succeeds in ejecting software
suspend into userspace, and preventing suspend2 from getting merged,
*and* distro's insist on doing their own thing with initramfs, we are
going to be headed for a major trainwreck.

Personally, I would be happier with keeping things like suspend2 in
the kernel, since I don't think the hellish compatibility problems
with non-reviewed kernel functionality that has been ejected into
userspace is really worth it --- but if we *are* going to go down the
route pushing everything into userspace, it is going to be critical
that distro's buy into using a kernel initialization system which is
shipped with the kernel, and can be updated without being tied a
particular distro's non-standard "value add".  Maybe that means we
need to have hooks so that the distro's can add their non-standard
"value add" without breaking the ability for users to upgrade to newer
kernels.  But either way, we're going to have to decide which way
we're going to go, and if we're going to go down the blind
in-userspace-good-in-kernel-bad approach, the distro's are going to
have to cooperate or it's going to be a mess.

						- Ted
