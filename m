Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWJDTnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWJDTnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWJDTnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:43:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750932AbWJDTnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:43:23 -0400
Date: Wed, 4 Oct 2006 12:43:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Randy Dunlap <rdunlap@xenotime.net>, akpm <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <9a8748490610041224h7de321r6507a0d9e99ad015@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610041235380.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com> 
 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>  <20061002191638.093fde85.rdunlap@xenotime.net>
  <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>  <20061002213809.7a3f995f.rdunlap@xenotime.net>
  <Pine.LNX.4.64.0610030805490.3952@g5.osdl.org>  <20061003092339.999d0011.rdunlap@xenotime.net>
  <Pine.LNX.4.64.0610030933250.3952@g5.osdl.org>  <20061003094926.0e99d13f.rdunlap@xenotime.net>
  <Pine.LNX.4.64.0610030950230.3952@g5.osdl.org>
 <9a8748490610041224h7de321r6507a0d9e99ad015@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2006, Jesper Juhl wrote:
> 
> I just tested 2.6.18-git21 and here's a small status report :
> 
> The good news is: The kernel boots.
> The bad news is: Userspace breaks left and right.
> 
> I'm booting with "no387 nofxsr"
> 
> On my first boot I just used the options above and the result was that
> most of the bootup sequence looked quite normal until I got to the
> point of starting sshd, then things started to go wrong. This is what
> I got :
> 
> ...
> /etc/rc.d/rc.sshd: line 4: 1491 Illegal instruction    /usr/sbin/sshd

Ok, I bet you have your sshd compiled to use MMX instructions 
unconditionally.

> So that's great progress, but it could certainly work a lot better.

I don't think there is a whole lot we can do about it. There's really two 
choices:

 - make sure all user-space is able to function without MMX. This means, 
   for example, that you must certainly never compile with some code that 
   switches between MMX and non-MMX statically.

   The most common cases you'd expect to use MMX is for encryption, but 
   graphics and 3D certainly sounds very possible too..

   This isn't really somethign _we_ can do a lot about, although 
   distributions that care may of course try to test that their distro 
   works with "no387 nofxsr". You didn't say what distro you used, maybe 
   you can point it out to them.

 - we could try to extend the math emulator to emulate the new 
   instructions too.

   The thing is, it's probably not worth it. The only actual real usage 
   would be if somebody wants to take a disk image and switch to a really 
   old machine that lacked the MMX instruction, or for this particular 
   test-case.

so I suspect that in practice, the answer is "if the distro isn't compiled 
for a generic x86 target, screw it".

			Linus
