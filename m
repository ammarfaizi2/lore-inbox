Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263347AbSJFGxG>; Sun, 6 Oct 2002 02:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263348AbSJFGxG>; Sun, 6 Oct 2002 02:53:06 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:42942 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S263347AbSJFGxF>; Sun, 6 Oct 2002 02:53:05 -0400
Date: Sun, 6 Oct 2002 02:58:46 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40-ac4  kernel BUG at slab.c:1477!
Message-ID: <20021006065846.GA2376@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS P4S533 (SiS645DX chipset)
P4 2Ghz
1G PC2700 RAM
NVidia GeForce2 GTS (XFree86 driver, not nvidia binary)
hda: Maxtor 4G100J5, ATA DISK drive
hdc: LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive

This happens at random during boot when loading modules.
About half of the time ide-scsi works fine. 
The system continues to boot after the BUG with /dev/hdc unaccessible.

>From /var/log/messages:

 SCSI subsystem driver Revision: 1.00
 scsi0 : SCSI host adapter emulation for IDE ATAPI devices
 scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
   Vendor:           Model:                   Rev:     
   Type:   Direct-Access                      ANSI SCSI revision: 00
 hdc: lost interrupt
 hdc: status timeout: status=0xd0 { Busy }
 hdc: DMA disabled
 hdc: drive not ready for command
 hdc: ATAPI reset complete
 ------------[ cut here ]------------
 kernel BUG at slab.c:1477!
 invalid operand: 0000
 ide-scsi scsi_mod rtc  
 CPU:    0
 EIP:    0060:[<c01365ee>]    Not tainted
 EFLAGS: 00010016
 EIP is at kmem_cache_free_one+0x7e/0x240
 eax: 5a2cf071   ebx: c1009c10   ecx: f7561e90   edx: c1b0d5fc
 esi: c038c080   edi: c038c000   ebp: f7561e28   esp: f7561e04
 ds: 0068   es: 0068   ss: 0068
 Process insmod (pid: 257, threadinfo=f7560000 task=f7599b00)
 Stack: 742f3073 65677261 6c2f3074 00306e75 c038c000 c1b0d5fc c1009c10 c038c084 
        00009c10 f7561e48 c0135bcf c1b0d5fc c038c084 00000286 f7cd3600 c1b616b4 
        c038c084 f7561e7c fa8eee32 c038c084 f7561e68 c1b616b4 c038c084 f7561e6c 
 Call Trace:
  [<c0135bcf>]kfree+0x5f/0xb0
  [<fa8eee32>]scsi_probe_and_add_lun+0x92/0x190 [scsi_mod]
  [<fa8ef08e>]scsi_scan_target+0x4e/0x90 [scsi_mod]
  [<fa8ef301>]scan_scsis+0x91/0x17c [scsi_mod]
  [<fa8f8d92>].rodata.str1.32+0x392/0x3e6 [ide-scsi]
  [<fa8e79d2>]scsi_register_host_Rb0dc194c+0x222/0x350 [scsi_mod]
  [<fa8f84fe>]init_module+0x1e/0x30 [ide-scsi]
  [<fa8f96c0>]idescsi_template+0x0/0x80 [ide-scsi]
  [<c011ab1c>]sys_init_module+0x53c/0x690
  [<fa8f7060>]idescsi_discard_data+0x0/0x40 [ide-scsi]
  [<fa8f89cf>]__ksymtab+0x0/0x31 [ide-scsi]
  [<fa8f8fac>].kmodtab+0x0/0xc [ide-scsi]
  [<fa8f7060>]idescsi_discard_data+0x0/0x40 [ide-scsi]
  [<c010781b>]syscall_call+0x7/0xb
 
 Code: 0f 0b c5 05 07 ba 2e c0 8b 4d f0 89 f2 b8 71 f0 2c 5a 8b 59 

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

