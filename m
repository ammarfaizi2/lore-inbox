Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbVLWUWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbVLWUWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbVLWUWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:22:30 -0500
Received: from web34102.mail.mud.yahoo.com ([66.163.178.100]:24948 "HELO
	web34102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161037AbVLWUWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:22:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WK0Jk90OEwSszrfAl63NAHeBsfO33p8AHIx6nwg4zIcrESB4qFx2hJ7F+pqPHvhH+xNvRYAbW6XPK72qfKeqtPQESDR0H7DdKQ+hRZZH2+lv+u1LXIaD3uCo4MDY3vuBJ9yK4KG+k2T0LhKFHWQd94A83pJ/unl8g4wq9GcqvhI=  ;
Message-ID: <20051223202227.46211.qmail@web34102.mail.mud.yahoo.com>
Date: Fri, 23 Dec 2005 12:22:27 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Oops in i2o
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried sending this to the scsi mailing list, but that seems to have failed, so...

Running smartmon on a drive under i2o RAID-10, twice in rapid succession often leads to:

[66477.509203] scsi-osm: Aborting command
block.                                                                             

[66487.512017] scsi-osm: Aborting command block.
[66488.006922] sd 1:0:0:0: scsi: Device offlined - not ready after error
recovery
[66507.284305] scsi-osm: SCSI error
05000e00                                    
[66507.289222] Unable to handle kernel paging request at virtual address
2a206564
[66507.298072]  printing
eip:                                                   
[66507.301427] 2a206564     
[66507.304139] *pde = 00000000
[66507.307570] Oops: 0000 [#1]
[66507.311016] PREEMPT SMP   
[66507.314286] Modules linked in: i2o_scsi sg autofs4 floppy i2c_amd756
i2c_amd8111 generic w83627hf hwmon_vid i2c_dev i2c_isa i2c_core bcm5700
[66507.330397] CPU:    1
[66507.330398] EIP:    0060:[<2a206564>]    Tainted: GF     VLI
[66507.330399] EFLAGS: 00010216   (2.6.15-rc6)                
[66507.345269] EIP is at 0x2a206564           
[66507.349222] eax: 00000033   ebx: ed3a7980   ecx: c04b1314   edx: 00000202
[66507.359973] esi: f780d600   edi: 00000005   ebp: 000000a9   esp: c0568f50
[66507.368169] ds: 007b   es: 007b   ss: 0068                              
[66507.373154] Process swapper (pid: 0, threadinfo=c0568000 task=c33d4550)
[66507.380874] Stack: f89bc6bc ed3a7980 f89bcd85 05000e00 3780d600
f780d600 00000005 c039b322
[66507.391576]        f7fd8c00 3780d600 f780d600 00000000 d3f494c9
f89be0e0 3780d600 f7fd8c00
[66507.402257]        c33d8f74 000000a9 c039d19a f7fd8c00 3780d600
f7fda8a0 00000000 c013e2a0
[66507.412950] Call
Trace:                                                                   
[66507.416314]  [<f89bc6bc>] i2o_scsi_reply+0x6c/0xe0 [i2o_scsi]
[66507.423388]  [<c039b322>] i2o_driver_dispatch+0xa2/0x1e0    
[66507.429980]  [<c039d19a>] i2o_pci_interrupt+0x2a/0x60  
[66507.436242]  [<c013e2a0>] handle_IRQ_event+0x30/0x70
[66507.442406]  [<c013e370>] __do_IRQ+0x90/0x120      
[66507.447851]  [<c01058c6>] do_IRQ+0x46/0x70  
[66507.452971]  =======================     
[66507.457361]  [<c0103b9a>] common_interrupt+0x1a/0x20
[66507.463525]  [<c0100de3>] default_idle+0x33/0x60   
[66507.469286]  [<c0100ea2>] cpu_idle+0x72/0x90   
[66507.474611] Code:  Bad EIP value.          
[66507.478791]  <0>Kernel panic - not syncing: Fatal exception in interrupt


This is with an Adpaptec 2015s and 4 Seagate SCSI drives.  All the drives, and the controller have
the latest firmware.

This is a dual Opteron server running 2.6.15-rc6 with smartmon version 5.34.

lspci shows:
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:02:05.0 RAID bus controller: Adaptec (formerly DPT) SmartRAID V Controller (rev 01)
0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:03:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)


-Kenny




	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
