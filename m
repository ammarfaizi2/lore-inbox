Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVKKI2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVKKI2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVKKI2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:28:47 -0500
Received: from tornado.reub.net ([202.89.145.182]:34734 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751248AbVKKI2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:28:46 -0500
Message-ID: <43745633.1030802@reub.net>
Date: Fri, 11 Nov 2005 21:28:35 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051110)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>	<43743105.7030201@reub.net> <20051110220727.13b084f4.akpm@osdl.org>
In-Reply-To: <20051110220727.13b084f4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2005 7:07 p.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>> Hi,
>>
>> On 11/11/2005 5:35 p.m., Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
>>>
>>> - reiser4 seems to be broken when built as a module (due, I assume, to a
>>>   reiser4-specific kbuild change).  CONFIG_REISER4_FS=y will be needed.
>>>
>>> - New git tree git-cfq.patch - CFQ I/O scheduler updates from Jens
>>>
>>> - The git-pcmcia tree has been reinstated
>>>
>>> - git-audit and the several -mm fixups to it have been dropped for now - it's
>>>   undergoing a bit of churn.
>>>
>>> - Numerous subsystem updates.  Notably more v4l work.
>> Network is a no-go for me:
>>
>> [root@tornado ~]# /etc/init.d/network restart
>> e100: 0000:06:03.0: e100_eeprom_load: EEPROM corrupted
>> e100: probe of 0000:06:03.0 failed with error -11
>> sky2 0000:04:00.0: unsupported chip type 0xff
>> sky2: probe of 0000:04:00.0 failed with error -95
> 
> At a guess I'd say we didn't power the NIC up.

It fails almost all the time (but not 100%).  However if by chance it *does* 
come up on boot (without the message about eeprom being corrupted) then I can 
kill it by just shutting down the ethX interface and then rmmod'ing the e100 + 
sky2 modules, and then trying to reload them again.  Then the message above 
comes up then, as well as if it fails when booting.

When trying to bring up eth0, I this message is always logged:

Nov 11 21:16:07 tornado kernel: e100: probe of 0000:06:03.0 failed with error -11

It fails even on a cold boot.

2.6.14-rc5-mm1 does not exhibit this behaviour, not only because the modules
come up fine every time, but even after being removed and reinserted into the
kernel they still work OK.

[I need to use those two modules because I've been helping test the sky2 
driver, and only want one eth0 network driver loaded at a time]


> Could you please generate full dmesg output for good and bad kernels?

in http://www.reub.net/kernel/   (which is up most of the time at present).

> Also `lspci -vvxx -s 06:03.0' to have a look at the card's config space.

2.6.14-rc5-mm1 with eth0 up on boot:

06:03.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100]
(rev 05)
         Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min, 14000ns max), Cache Line Size 10
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at fe000000 (32-bit, prefetchable) [size=4K]
         Region 1: I/O ports at b800 [size=32]
         Region 2: Memory at ff300000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at fe100000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 29 12 17 01 90 02 05 00 00 02 10 20 00 00
10: 08 00 00 fe 01 b8 00 00 00 00 30 ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0a 00
30: 00 00 40 ff dc 00 00 00 00 00 00 00 0a 01 08 38


2.6.14-mm2, eth0 did not come up on boot:

[root@tornado ~]# lspci -vvxx -s 06:03.0
06:03.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100]
(rev 05)
         Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at fe000000 (32-bit, prefetchable) [size=4K]
         Region 1: I/O ports at b800 [size=32]
         Region 2: Memory at ff300000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at fe100000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 29 12 13 01 90 02 05 00 00 02 10 20 00 00
10: 08 00 00 fe 01 b8 00 00 00 00 30 ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0a 00
30: 00 00 40 ff dc 00 00 00 00 00 00 00 0a 01 08 38

[root@tornado ~]#


>> Both drivers worked under 2.6.14-rc5-mm1, but failed with 2.6.14-mm2.  I also 
>> re-tested against 2.6.14-mm1 and this problem also occurs there (I didn't get 
>> to test this this far with -mm1, had too many problems with other things and 
>> been having other hassles such as dsl connection).
> 
> Are you able to test just
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/broken-out/linus.patch ?

Yes, no such problem with that version.  But it spews out loads of debug
messages though:

Debug: sleeping function called from invalid context at include/asm/semaphore.h:99
in_atomic():1, irqs_disabled():1
  [<c0103c10>] dump_stack+0x17/0x19
  [<c0119824>] __might_sleep+0x9d/0xae
  [<c028754b>] scsi_disk_get_from_dev+0x15/0x48
  [<c0287d86>] sd_prepare_flush+0x17/0x5a
  [<c0277e19>] scsi_prepare_flush_fn+0x30/0x33
  [<c01dfc30>] blk_start_pre_flush+0xd5/0x13f
  [<c01df200>] elv_next_request+0x10e/0x16b
  [<c027825b>] scsi_request_fn+0x4b/0x2fd
  [<c01df041>] __elv_add_request+0x105/0x172
  [<c01e2371>] __make_request+0x1d3/0x47a
  [<c01e2756>] generic_make_request+0xb3/0x128
  [<c01e2814>] submit_bio+0x49/0xce
  [<c0297b58>] md_super_write+0x87/0xa3
  [<c029980e>] md_update_sb+0xc3/0x175
  [<c029df6d>] md_check_recovery+0x17b/0x427
  [<c0296103>] raid1d+0x1f/0x38d
  [<c029c767>] md_thread+0x3b/0xee
  [<c012f227>] kthread+0x99/0x9d
  [<c010112d>] kernel_thread_helper+0x5/0xb

I think this was the one addressed in a patch sent by James Bottomley, Tue, 08
Nov 2005 09:21:07 -0500 which is now in -mm2.  I guess that patch wants to be
pushed to Linus ;-)

The 2.6.14 with your linus.patch works fine, so it looks like an -mm(1|2) 
specific problem, which is common to both sky2 and e100 drivers (unlikely to 
be e100 specific I guess).

reuben

