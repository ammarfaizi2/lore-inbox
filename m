Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTKXIKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 03:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTKXIKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 03:10:34 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:19361 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S263653AbTKXIKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 03:10:31 -0500
From: Frank Dekervel <kervel@drie.kotnet.org>
To: Adam Belay <ambx1@neo.rr.com>
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Date: Mon, 24 Nov 2003 09:10:29 +0100
User-Agent: KMail/1.5.93
References: <200311191749.28327.kervel@drie.kotnet.org> <200311240426.09709.kervel@drie.kotnet.org> <20031123230517.GG30835@neo.rr.com>
In-Reply-To: <20031123230517.GG30835@neo.rr.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200311240910.29565.kervel@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op Monday 24 November 2003 00:05, schreef u:
> > - will the original behaviour really solve the problem  (not only a
> > symptom) ? as i wrote, i can trigger almost the same oops (general
> > protection fault #0000 , invalid EIP value ), probably non-fatal because
> > another process is killed instead of the pid=1 process, and i can trigger
> > it on a mm4 with all pnpbios fixes backed out ...
>
> Yes but through the /proc/bus/pnp/devices file.  Correct?  It is
> independent from this change and would also need to be corrected.  Does the
> escd interface in /proc/bus/pnp also trigger an oops?

yup it seems so, but this time with valid backtrace
bakvis:/proc/bus/pnp# cat escd
Segmentation fault

in dmesg:
Unable to handle kernel paging request at virtual address fffec01a
 printing eip:
000055bf
*pde = 00004067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT SMP
CPU:    1
EIP:    0098:[<000055bf>]    Tainted: PF  VLI
EFLAGS: 00210086
EIP is at 0x55bf
eax: 000001ff   ebx: 00b06341   ecx: 000000a0   edx: 00000000
esi: 0000001a   edi: 00000000   ebp: ce47de9c   esp: ce47de68
ds: 00b0   es: 00a8   ss: 0068
Process cat (pid: 9496, threadinfo=ce47c000 task=e87fe080)
Stack: 000a0002 00b00000 000600a8 5b995598 00000000 635f00a0 007b0033 c000007b
       0206ce47 61e60020 008600a8 00000100 0090000b 00000042 00b000a8 000000a0
       00000000 c02bc9d2 00000060 00200082 00200033 c1210000 0000007b c017007b
Call Trace:
 [<c02bc9d2>] __pnp_bios_read_escd+0x130/0x1bb
 [<c017007b>] flush_old_exec+0x2cd/0xab2
 [<c02bca78>] pnp_bios_read_escd+0x1b/0x40
 [<c02bdcea>] proc_read_escd+0x65/0xf4
 [<c02bdc85>] proc_read_escd+0x0/0xf4
 [<c019d321>] proc_file_read+0xc4/0x26c
 [<c01641b2>] vfs_read+0xb0/0x119
 [<c0164459>] sys_read+0x42/0x63
 [<c03f353b>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: cat[9496] exited with preempt_count 2

greetings,
frank

-- 
Frank Dekervel - frank.dekervel@student.kuleuven.ac.be
Mechelsestraat 88
3000 Leuven (Belgium)
