Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279519AbRJaCCD>; Tue, 30 Oct 2001 21:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279811AbRJaCBy>; Tue, 30 Oct 2001 21:01:54 -0500
Received: from mplspop2.mpls.uswest.net ([204.147.80.4]:27913 "HELO
	mplspop2.mpls.uswest.net") by vger.kernel.org with SMTP
	id <S279519AbRJaCBg>; Tue, 30 Oct 2001 21:01:36 -0500
Date: Tue, 30 Oct 2001 19:55:28 -0600
Message-ID: <20011030195527.A24642@beaver.iucha.org>
From: "Florin Iucha" <florin@iucha.net>
To: linux-kernel@vger.kernel.org
Subject: scsi lockup with adaptec and advansys
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Kernel version: 2.4.14-pre5
SCSI subsystem: 
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 5 for device 00:09.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 SCSI adapter>
        aic7870: Wide Channel A, SCSI Id=7, 16/253 SCBs

   Vendor: IBM       Model: DCHS04W           Rev: 6464
     Type:   Direct-Access                      ANSI SCSI revision: 02
   Vendor: IBM       Model: DCHS04U           Rev: 6464
     Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sda: 8813870 512-byte hdwr sectors (4513 MB)
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 >
(scsi0:A:1): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sdb: 8813870 512-byte hdwr sectors (4513 MB)
  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >

I am experiencing a kernel lockup under load: I am running three md5sum 
processes on the Mandrake .iso files, starting mozilla and playing an
.mpg clip with vlc.

I am getting this errors in the serial console:
Saw underflow (16384 of 126976 bytes). Treated as error
Saw underflow (126976 of 126976 bytes). Treated as error
Saw underflow (126976 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (12288 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (512 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (512 of 126976 bytes). Treated as error
Saw underflow (12288 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (512 of 126976 bytes). Treated as error
Saw underflow (4608 of 126976 bytes). Treated as error
Saw underflow (4096 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (512 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (512 of 126976 bytes). Treated as error
Saw underflow (94208 of 126976 bytes). Treated as error
Saw underflow (8192 of 126976 bytes). Treated as error
Saw underflow (512 of 126976 bytes). Treated as error

and then this oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000100
c02007f3
*pde = 1df34067
Oops: 0000
CPU:    0
EIP:    0010:[<c02007f3>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013006
eax: 00000100   ebx: c1820a00   ecx: 00000000   edx: 00000000
esi: de52ff04   edi: de52ff04   ebp: 00000000   esp: de52fe9c
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 304, stackpage=de52f000)
Stack: de52ff04 c1820a00 de52ff04 de52ff5c c34f7f5c ddaa77f4 00000000 00000000
       00000001 00000000 00000000 00000100 00000000 00000000 00000000 00000041
       00000001 de52ff04 c1820a00 c1820a00 c0200335 c1820a00 de52ff04 de52ff40
Call Trace: [<c0200335>] [<c01fd26a>] [<c01f9991>] [<c0107d6c>] [<c0107ed2>]
   [<c0109c68>]
Code: 0f b6 38 0f b6 83 38 01 00 00 83 f8 07 74 1e 7f 0c 83 f8 01

>>EIP; c02007f2 <ahc_parse_msg+46/64c>   <=====
Trace; c0200334 <ahc_handle_message_phase+270/654>
Trace; c01fd26a <ahc_handle_seqint+9aa/118c>
Trace; c01f9990 <ahc_linux_isr+1a0/29c>
ce; c0107d6c <handle_IRQ_event+30/5c>
Trace; c0107ed2 <do_IRQ+6a/a8>
Trace; c0109c68 <call_do_IRQ+6/e>
Code;  c02007f2 <ahc_parse_msg+46/64c>
00000000 <_EIP>:
Code;  c02007f2 <ahc_parse_msg+46/64c>   <=====
   0:   0f b6 38                  movzbl (%eax),%edi   <=====
Code;  c02007f4 <ahc_parse_msg+48/64c>
   3:   0f b6 83 38 01 00 00      movzbl 0x138(%ebx),%eax
Code;  c02007fc <ahc_parse_msg+50/64c>
   a:   83 f8 07                  cmp    $0x7,%eax
Code;  c02007fe <ahc_parse_msg+52/64c>
   d:   74 1e                     je     2d <_EIP+0x2d> c020081e <ahc_parse_msg+72/64c>
Code;  c0200800 <ahc_parse_msg+54/64c>
   f:   7f 0c                     jg     1d <_EIP+0x1d> c020080e <ahc_parse_msg+62/64c>
Code;  c0200802 <ahc_parse_msg+56/64c>
  11:   83 f8 01                  cmp    $0x1,%eax

<0>Kernel panic: Aiee, killing interrupt handler!

With the kernel 2.4.14-pre3, an advansys board and the same harddrives I get:
advansys: adv_isr_callback: board 0: scp 0xdfef9600 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9400 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9200 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef8c00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef8400 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef8200 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef8000 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9e00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9c00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9a00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9800 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfefe000 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840e00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840c00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840a00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840800 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840600 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840400 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840200 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840e00 not on active queue

and then an oops:

Unable to handle kernel paging request at virtual address 0186cf34
c01fabb6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01fabb6>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 0186cef0   ebx: 0186d090   ecx: 00000005   edx: c186d090
esi: 0186cf30   edi: c0003084   ebp: c186cef0   esp: dc615f2c
ds: 0018   es: 0018   ss: 0018
Process md5sum (pid: 447, stackpage=dc615000)
Stack: 0186d090 c186d090 c0003084 00000046 c0201d4a c0003084 c186d090 c0003000
       c000307c 00000000 c01f9fdc c0003084 c180eec0 24000001 00000005 dc615fc4
       00000000 00000000 0804e1d8 00000000 c0107d6c 00000005 c000307c dc615fc4
Call Trace: [<c0201d4a>] [<c01f9fdc>] [<c0107d6c>] [<c0107ece>] [<c0109c68>]
Code: 8b 5e 04 8b 15 a0 54 28 c0 31 c0 39 d0 7d 19 39 1d c0 54 28

>>EIP; c01fabb6 <adv_isr_callback+4e/218>   <=====
Trace; c0201d4a <AdvISR+10e/12c>
Trace; c01f9fdc <advansys_interrupt+84/180>
Trace; c0107d6c <handle_IRQ_event+30/5c>
Trace; c0107ece <do_IRQ+6e/b0>
ce; c0109c68 <call_do_IRQ+6/e>
Code;  c01fabb6 <adv_isr_callback+4e/218>
00000000 <_EIP>:
Code;  c01fabb6 <adv_isr_callback+4e/218>   <=====
   0:   8b 5e 04                  mov    0x4(%esi),%ebx   <=====
Code;  c01fabb8 <adv_isr_callback+50/218>
   3:   8b 15 a0 54 28 c0         mov    0xc02854a0,%edx
Code;  c01fabbe <adv_isr_callback+56/218>
   9:   31 c0                     xor    %eax,%eax
Code;  c01fabc0 <adv_isr_callback+58/218>
   b:   39 d0                     cmp    %edx,%eax
Code;  c01fabc2 <adv_isr_callback+5a/218>
   d:   7d 19                     jge    28 <_EIP+0x28> c01fabde <adv_isr_callback+76/218>
Code;  c01fabc4 <adv_isr_callback+5c/218>
   f:   39 1d c0 54 28 00         cmp    %ebx,0x2854c0

<0>Kernel panic: Aiee, killing interrupt handler!

I have enabled "SCSI Logging facility" and "Enable extra checks in new
queueing code" and I've got on the serial console:
Saw underflow (8192 of 126976 bytes). Treated as error
Kernel panic: HOST_MSG_LOOP with invalid SCB b

florin

-- 

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
