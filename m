Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUAZKuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 05:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUAZKuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 05:50:11 -0500
Received: from ajt.k5.pl ([217.153.160.174]:51081 "EHLO poczta.ajt.pl")
	by vger.kernel.org with ESMTP id S265596AbUAZKuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 05:50:00 -0500
Date: Mon, 26 Jan 2004 11:49:52 +0100
From: goblin@ajt.k5.pl
To: linux-kernel@vger.kernel.org
Subject: Bug in virtual console scrollback buffer?
Message-ID: <20040126104952.GA10638@illuminati>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. I think I found a bug in linux' 2.6.1 vt scrollback buffer

2. I've noticed some changes in linux 2.6.1 scrollback buffer.
I'm not sure, but I once noticed that Shift-PgUp worked even after
switching a console (Alt-F?). Few days later I wanted to check this
out and test it again. Well, it didn't work. But I noticed a wierd thing:

After switching the console you are normally unable to see the scrollback
buffer. But when program "screen" is run, you may view it's internal
console scrollback buffer using ^A,^[ (and pg-ups). It's nothing unusual
in this, but when you leave the copy mode (eg. with Esc) and use
kernel's internal Shift-PgUp, you are able to see the scrollback buffers
of previously used virtual consoles. I think this may even be a security
violation as you can see what root typed on his console and sometimes
even recent dmesg messages. More to this, sometimes text in scrolled
back buffers is shifted to the right about 16 chars (when you toy
with Shift-PgUp/PgDn you notice it's sometimes normal, sometimes shifted).

I'm not sure whether or not this behavior is intended, but it seems
a bug for me. Well, I wasn't able to get any oops, thrash on screen,
segfault or any error like that, the kernel remained stable all the time.

3. (keywords:) screen, vt, scrollback

4. kernel version:
Linux version 2.6.1 (goblin@goblin) (gcc version 3.2.3) #2 
Wed Jan 21 08:42:57 CET 2004

5. No oops message or any kernel destabilization

6. To trigger the problem, use the program screen and it's scrollback
buffer with Ctrl-A, Ctrl-[.

7. Environment:
7.1 software
Screen version 3.09.15 (FAU) 13-Mar-03

sh ver_linux:
	Linux goblin 2.6.1 #2 Wed Jan 21 08:42:57 CET 2004 i686 unknown unknown GNU/Linux

	Gnu C                  3.2.3
	Gnu make               3.80
	util-linux             2.12
	mount                  2.12
	module-init-tools      0.9.14
	e2fsprogs              1.34
	jfsutils               1.1.3
	xfsprogs               2.5.6
	pcmcia-cs              3.2.5
	PPP                    2.4.1
	nfs-utils              1.0.6
	Linux C Library        2.3.2
	Dynamic linker (ldd)   2.3.2
	Linux C++ Library      5.0.3
	Procps                 2.0.16
	Net-tools              1.60
	Kbd                    1.08
	Sh-utils               5.0
	(No loaded modules)
Kernel is compiled with framebuffer console as a module, but
this module isn't in use (and wasn't since boot). I use only
text-mode console for this, I haven't tested this bug with
framebuffer device yet.

7.2 processor:
goblin@goblin:/usr/src/linux/scripts$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes) // it's actually a Celeron
stepping        : 1
cpu MHz         : 300.821
cache size      : 32 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 591.87

7.3
no modules loaded

7.4 and the rest:
Well, I have a 2mb-s3 virge(pci) and temporarily 32mb-s3 savage (agp), 
but this shouldn't be relevant as the bug occurs in text mode.


By the way, why in 2.6 I've 8 Bogomips less than in 2.4? ;-)


If possible, I'd like to hear from you about this bug
Thank you and may the penguins be with you :-)

--
Goblin
Robert Goliasz
goblin@ajt.k5.pl
or rgoliasz@poczta.onet.pl
