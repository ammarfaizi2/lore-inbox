Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135747AbRDSWtt>; Thu, 19 Apr 2001 18:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135746AbRDSWta>; Thu, 19 Apr 2001 18:49:30 -0400
Received: from jalon.able.es ([212.97.163.2]:51134 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S135743AbRDSWtW>;
	Thu, 19 Apr 2001 18:49:22 -0400
Date: Fri, 20 Apr 2001 00:49:14 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ac10 ide-cd oopses on boot
Message-ID: <20010420004914.A1052@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Just built 2.4.3-ac10 and got an oops when booting. It tries to detect
the CD and gives the oops.

Here follows the oops both raw and decoded:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01bfc7c
pgd entry c0101000: 0000000000000000
pmd entry c0101000: 0000000000000000
.. pmd not present!
Oops: 0000
CPU:    1
EIP:    0010:[<c01bfc7c>]
EFLAGS: 00010297
eax: 0000000d   ebx: ffffffff   ecx: 00000000   eax: 00000000
esi: 00000000   edi: c15d84e8   ebp: c019e790   esp: c15f9ee8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c15f9000)
Stack: c0248fbc 00000000 c01bfeac 00000001 c0239e04 c0289841 00000246 00000001
       c02cdfb0 c0118af8 c02cdfb0 c0220524 00000080 c019f356 c021ff4c 00000001
	   00701600 00000000 0007122a 03297371 ff00c023 00008000 c15d84e8
c02cdfb0
Call Trace: [<c01bfeac>] [<c0118af8>] [<c019f356>] [<ff00c023>]
            [<c019f903>] [<c019fc66>] [<c0105000>]
			[<c0105028>] [<c0105000>] [<c0105516>] [<c0105000>]
Code: 8b 04 8a 83 f8 ff 75 0c 83 c6 20 eb e7 8d b4 26 00 00 00 00
 <0>Kernel panic: Attempted to kill init

ksymoops 2.4.1 on i686 2.4.3-ac9.  Options used
     -v /usr/src/linux-2.4.3-ac10/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.3-ac9/ (default)
     -m /boot/System.map-2.4.3-ac10 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01bfc7c
Oops: 0000
CPU:    1
EIP:    0010:[<c01bfc7c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: 0000000d   ebx: ffffffff   ecx: 00000000   eax: 00000000
esi: 00000000   edi: c15d84e8   ebp: c019e790   esp: c15f9ee8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c15f9000)
Stack: c0248fbc 00000000 c01bfeac 00000001 c0239e04 c0289841 00000246 00000001
       c02cdfb0 c0118af8 c02cdfb0 c0220524 00000080 c019f356 c021ff4c 00000001
           00701600 00000000 0007122a 03297371 ff00c023 00008000 c15d84e8
c02cdfb0
Call Trace: [<c01bfeac>] [<c0118af8>] [<c019f356>] [<ff00c023>]
            [<c019f903>] [<c019fc66>] [<c0105000>]
                     [<c0105028>] [<c0105000>] [<c0105516>] [<c0105000>]
Code: 8b 04 8a 83 f8 ff 75 0c 83 c6 20 eb e7 8d b4 26 00 00 00 00

>>EIP; c01bfc7c <cdrom_get_entry+1c/50>   <=====
Trace; c01bfeac <register_cdrom+1dc/280>
Trace; c0118af8 <printk+148/160>
Trace; c019f356 <ide_cdrom_probe_capabilities+3b6/3d0>
Trace; ff00c023 <END_OF_CODE+3ed31eb3/????>
Trace; c019f903 <ide_cdrom_setup+4a3/4e0>
Trace; c019fc66 <ide_cdrom_init+e6/180>
Trace; c0105000 <init+0/170>
Trace; c0105028 <init+28/170>
Trace; c0105000 <init+0/170>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0105000 <init+0/170>
Code;  c01bfc7c <cdrom_get_entry+1c/50>
00000000 <_EIP>:
Code;  c01bfc7c <cdrom_get_entry+1c/50>   <=====
   0:   8b 04 8a                  mov    (%edx,%ecx,4),%eax   <=====
Code;  c01bfc7f <cdrom_get_entry+1f/50>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c01bfc82 <cdrom_get_entry+22/50>
   6:   75 0c                     jne    14 <_EIP+0x14> c01bfc90
<cdrom_get_entry+30/50>
Code;  c01bfc84 <cdrom_get_entry+24/50>
   8:   83 c6 20                  add    $0x20,%esi
Code;  c01bfc87 <cdrom_get_entry+27/50>
   b:   eb e7                     jmp    fffffff4 <_EIP+0xfffffff4> c01bfc70
<cdrom_get_entry+10/50>
Code;  c01bfc89 <cdrom_get_entry+29/50>
   d:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

 <0>Kernel panic: Attempted to kill init


-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac9 #1 SMP Wed Apr 18 10:35:48 CEST 2001 i686

