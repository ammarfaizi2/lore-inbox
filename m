Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSLTTmD>; Fri, 20 Dec 2002 14:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSLTTmD>; Fri, 20 Dec 2002 14:42:03 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:7184 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S264931AbSLTTmA>;
	Fri, 20 Dec 2002 14:42:00 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.52, ALSA] Unable to handle kernel paging request at
 virtual address 32347363
References: <87u1hcv4qb.fsf@gswi1164.jochen.org>
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Fri, 20 Dec 2002 20:30:25 +0100
In-Reply-To: <87u1hcv4qb.fsf@gswi1164.jochen.org> (Jochen Hein's message of
 "Tue, 17 Dec 2002 20:30:14 +0100")
Message-ID: <87y96kbi9a.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hein <jochen@jochen.org> writes:

> This is when loading the cs4232 driver for my Thinkpad 600.
>
> Unable to handle kernel paging request at virtual address 32347363
[...]
> How can I decode the addresses in the modules?

Now with CONFIG_KALLSYMS enabled:

root@gswi1164:~# ./alsa start
Starting ALSA sound driver (version 0.9.0rc5):Unable to handle kernel paging request at virtual address 32347363
 printing eip:
c6aae81c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c6aae81c>]    Not tainted
EFLAGS: 00010286
EIP is at gcc2_compiled.+0x1c/0x6c [snd]
eax: c4924664   ebx: 32347363   ecx: c6ab5540   edx: c4924614
esi: c6ab3351   edi: 32347363   ebp: c35eff38   esp: c35eff2c
ds: 0068   es: 0068   ss: 0068
Process modprobe (pid: 15481, threadinfo=c35ee000 task=c2a713a0)
Stack: c4924614 32347363 c6ae17a0 c35eff54 c6aad660 32347363 00000000 00000000
       c6ae17a0 00000004 c35eff90 c6ae407a 00000001 32347363 c6ad3000 00000004
       00000000 00000000 c6ae17a0 00000000 00000010 c6ac3324 c6ac33b4 00000000
Call Trace:
 [<c6ae17a0>] enable+0x0/0x20 [snd_cs4232]
 [<c6aad660>] snd_card_new+0x40/0x24c [snd]
 [<c6ae17a0>] enable+0x0/0x20 [snd_cs4232]
 [<c6ae407a>] +0x7a/0x34c [snd_cs4232]
 [<c6ae17a0>] enable+0x0/0x20 [snd_cs4232]
 [<c6ae436c>] alsa_card_cs423x_init+0x20/0x54 [snd_cs4232]
 [<c012cab7>] sys_init_module+0x113/0x1a4
 [<c0108cd7>] syscall_call+0x7/0xb

Code: ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 34 83
 ./alsa: line 261: 15481 Speicherzugriffsfehler  /sbin/modprobe $line >/dev/null 2>&1
 (cs4232)

ksymopps decodes that as:

Code: ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 34 83


>>EIP; c6aae81c <END_OF_CODE+667afbc/????>   <=====

Trace; c6ae17a0 <END_OF_CODE+66adf40/????>
Trace; c6aad660 <END_OF_CODE+6679e00/????>
Trace; c6ae17a0 <END_OF_CODE+66adf40/????>
Trace; c6ae407a <END_OF_CODE+66b081a/????>
Trace; c6ae17a0 <END_OF_CODE+66adf40/????>
Trace; c6ae436c <END_OF_CODE+66b0b0c/????>
Trace; c012cab7 <sys_init_module+113/1a4>
Trace; c0108cd7 <syscall_call+7/b>

Code;  c6aae81c <END_OF_CODE+667afbc/????>
00000000 <_EIP>:
Code;  c6aae81c <END_OF_CODE+667afbc/????>   <=====
   0:   ae                        scas   %es:(%edi),%al   <=====
Code;  c6aae81d <END_OF_CODE+667afbd/????>
   1:   75 08                     jne    b <_EIP+0xb>
Code;  c6aae81f <END_OF_CODE+667afbf/????>
   3:   84 c0                     test   %al,%al
Code;  c6aae821 <END_OF_CODE+667afc1/????>
   5:   75 f8                     jne    ffffffff <_EIP+0xffffffff>
Code;  c6aae823 <END_OF_CODE+667afc3/????>
   7:   31 c0                     xor    %eax,%eax
Code;  c6aae825 <END_OF_CODE+667afc5/????>
   9:   eb 04                     jmp    f <_EIP+0xf>
Code;  c6aae827 <END_OF_CODE+667afc7/????>
   b:   19 c0                     sbb    %eax,%eax
Code;  c6aae829 <END_OF_CODE+667afc9/????>
   d:   0c 01                     or     $0x1,%al
Code;  c6aae82b <END_OF_CODE+667afcb/????>
   f:   85 c0                     test   %eax,%eax
Code;  c6aae82d <END_OF_CODE+667afcd/????>
  11:   74 34                     je     47 <_EIP+0x47>
Code;  c6aae82f <END_OF_CODE+667afcf/????>
  13:   83 00 00                  addl   $0x0,(%eax)


1 warning and 1 error issued.  Results may not be reliable.
