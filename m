Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVBXKN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVBXKN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVBXKMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:12:51 -0500
Received: from smtp1.xs4all.be ([195.144.64.135]:25241 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S262190AbVBXJgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:36:55 -0500
Message-ID: <421DA0B6.2030701@xs4all.be>
Date: Thu, 24 Feb 2005 10:39:02 +0100
From: yves geunes <geunes@xs4all.be>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: debian-testing@lists.debian.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: apt-get crashed 2.6.10
References: <421D11FA.9060808@xs4all.be> <20050223234227.GA27288@andromeda> <421D3168.80901@xs4all.be>
In-Reply-To: <421D3168.80901@xs4all.be>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yves geunes wrote:

> Justin Pryzby wrote:
>
>> On Thu, Feb 24, 2005 at 12:30:02AM +0100, yves geunes wrote:
>>  
>>
>>> Hi,
>>> I installed sarge 2.4.27-1-386 and downloaded 2.6.10. I compiled it 
>>> for 686 and RAID and installed it.
>>> Whenever I run apt-get  (or dselect) under the 2.6.10 kernel, the 
>>> system crashes and everything dies.
>>> When I reboot to 2.4.27 apt works normal.
>>>
>>> Does anybody have a hint? Can I screw up the kernel so that apt 
>>> crashes the system?
>>>   
>>
>> Is it comparable to bug #296274?
>>
> No, I think it is a new one
>
>> Oops: 0002 [#1]
>> PREEMPT SMP Modules linked in: md5 ipv6 af_packet eepro100 hw_random 
>> shpchp pci_hotplug intel_agp agpgart evdev ehci_hcd usbcore e100 mii 
>> e1000 dm_mod raid1 ide_cd cdrom rtc unix ext3 jbd ide_generic 
>> via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 
>> rz1000 piix pdc202xx_old pdc202xx_new opti621 ns87415 hpt366 ide_disk 
>> hpt34x generic cy82c693 cs5530 cmd64x atiixp amd74xx alim15x3 aec62xx 
>> ide_core sd_mod
>> CPU:    1
>> EIP:    0060:[<f890610c>]    Not tainted VLI
>> EFLAGS: 00010202   (2.6.10) EIP is at 
>> ext3_block_truncate_page+0x12c/0x330 [ext3]
>> eax: 00000000   ebx: 00000000   ecx: 000002d0   edx: 00000b40
>> esi: 00000000   edi: fa7c14c0   ebp: c174f820   esp: f559bddc
>> ds: 007b   es: 007b   ss: 0068
>> Process dpkg (pid: 4709, threadinfo=f559a000 task=f78d3520)
>> Stack: f587d6a0 00001000 000000d2 00000000 00000000 f14314f4 00000b40 
>> 000004c0       f1bf0ddc 00000001 00000000 f587d6a0 00000000 f8906a7d 
>> f587d6a0 c174f820       f1431598 000004c0 00000000 f1431598 c174f820 
>> f1431598 00000400 f1431430 Call Trace:
>> [<f8906a7d>] ext3_truncate+0x14d/0x5e0 [ext3]
>> [<f8906930>] ext3_truncate+0x0/0x5e0 [ext3]
>> [<c014858d>] vmtruncate+0xbd/0x150
>> [<c0173186>] inode_setattr+0x176/0x190
>> [<f8907bae>] ext3_setattr+0x13e/0x290 [ext3]
>> [<c01733b5>] notify_change+0x1b5/0x1f0
>> [<c0155dec>] do_truncate+0x6c/0xb0
>> [<c0158dd9>] fget+0x49/0x60
>> [<c015648c>] sys_ftruncate64+0xcc/0x130
>> [<c010318f>] syscall_call+0x7/0xb
>>
I recompiled the kernel WITHOUT SMP. I had to run         dpkg 
--configure -a

I tried dselect afterwards and it ran fine. I'll test it further this 
afternoon.

Some strange things:
-The crash only happened using apt. I recompiled the kernel while 
running the 'faulty' kernel, but it compiled flawless.  What could be 
the relation between apt and the crash. I haven't seen  another thing 
crashing.
- Allthough I only have 1 CPU, under SMP I had 2 CPU's. Maybe it's my 
lack og knowledge.
    --snip dmesg SMP--
Brought up 2 CPUs
CPU0:
 domain 0: span 03
  groups: 01 02
CPU1:
 domain 0: span 03
  groups: 02 01
--snip--

If I have more data, I'll send it.
Is there something like an endurance test that really tests system 
stability?

yves


