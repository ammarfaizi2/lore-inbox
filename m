Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264535AbUEMTvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUEMTvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUEMTpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:45:16 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:4981 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264518AbUEMTnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:43:09 -0400
Date: Thu, 13 May 2004 15:42:02 -0400
From: Mathieu Chouquet-Stringer <mchouque@online.fr>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: Oops on alpha while loading aic7xxx driver
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Mail-followup-to: Mathieu Chouquet-Stringer <mchouque@online.fr>,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Message-id: <20040513194202.GA17752@localhost>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

I just freshly compiled 2.6.6 using gcc 3.4.0 (built as a cross-compiler on
i386) and the kernel oopses when it loads the module for the Adaptec scsi
card. As a side note, it works when the driver is built-in.

Here's the decoded oops:
=============>8=============>8=============>8=============>8=============>8
ksymoops 2.4.9 on alpha 2.6.6-rc3.  Options used
     -v vmlinux (specified)
     -k kallsyms (specified)
     -l modules (specified)
     -o /lib/modules/2.6.6 (specified)
     -m /boot/System-map-2.6.6 (specified)
     -x

Warning (read_ksyms): no kernel symbols in ksyms, is kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
1024K Bcache detected; load hit latency 30 cycles, load miss latency 121 cycles
Unable to handle kernel paging request at virtual address 47f10409b53e0008
modprobe(289): Oops 0
pc = [<fffffffc000beb74>]  ra = [<fffffffc000beb68>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000001  t0 = 0000000000000010  t1 = 47f10409b53e0008
t2 = fffffc00011e0c00  t3 = 000000000000001e  t4 = 0000000000000020
t5 = 0000000000000000  t6 = fffffc00014616b0  t7 = fffffc003f7d4000
s0 = fffffc00011e0c00  s1 = fffffc003f545bc8  s2 = 0000000000000001
s3 = fffffffc000e0288  s4 = fffffc000077fb10  s5 = fffffc000073e688
s6 = fffffc003f7d7ab8
a0 = 00000000000003e8  a1 = fffffc003f7d7ab8  a2 = 000000000000000c
a3 = fffffc003f7d7a10  a4 = fffffc003f7d7a08  a5 = 0000000000000000
t8 = 0000000000000000  t9 = 00000000ffffffff  t10= 0000000000100100
t11= 0000000000200200  pv = fffffc000031e0e0  at = fffffc0000006d00
gp = fffffc000033ebd8  sp = fffffc003f7d7a48
Trace:fffffc00004abc78 fffffc00004da75c fffffc00004da974 fffffc00004dad84 fffffc00004db374 fffffc00004ab640 fffffc0000341868 fffffc0000312104 fffffc00003bc034 fffffc0000393944 fffffc000035aa6c 
Code: 47ff041f  345e0092  d35ffa0a  47e0040b  e4000030  a45d6c58 <a0220000> e4200006 


>>PC;  fffffffc000beb74 <END_OF_CODE+4380858791060/????>   <=====

Trace; fffffc00004abc78 <pci_device_probe+536/576>
Trace; fffffc00004da75c <bus_match+92/192>
Trace; fffffc00004da974 <driver_attach+148/272>
Trace; fffffc00004dad84 <bus_add_driver+180/320>
Trace; fffffc00004db374 <driver_register+52/80>
Trace; fffffc00004ab640 <pci_register_driver+112/240>
Trace; fffffc0000341868 <sys_init_module+472/6944>
Trace; fffffc0000312104 <entSys+164/192>
Trace; fffffc00003bc034 <ext3_dirty_inode+164/224>
Trace; fffffc0000393944 <__mark_inode_dirty+324/512>
Trace; fffffc000035aa6c <__vma_link_rb+60/80>

Code;  fffffffc000beb5c <END_OF_CODE+4380858791036/????>
0000000000000000 <_PC>:
Code;  fffffffc000beb5c <END_OF_CODE+4380858791036/????>
   0:   1f 04 ff 47       nop  
Code;  fffffffc000beb60 <END_OF_CODE+4380858791040/????>
   4:   92 00 5e 34       stw  t1,146(sp)
Code;  fffffffc000beb64 <END_OF_CODE+4380858791044/????>
   8:   0a fa 5f d3       bsr  ra,ffffffffffffe834 <_PC+0xffffffffffffe834>
Code;  fffffffc000beb68 <END_OF_CODE+4380858791048/????>
   c:   0b 04 e0 47       mov  v0,s2
Code;  fffffffc000beb6c <END_OF_CODE+4380858791052/????>
  10:   30 00 00 e4       beq  v0,d4 <_PC+0xd4>
Code;  fffffffc000beb70 <END_OF_CODE+4380858791056/????>
  14:   58 6c 5d a4       ldq  t1,27736(gp)
Code;  fffffffc000beb74 <END_OF_CODE+4380858791060/????>   <=====
  18:   00 00 22 a0       ldl  t0,0(t1)   <=====
Code;  fffffffc000beb78 <END_OF_CODE+4380858791064/????>
  1c:   06 00 20 e4       beq  t0,38 <_PC+0x38>


1 warning issued.  Results may not be reliable.
=============>8=============>8=============>8=============>8=============>8

Using objdump, kallsyms, I've been able to pinpoint the problem. The
closest function to fffffffc000beb74 is ahc_pci_config:
fffffffc000be5c0 t ahc_pci_config       [aic7xxx]
fffffffc000c02e0 t ahc_pci_intr [aic7xxx]

At the address fffffffc000beb74, we're in check_extport (called by
ahc_pci_config).

Here's the output of objdump (see how it matches the output of ksymoops):

/usr/src/kernel/linux-2.5/drivers/scsi/aic7xxx/aic7xxx_pci.c:1359
    22bc:       1f 04 ff 47     nop     
    22c0:       92 00 5e 34     stw     t1,146(sp)
/usr/src/kernel/linux-2.5/drivers/scsi/aic7xxx/aic7xxx_pci.c:1361
    22c4:       00 00 40 d3     bsr     ra,22c8 <ahc_pci_config+0x5a8>
    22c8:       0b 04 e0 47     mov     v0,s2
/usr/src/kernel/linux-2.5/drivers/scsi/aic7xxx/aic7xxx_pci.c:1362
    22cc:       30 00 00 e4     beq     v0,2390 <ahc_pci_config+0x670>
/usr/src/kernel/linux-2.5/drivers/scsi/aic7xxx/aic7xxx_pci.c:1364
    22d0:       00 00 5d a4     ldq     t1,0(gp)
    22d4:       00 00 22 a0     ldl     t0,0(t1)
    22d8:       06 00 20 e4     beq     t0,22f4 <ahc_pci_config+0x5d4>

fffffffc000beb74 is really 22d4. The interesting thing is the portion of C
code involved: 
1364:                if (bootverbose)
1365:                        printf("%s: Reading SEEPROM...", ahc_name(ahc));

So it looks like it chokes on bootverbose, any idea why?
-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
