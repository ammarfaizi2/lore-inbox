Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315837AbSEMFRr>; Mon, 13 May 2002 01:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315841AbSEMFRq>; Mon, 13 May 2002 01:17:46 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:10719 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315837AbSEMFRp>; Mon, 13 May 2002 01:17:45 -0400
Date: Mon, 13 May 2002 15:17:35 +1000
From: Michael Still <mikal@stillhq.com>
To: <linux-kernel@vger.kernel.org>
Subject: APM broken on 2.4.18 with IBM Thinkpad X21
Message-ID: <Pine.LNX.4.30.0205131513010.4729-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Please be gentle, this is my first post to lkml].

I have an IBM Thinkpad X21, which worked fine with APM on Redhat 7.1
(2.4.2-2 with a whole bunch of Redhat patches). Now that I have upgraded
to 2.4.18, APM no longer works.

The debugging process I have been through is something like the following:

I think my initial problem was some undefined symbols. I am not sure why
these weren't defined, I should try to find out why sometime...

[root@localhost kernel]# insmod apm
Using /lib/modules/2.4.18/kernel/arch/i386/kernel/apm.o
/lib/modules/2.4.18/kernel/arch/i386/kernel/apm.o: unresolved symbol
machine_real_restart_Rsmp_3da1b07a
/lib/modules/2.4.18/kernel/arch/i386/kernel/apm.o: unresolved symbol
default_idle_Rsmp_92897e3d

After commenting these function calls out, recompiling the module and
rebooting with an apm=debug, I get:

apm: BIOS version 152.172 Flags 0xd231 (Driver version 1.16)
apm: no 32 bit BIOS support

...And then an ENODEV is returned...

Which is interesting, partially because this looks like random junk, and
partically because because the 2.4.2 kernel says the following (with
apm-debug):

apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
apm: entry f000:3f7f cseg16 f000 dseg 40 cseg len ffff, dseg len ffff
cseg16 len ffff
Starting kswapd v1.8
apm: Connection version 1.2
apm: AC off line, battery status high, battery life 76%
apm: battery flag 0x01, battery life 81 minutes

The APM_BIOS_INFO #define in setup.c has not changed between the versions,
and seems to be copied straight to apm_info.bios.

I then printed out the value of the pointer to the apm_info.bios structure
for 2.4.18, and 2.4.2 (on the assumption that this is just a pointer to
some magic config information in RAM) and got:

Mikal: apm.bios points to 0xc3a398ac      <---- 2.4.18
Mikal: apm_info.bios points to 0xf0000102 <---- 2.4.2-2 (redhat)

These values don't change across multiple insmods, but this isn't
conclusive.

Anyway, I'm in over my head, and was wondering if anyone has had success
with APM on these machines, and if not, what a reasonable next step in
debugging land might be.

Thanks,
Mikal

-- 

Michael Still (mikal@stillhq.com)     UMT+10hrs

