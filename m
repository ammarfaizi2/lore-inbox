Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317505AbSFEABO>; Tue, 4 Jun 2002 20:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSFEABN>; Tue, 4 Jun 2002 20:01:13 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:54927 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S317505AbSFEABM>; Tue, 4 Jun 2002 20:01:12 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200206050001.g5501CEM000892@twopit.underworld>
Subject: [OOPS] Memory problem in 2.4.19-pre9-ac3
To: linux-kernel@vger.kernel.org
Date: Wed, 5 Jun 2002 01:01:12 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a dual PIII box with 1.25GB of RAM (SMP kernel, devfs, CVS
ALSA, lm_sensors 2.6.3), and tonight I discovered this oops in my log:

ksymoops 2.4.5 on i686 2.4.19-pre9-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre9-ac3/ (default)
     -m /boot/System.map-2.4.19-pre9-ac3 (specified)

Jun  4 23:09:09 twopit kernel: Unable to handle kernel paging request at virtual address 83ec34ea
Jun  4 23:09:09 twopit kernel: c0212538
Jun  4 23:09:09 twopit kernel: *pde = 00000000
Jun  4 23:09:09 twopit kernel: Oops: 0002
Jun  4 23:09:09 twopit kernel: CPU:    1
Jun  4 23:09:09 twopit kernel: EIP:    0010:[unix_stream_sendmsg+528/804]    Not tainted
Jun  4 23:09:09 twopit kernel: EFLAGS: 00010202
Jun  4 23:09:09 twopit kernel: eax: e1b61a75   ebx: f5a0aa80   ecx: e1b617a0   edx: 0a4c69a8
Jun  4 23:09:09 twopit kernel: esi: 00000eb0   edi: e1b617f4   ebp: ca7d0000   esp: ccd47e70
Jun  4 23:09:09 twopit kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 23:09:09 twopit kernel: Process mozilla-bin (pid: 15755, stackpage=ccd47000)
Jun  4 23:09:09 twopit kernel: Stack: ccd47eb8 ccd47eec ccd47eb8 d4c78784 e1b617a0 00000000 e1b617a0 ef67eb40 
Jun  4 23:09:09 twopit kernel:        00000000 c01d3be5 d4c78784 ccd47eec 00000eb0 ccd47eb8 00000000 d4c78784 
Jun  4 23:09:09 twopit kernel:        d4c78660 00000eb0 00003d8b 000001f4 00000064 00000000 00000000 c01d3f0d 
Jun  4 23:09:09 twopit kernel: Call Trace: [sock_sendmsg+105/136] [sock_readv_writev+157/168] [sock_writev+55/64] [do_readv_writev+363/636] [sys_poll+724/740] 
Jun  4 23:09:09 twopit kernel: Code: 81 94 00 00 00 80 c0 75 7f f6 41 27 01 75 79 9c 5a fa f0 fe 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; e1b61a75 <_end+21841989/38538f14>
>>ebx; f5a0aa80 <_end+356ea994/38538f14>
>>ecx; e1b617a0 <_end+218416b4/38538f14>
>>edx; 0a4c69a8 Before first symbol
>>esi; 00000eb0 Before first symbol
>>edi; e1b617f4 <_end+21841708/38538f14>
>>ebp; ca7d0000 <_end+a4aff14/38538f14>
>>esp; ccd47e70 <_end+ca27d84/38538f14>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   81 94 00 00 00 80 c0      adcl   $0x41f67f75,0xc0800000(%eax,%eax,1)
Code;  00000007 Before first symbol
   7:   75 7f f6 41 
Code;  0000000b Before first symbol
   b:   27                        daa    
Code;  0000000c Before first symbol
   c:   01 75 79                  add    %esi,0x79(%ebp)
Code;  0000000f Before first symbol
   f:   9c                        pushf  
Code;  00000010 Before first symbol
  10:   5a                        pop    %edx
Code;  00000011 Before first symbol
  11:   fa                        cli    
Code;  00000012 Before first symbol
  12:   f0 fe 00                  lock incb (%eax)

This oops was preceded 20 minutes earlier by this message:

Jun  4 22:49:52 twopit kernel: Trying to vfree() nonexistent vm area (f8961000)

I think that 2.4.19-pre9-ac3 still has memory problems. Still, at
least it gave me an oops. 2.4.18 spontaneously reboots itself without
warning after between 1 and 2 weeks of uptime.

Cheers,
Chris
