Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWGBAFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWGBAFp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWGBAFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:05:45 -0400
Received: from thunk.org ([69.25.196.29]:61107 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750760AbWGBAFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:05:44 -0400
Date: Sat, 1 Jul 2006 20:05:28 -0400
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Bailey <jbailey@ubuntu.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060702000528.GA15375@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Jeff Bailey <jbailey@ubuntu.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Roman Zippel <zippel@linux-m68k.org>, klibc@zytor.com,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org> <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 01:08:17PM -0700, Linus Torvalds wrote:
> The argument that user space is more debuggable has been shown to be 
> largely a red herring. User space is only more debuggable if it does 
> something independent, and we've seen that user space is _harder_ to debug 
> than kernel space if we have events going back and forth.

Agreed, 100%.

In addition, userspace is debuggable only only if the initramfs has
enough debugging code in their (like a real live working shell,
strace, basic shell commands etc.)  Otherwise, it becomes even more
hellish to debug.  I wasted a huge amount of time trying to figure out
why the RHEL4 initramfs was incompatible with modern kernels using the
MPT Fusion SCSI driver, because I couldn't make it stop and break out
to a working shell; it had some busybox-like nash thing that wasn't
designed for user interaction, so all I could do was try to make tiny
changes to the initramfs, wait for the !@#@# very long boot cycle, and
watch the initial ramdisk fail to mount the root and crash, and
repeat, for hours on end.  RHEL4's userspace root mount system was
***not*** more debuggable, not in the last.  Adding printk's into a
kernel and recompiling would have been easier, and far less
frustrating.

Hopefully kinit will be better, but it's definitely not the case that
userpsace is easier to debug.  

						- Ted
