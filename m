Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbREEGZP>; Sat, 5 May 2001 02:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131472AbREEGZG>; Sat, 5 May 2001 02:25:06 -0400
Received: from smarty.smart.net ([207.176.80.102]:26641 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S131446AbREEGYy>;
	Sat, 5 May 2001 02:24:54 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200105050627.CAA21713@smarty.smart.net>
Subject: Re: inserting a Forth-like language into the Linux kernel
To: linux-kernel@vger.kernel.org
Date: Sat, 5 May 2001 02:27:05 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.0-test10, in my kspamd kernel-thread that's like a hollowed-out
kswapd, I have x86 asm code like this...

[enter from in-kernel init]

[open 3 FDs on tty1]

LOOP:
	pushf
	pusha
	call schedule
	popa
	popf

	[ here is some code to use the write syscall to send 
		one byte to FD 1. A d, for example. ]

jmp LOOP


The d's get written until a syslog happens. If I do do_syslog(6,6,6); in
the C kspamd wrapper code it's about like so...



<gobs of d's>ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddINIT: entering runlevel 8

	[more normal logging stuff, ext2 warnings and so on]



If I don't do the do_syslog() the same thing happens somewhat earlier,
i.e. on a from-the-kernel-itself syslog.

Boot is normal. I can't shift&pg_up vt1, which normally I can, but I can
switch vt's, email you, etc.  /proc/4/status for kspamd shows

Name:   kspamd
State:  R (running)
Pid:    4
PPid:   1

PIDs 1, 2 and 3 don't have any open FD's. My simplistic wrapper pegs CPU
use at 1.0. 


Why don't my d's continue?

Might this be easier to do in a 2.0 kernel?


Rick Hohensee
www.clienux.com

