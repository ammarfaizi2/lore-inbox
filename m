Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292385AbSBPPVN>; Sat, 16 Feb 2002 10:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292389AbSBPPVA>; Sat, 16 Feb 2002 10:21:00 -0500
Received: from ottawa-hs-209-217-123-77.d-ip.magma.ca ([209.217.123.77]:26350
	"EHLO cneufeld.linuxcare.com") by vger.kernel.org with ESMTP
	id <S292385AbSBPPTu>; Sat, 16 Feb 2002 10:19:50 -0500
Date: Sat, 16 Feb 2002 10:19:44 -0500
Message-Id: <200202161519.g1GFJij3002094@cneufeld.linuxcare.com>
From: Christopher Neufeld <neufeld@linuxcare.com>
To: linux-kernel@vger.kernel.org
Subject: Reproducible oops in 2.4.17, possibly related to ipchains
Reply-to: neufeld@linuxcare.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an easily reproducible oops in 2.4.17, running on an IBM Thinkpad
600E.  The system is quite stable until I add certain ipchains rules, after
which time it reliably crashes within minutes.

The chains rules added are of the following format (pulled from a perl
script which builds me a fake VPN by badly abusing the 127.0.0.0/8
network and /etc/hosts, and setting up ssh-forwarded ports):

ipchains -A vpnloop -p tcp -d $ipnum/32 $remote_port -j REDIRECT $local_port


Note that the system behaves well while ipchains.o is loaded and unused,
but once this set of rules has been added, the system becomes unstable.

Here's the text of the ksymoops output:

00000006
*pde = 00000000
Oops: 0000
CPU: 0
EIP:  0010: [<00000006>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c021f654  ebx: 00000005  ecx: cbd4377c  edx: c4d39380
esi: 00000006  edi: 00000000  ebp: c02145c0  dsp: c18dbf50
ds: 0018  es: 0018  ss: 0018
Process cc1 (pid: 688, stackpage= c18db000 )
Stack: c011b9b2 00000005 00000000 c02145a0 00000000 c02145c0 20000001 00000000
       c010b12c c01186e2 c0118620 00000000 00000001 c02145c0 fffffffe c011844a
       c02145c0 00000000 c0212900 00000000 c18dbfbc 00000046 c0107f02 00000000
Call trace: [<c011b9b2>] [<c010b12c>] [<c01186e2>] [<c0118620>] [<c0118449>] [<c0107f02>] [<c0109c98>]
Code: Bad EIP value

>>EIP; 00000006 Before first symbol   <=====
Trace; c011b9b2 <timer_bh+222/25c>
Trace; c010b12c <timer_interrupt+80/e8>
Trace; c01186e2 <bh_action+1a/40>
Trace; c0118620 <tasklet_hi_action+44/64>
Trace; c0118448 <do_softirq+58/a4>
Trace; c0107f02 <do_IRQ+96/a8>
Trace; c0109c98 <call_do_IRQ+6/e>


I have no exotic modules loaded, none outside of those which ship with the
kernel or with the pcmcia package.  This is a kernel.org kernel, not one
shipped on some distribution.

-- 
Christopher Neufeld, Senior Linux Consultant, Linuxcare, Inc.
613.562.9854 tel, 613.562.9304 fax
neufeld@linuxcare.com, http://www.linuxcare.com/
