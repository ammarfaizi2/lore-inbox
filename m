Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264282AbRFLJ1g>; Tue, 12 Jun 2001 05:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264286AbRFLJ10>; Tue, 12 Jun 2001 05:27:26 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:46858 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S264282AbRFLJ1S>; Tue, 12 Jun 2001 05:27:18 -0400
Date: Tue, 12 Jun 2001 17:25:46 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@silk.corp.fedex.com>
Subject: reiserfs problem on SMP
Message-ID: <Pine.LNX.4.33.0106121714030.26519-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got the following journaling error on 2.4.5 SMP during shutdown ...

....

Unmounting local file systems.
journal_begin called without kernel lock held
kernel BUG at journal.c:423!
invalid operand: 0000
CPU1:   1
EIP:    0010:[<f8854140>]
EFLAGS: 00010286
eax: 0000001d   ebx: f0951f2c   ecx: 00000001   edx: 00000001
esi: c3d26000   edi: f0951f2c   ebp: 0000000a   esp: f0951ec4
ds: 0018    es: 0018  ss: 0018
Process umount (pid: 265, stackpage=f0951000)

...

This bug only shows up on my SMP (2CPU) machine. It's been running fine on
1CPU non-smp machines.


Here's the difference for compiling ...

boston:root:/u2/src/linux> diff .config /root/src2/.config-2.4.5
54,55c54,55
< # CONFIG_NOHIGHMEM is not set
< CONFIG_HIGHMEM4G=y
---
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
57d56
< CONFIG_HIGHMEM=y
60,61c59,60
< CONFIG_SMP=y
< CONFIG_HAVE_DEC_LOCK=y
---
> # CONFIG_SMP is not set
> # CONFIG_X86_UP_IOAPIC is not set
68,69d66
< CONFIG_X86_IO_APIC=y
< CONFIG_X86_LOCAL_APIC=y



Thanks,
Jeff
[ jchua@fedex.com ]

