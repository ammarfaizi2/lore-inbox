Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSFSWgt>; Wed, 19 Jun 2002 18:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318039AbSFSWgs>; Wed, 19 Jun 2002 18:36:48 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:11504 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S314553AbSFSWgr>; Wed, 19 Jun 2002 18:36:47 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200206192236.g5JMamiR001181@twopit.underworld>
Subject: [OOPS] 2.4.19-pre9-ac3 died when removing modules
To: linux-kernel@vger.kernel.org
Date: Wed, 19 Jun 2002 23:36:48 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was down in single-user mode for some testing, ran "rmmod -a" and
suddenly found an Oops on my console. I have a dual PIII with 1.25 GB
RAM, and am running devfs, ALSA CVS and lm_sensors 2.6.3. And since
the last thing that the console printed was "[drm] module unloaded",
I'll add that I have a Matrox G400 video card.

Here is the hand-copied oops:

[drm] module unloaded
Unable to handle kernel paging request at virtual address f8938cf3
printing eip: f8938cf3
*pde = 37c43067
*pte = 00000000

Oops = 0000
CPU 0
EIP: 0010:[<f8938cf3>]  Not tainted
EFLAGS: 00010246
eax: 00000001   ebx:eabb4c70   ecx:00000001   edx:0000000d
esi: eabb4c00   edi:00000001   ebp:0008e000   esp:c0269fc0
ds: 0018  es:0018  ss:0018

Process: swapper (pid:0, stackpage=c0269000)
Stack: c0268000 c0106c50 c0105000 c0127e91 00000019 00000032 c0106ccb c0268000
       0009e200 c0105048 c026a6e7 c0268000 00000000 00000002 c02c1720 c01001c9
Call Trace: [<c0106c50>][<c0105000>][<c0127e91>][<c0106ccb>][<c0105048>]
Code: Bad EIP value
<0>Kernel Panic: Attempted to kill the idle task!
In idle task - not syncing

And here is the ksymoops output:

ksymoops 2.4.5 on i686 2.4.19-pre9-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre9-ac3/ (default)
     -m /boot/System.map-2.4.19-pre9-ac3 (specified)

Unable to handle kernel paging request at virtual address f8938cf3
*pde = 37c43067
CPU 0
EIP: 0010:[<f8938cf3>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000001   ebx:eabb4c70   ecx:00000001   edx:0000000d
esi: eabb4c00   edi:00000001   ebp:0008e000   esp:c0269fc0
ds: 0018  es:0018  ss:0018
Stack: c0268000 c0106c50 c0105000 c0127e91 00000019 00000032 c0106ccb c0268000
       0009e200 c0105048 c026a6e7 c0268000 00000000 00000002 c02c1720 c01001c9
Call Trace: [<c0106c50>][<c0105000>][<c0127e91>][<c0106ccb>][<c0105048>]
Code: Bad EIP value


>>EIP; f8938cf3 <END_OF_CODE+61b2c/????>   <=====

>>ebx; eabb4c70 <_end+2a894b84/38538f14>
>>esi; eabb4c00 <_end+2a894b14/38538f14>
>>ebp; 0008e000 Before first symbol
>>esp; c0269fc0 <init_task_union+1fc0/2000>

Trace; c0106c50 <default_idle+0/34>
Trace; c0105000 <_stext+0/0>
Trace; c0127e91 <check_pgt_cache+11/18>
Trace; c0106ccb <cpu_idle+27/34>
Trace; c0105048 <rest_init+48/4c>

<0>Kernel Panic: Attempted to kill the idle task!

Cheers,
Chris
