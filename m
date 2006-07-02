Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWGBARu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWGBARu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGBARu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:17:50 -0400
Received: from terminus.zytor.com ([192.83.249.54]:24298 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964885AbWGBARt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:17:49 -0400
Message-ID: <44A7108D.6090204@zytor.com>
Date: Sat, 01 Jul 2006 17:17:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Bailey <jbailey@ubuntu.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org> <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org> <20060702000528.GA15375@thunk.org>
In-Reply-To: <20060702000528.GA15375@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Sat, Jul 01, 2006 at 01:08:17PM -0700, Linus Torvalds wrote:
>> The argument that user space is more debuggable has been shown to be 
>> largely a red herring. User space is only more debuggable if it does 
>> something independent, and we've seen that user space is _harder_ to debug 
>> than kernel space if we have events going back and forth.
> 
> Agreed, 100%.
> 
> In addition, userspace is debuggable only only if the initramfs has
> enough debugging code in their (like a real live working shell,
> strace, basic shell commands etc.)  Otherwise, it becomes even more
> hellish to debug.  I wasted a huge amount of time trying to figure out
> why the RHEL4 initramfs was incompatible with modern kernels using the
> MPT Fusion SCSI driver, because I couldn't make it stop and break out
> to a working shell; it had some busybox-like nash thing that wasn't
> designed for user interaction, so all I could do was try to make tiny
> changes to the initramfs, wait for the !@#@# very long boot cycle, and
> watch the initial ramdisk fail to mount the root and crash, and
> repeat, for hours on end.  RHEL4's userspace root mount system was
> ***not*** more debuggable, not in the last.  Adding printk's into a
> kernel and recompiling would have been easier, and far less
> frustrating.
> 
> Hopefully kinit will be better, but it's definitely not the case that
> userpsace is easier to debug.  
> 

It isn't automatically easier, but it *can* be.

In your case above, with kinit, I would have added dash and strace (the 
latter would probably have to be statically linked against glibc; I 
haven't actually tried building strace under klibc myself) -- or even 
gdb -- to initramfs, and have /init drop into a shell.  From there one 
can run strace -f on kinit.

One of the criticisms I've gotten for klibc has been why I have included 
dash and a whole bunch of shell utilities when they're not used by the 
default kernel build.  It certainly hasn't been just to prove a point; 
as a matter of fact, getting dash to build correctly under Kbuild proved 
to be surprisingly difficult.  However, by making sure that one can 
*easily* pull together an interactive environment -- even if one didn't 
have one from the start -- one has more readily access to a debuggable 
environment.

Similarly, I try very hard to have small, individually testable modules. 
  I haven't taken that even as far as I'd like to have, in the end, but 
that's on my list of things to do.

	-hpa
