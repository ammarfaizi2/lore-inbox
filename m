Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbSBCBDR>; Sat, 2 Feb 2002 20:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSBCBDJ>; Sat, 2 Feb 2002 20:03:09 -0500
Received: from 64-30-107-48.ftth.sac.winfirst.net ([64.30.107.48]:13572 "EHLO
	leng.internal") by vger.kernel.org with ESMTP id <S285352AbSBCBCz>;
	Sat, 2 Feb 2002 20:02:55 -0500
Date: Sat, 2 Feb 2002 17:02:44 -0800
From: Manuel McLure <manuel@mclure.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 Oops when trying to mount ATAPI CDROM
Message-ID: <20020202170244.A12338@ulthar.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Motherboard: ASUS P55T2P4 motherboard (Intel 430HX chipset)
CPU: AMD K6-III 400MHz
CD-ROM: No-name ATAPI CD-ROM installed as master on IDE channel 1 (hard 
drive is attached as master on IDE channel 0)
Kernel: Official 2.4.17 and Red Hat 2.4.9-21

Whenever I try to access the CD-ROM after boot, I get the following Oops:

Unable to handle kernel NULL pointer dereference at virtual address 
00000063
c0193030
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0193030>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c02b7730   ebx: 00000000   ecx: 00000005   edx: 00000004
esi: 00000005   edi: c02b7730   ebp: 00000001   esp: c0f51ee0
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1180, stackpage=c0f51000)
Stack: c02b7730 00000286 c8db3960 c0189762 c02b7730 c02b7730 00000007 
c02b7730
        c3e03e00 c02b7730 00000134 c8db0a81 c02b7730 c8db3960 00000001 
c8dad000
        00000001 00000015 00000001 c01165d7 c8db38a0 c0ab0000 000067a0 
c0ab2000
Call Trace: [<c8db3960>] [<c0189762>] [<c8db0a81>] [<c8db3960>] 
[<c01165d7>]
    [<c8db38a0>] [<c8dad060>] [<c0106f13>]
Code: 8a 15 63 00 00 00 83 e2 08 75 06 f6 43 6a 02 74 0c be 07 00

>> EIP; c0193030 <config_drive_xfer_rate+d0/110>   <=====
Trace; c8db3960 <[ide-cd]ide_cdrom_driver+0/f>
Trace; c0189762 <ide_register_subdriver+92/100>
Trace; c8db0a81 <[ide-cd]init_module+a1/1af>
Trace; c8db3960 <[ide-cd]ide_cdrom_driver+0/f>
Trace; c01165d7 <sys_init_module+537/5f0>
Trace; c8db38a0 <[ide-cd].LC156+0/d>
Trace; c8dad060 <[ide-cd]__module_license+0/0>
Trace; c0106f13 <system_call+33/40>
Code;  c0193030 <config_drive_xfer_rate+d0/110>
00000000 <_EIP>:
Code;  c0193030 <config_drive_xfer_rate+d0/110>   <=====
    0:   8a 15 63 00 00 00         mov    0x63,%dl   <=====
Code;  c0193036 <config_drive_xfer_rate+d6/110>
    6:   83 e2 08                  and    $0x8,%edx
Code;  c0193039 <config_drive_xfer_rate+d9/110>
    9:   75 06                     jne    11 <_EIP+0x11> c0193041 
<config_drive_xfer_rate+e1/110>
Code;  c019303b <config_drive_xfer_rate+db/110>
    b:   f6 43 6a 02               testb  $0x2,0x6a(%ebx)
Code;  c019303f <config_drive_xfer_rate+df/110>
    f:   74 0c                     je     1d <_EIP+0x1d> c019304d 
<config_drive_xfer_rate+ed/110>
Code;  c0193041 <config_drive_xfer_rate+e1/110>
   11:   be 07 00 00 00            mov    $0x7,%esi

After the Oops, lsmod shows:

ide-cd                 27072   3  (initializing)

and the module is stuck at initializing. 
This CD-ROM worked fine on 2.2.20 as long as I booted with "hdc=noprobe 
hdc=cdrom" (otherwise I'd get "lost interrupt" messages). I have tried 
"ide=nodma" with no effect, as well as trying with the "hdc=" options both 
on and off. Running "hdparm -d0 /dev/hdc" before trying the mount causes 
the same Oops.

Any ideas?

Thanks!
-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft
