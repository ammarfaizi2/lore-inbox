Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279742AbRJYKG5>; Thu, 25 Oct 2001 06:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279743AbRJYKGs>; Thu, 25 Oct 2001 06:06:48 -0400
Received: from genesis.westend.com ([212.117.67.2]:26267 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S279742AbRJYKGf>; Thu, 25 Oct 2001 06:06:35 -0400
Date: Thu, 25 Oct 2001 12:07:01 +0200
From: Christian Hammers <ch@westend.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Hammers <ch@westend.com>
Subject: BUG() in asm/pci.h:142 with 2.4.13
Message-ID: <20011025120701.C6557@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

My system crashed several times now with 2.4.11-pre6 and 2.4.13
(pre6 because it was the first one I got that fixed some 2GB RAM memory
allocation bug).

2.4.13 was the easiest one to reproduce: when starting the tape backup
to a HP DDS3/DAT Streamer (C1537A) via a Adaptec SCSI Controller 
(Adaptec 7892A in /proc/pci) on a Gigabyte GA-6VTXD Dual Motherboard with
two PIII and 2GB of RAM it crashed immediately with the error attached
below. The machine was under "stresstest-simulation" load at this time.

The tape_backup.pl uses the "mt" and "cpio" commands to access /dev/nst0.

Maybe worth noting is, that the system crashed another time yesterday 
after replacing the external SCSI RAID Chassis/Controller (not the
disks in it) and just this moment with another message (see below).

Any help or hints appreciated! 
[please keep me Cc'ed as I'm not subscribed to this list]

bye,

 -christian-


kernel: kernel BUG at /usr/local/src/kernel/linux-2.4.13/include/asm/pci.h:142!
kernel: invalid operand: 0000
kernel: CPU:    1
kernel: EIP:    0010:[ahc_linux_run_device_queue+899/2144]    Not tainted
kernel: EFLAGS: 00010082
kernel: eax: 00000048   ebx: f7bb5650   ecx: c0275a88   edx: 00010071
kernel: esi: c5915a30   edi: 00000000   ebp: c5915a30   esp: e9ae3e14
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process tape_backup.pl (pid: 4366, stackpage=e9ae3000)
kernel: Stack: c024e100 0000008e f7bbec00 e9ae3e6c 00000000 00000000 f5358de0 0000000e 
kernel:        f7bbec10 00000007 00000007 401af000 41ffffff 00000004 c5915600 c01b0e09  
kernel:        f7bbec00 c301fee0 00000202 d35ce1d4 c5915600 f7bbfa20 00000096 c01a5f76     
kernel: Call Trace: [ahc_linux_queue+361/424] [scsi_dispatch_cmd+354/632] [scsi_done+0/200] [scsi_request_fn+752/820] [__scsi_insert_special+110/128]  
kernel:    [scsi_insert_special_req+26/32] [scsi_do_req+284/324] [<f8a8940b>] [<f8a89240>] [<f8a8aad1>] [sys_write+143/196] 
kernel:    [system_call+51/56] 
kernel: 
kernel: Code: 0f 0b eb 18 90 83 7e 04 00 75 14 68 90 00 00 00 68 00 e1 24 

#
# The output from the other SCSI crash. This came from remote syslogging
# and console.
#

kernel: scsi0:0:0:0: Attempting to queue an ABORT message
kernel: (scsi0:A:0:0): Queuing a recovery SCB
kernel: scsi0:0:0:0: Device is disconnected, re-queuing SCB  
kernel: Recovery code sleeping
kernel: (scsi0:A:0:0): Abort Tag Message Sent
kernel: (scsi0:A:0:0): SCB 153 - Abort Tag Completed.
kernel: Recovery SCB completes
kernel: Recovery code awake   
kernel: aic7xxx_abort returns 8194
kernel: scsi0:0:0:0: Attempting to queue an ABORT message



Some more debugging help:

mtv-server:/usr/local/src/kernel/linux-2.4.13/include/asm# lspci    
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
00:0c.0 SCSI storage controller: Adaptec 7892A (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev
27)

mtv-server:~$ cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: easyRAID Model:  U3              Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: HP       Model: C1537A           Rev: L708
  Type:   Sequential-Access                ANSI SCSI revision: 02


-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

