Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268325AbTBNJYs>; Fri, 14 Feb 2003 04:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268326AbTBNJYr>; Fri, 14 Feb 2003 04:24:47 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:29779
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268325AbTBNJYo>; Fri, 14 Feb 2003 04:24:44 -0500
Date: Fri, 14 Feb 2003 04:33:02 -0500 (EST)
From: Zwane Mwaikambo <zwane@zwane.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5][0/14] *NEW* smp_call_function_on_cpu with Less Breakage
 (TM) Technology!
Message-ID: <Pine.LNX.4.50.0302140324120.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is yet another resend of my somewhat stale smp_call_function_on_cpu
patches with suggestions taken from Matthew Wilcox and James Bottomley to
recode smp_call_function as an smp_call_function_on_cpu user. The main 
reason for the resend this time is that i haven't changed the number of 
parameters to smp_call_function and hence _not_ breaking anything.

The purpose of smp_call_function_on_cpu is to invoke a function call on an 
arbitrary remote cpu or group of cpus utilising Interprocessor Interrupts. 
At present Alpha has a version (which i based this on) and IA64 has one 
called smp_call_function_single. This just makes it a general kernel 
function and part of the SMP API.

The i386 version has been tested on 8way P3-700 (courtesy of OSDL)

PS: Andrew, no the email address change isn't a killfile/procmail evasion 
tactic ;)

Linus please consider...

 arch/alpha/kernel/core_marvel.c |    1 
 arch/alpha/kernel/smp.c         |   83 +++++++++++---------------------
 arch/i386/kernel/smp.c          |   66 ++++++++++++++++----------
 arch/ia64/kernel/smp.c          |  101 +++++++++++++++++-----------------------
 arch/mips/kernel/smp.c          |   43 +++++++++++------
 arch/mips64/kernel/smp.c        |   51 +++++++++++++++-----
 arch/parisc/kernel/smp.c        |   63 ++++++++++++++++--------
 arch/ppc/kernel/smp.c           |   81 ++++++++++++++++++++------------
 arch/ppc64/kernel/smp.c         |   60 +++++++++++++++--------
 arch/s390/kernel/smp.c          |   49 ++++++++++++-------
 arch/s390x/kernel/smp.c         |   52 +++++++++++++-------
 arch/sparc64/kernel/smp.c       |   54 ++++++++++++++-------
 arch/um/kernel/smp.c            |   31 +++++++-----
 arch/x86_64/kernel/smp.c        |   48 ++++++++++++-------
 include/asm-alpha/smp.h         |    7 --
 include/linux/smp.h             |    7 ++
 16 files changed, 476 insertions(+), 321 deletions(-)

-- 
function.linuxpower.ca
