Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263011AbTDBVAl>; Wed, 2 Apr 2003 16:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263138AbTDBVAl>; Wed, 2 Apr 2003 16:00:41 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:50507 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S263011AbTDBVAc>; Wed, 2 Apr 2003 16:00:32 -0500
Date: Wed, 02 Apr 2003 13:12:42 -0800
From: Nehal <nehal@canada.com>
Subject: Re: mount hfs on SCSI cdrom = segfault
In-reply-to: <200304022237.54304.kiza@gmx.net>
To: Oliver Feiler <kiza@gmx.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <3E8B524A.1060605@canada.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
References: <3E87477C.3050208@canada.com> <200304022101.40921.kiza@gmx.net>
 <3E8B36A2.8030801@canada.com> <200304022237.54304.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok you are right! i set hdc=scsi, reboot, and mounted my
ide cdrom drive (device /dev/scd1) as hfs, and boom
it crashed with same message :)  this is good, at least
i know its not my scsi drive/controller at fault

so definitely a bug in scsi somehow or somewhere,
so i guess anyone with a hfs cd can reproduce, so
somebody please fix :)

btw Oliver, once u type eject, if it fails, u can just
press the eject button on your drive and it should
open.... although the drive is still unusable
until u reboot

thx, Nehal

>On Wednesday 02 April 2003 21:14, Nehal wrote:
>  
>
>>yes, that's the one! its in grow_buffers ... there are 3 BUG() 's in
>>this function, but my guess he is getting the same BUG()
>>
>>hmm, he didnt specify his cd-rom drive... but could it be
>>part of the problem?
>>    
>>
>
>It was me who posted this previous message. :)
>
>I don't think it is drive dependent. But it may have something to do with SCSI 
>since it works for you with IDE and oopses with SCSI. I just reproduced the 
>oops with a
>hdc: HL-DT-ST RW/DVD GCC-4120B, ATAPI CD/DVD-ROM drive
>IDE drive running via ide-scsi. Same oops again, see below. Yes I know with 
>NVdriver, but the oops is the same with and without. Now the disc isn't 
>mounted, the drive door is locked and 'eject /dev/cdrom' gives
>
>eject: CDROMEJECT ioctl failed for `/dev/scsi/host1/bus0/target0/lun0/cd': 
>Device or resource busy
>
>
>
>kernel BUG at buffer.c:2497!
>invalid operand: 0000
>CPU:    0
>EIP:    0010:[<c0136e5e>]    Tainted: P 
>Using defaults from ksymoops -t elf32-i386 -a i386
>EFLAGS: 00010206
>eax: 000007ff   ebx: 0000000b   ecx: 00000800   edx: c15dd700
>esi: 00000002   edi: 00000b02   ebp: 00000000   esp: ccf01dbc
>ds: 0018   es: 0018   ss: 0018
>Process mount (pid: 4975, stackpage=ccf01000)
>Stack: 00000b02 00000200 00000000 00000001 00004480 c0134fb7 00000b02 00000000 
>       00000200 00000b02 d01cac00 00000000 c01351d8 00000b02 00000000 00000200 
>       00000000 e1cb45c3 00000b02 00000000 00000200 00000b02 00000001 00000000 
>Call Trace:    [<c0134fb7>] [<c01351d8>] [<e1cb45c3>] [<e1cb3839>] 
>[<e1cb4443>]
>  [<c01ef6ed>] [<c01380e0>] [<e1cb7fe4>] [<e1cb7fe4>] [<c01382bb>] 
>[<e1cb7fe4>]
>  [<c0148059>] [<c0148332>] [<c014817d>] [<c01486b4>] [<c010870b>]
>Code: 0f 0b c1 09 00 e2 25 c0 8b 44 24 20 05 00 fe ff ff 3d 00 0e 
>
>
>  
>
>>>EIP; c0136e5e <grow_buffers+3e/110>   <=====
>>>      
>>>
>
>  
>
>>>eax; 000007ff Before first symbol
>>>ecx; 00000800 Before first symbol
>>>edx; c15dd700 <_end+12b4ae4/2051c3e4>
>>>edi; 00000b02 Before first symbol
>>>esp; ccf01dbc <_end+cbd91a0/2051c3e4>
>>>      
>>>
>
>Trace; c0134fb7 <getblk+27/40>
>Trace; c01351d8 <bread+18/70>
>Trace; e1cb45c3 <[hfs]hfs_buffer_get+23/80>
>Trace; e1cb3839 <[hfs]hfs_part_find+19/170>
>Trace; e1cb4443 <[hfs]hfs_read_super+73/190>
>Trace; c01ef6ed <media_changed+3d/70>
>Trace; c01380e0 <get_sb_bdev+210/280>
>Trace; e1cb7fe4 <[hfs]hfs_fs+0/1c>
>Trace; e1cb7fe4 <[hfs]hfs_fs+0/1c>
>Trace; c01382bb <do_kern_mount+5b/110>
>Trace; e1cb7fe4 <[hfs]hfs_fs+0/1c>
>Trace; c0148059 <do_add_mount+69/140>
>Trace; c0148332 <do_mount+162/180>
>Trace; c014817d <copy_mount_options+4d/a0>
>Trace; c01486b4 <sys_mount+84/d0>
>Trace; c010870b <system_call+33/38>
>
>Code;  c0136e5e <grow_buffers+3e/110>
>00000000 <_EIP>:
>Code;  c0136e5e <grow_buffers+3e/110>   <=====
>   0:   0f 0b                     ud2a      <=====
>Code;  c0136e60 <grow_buffers+40/110>
>   2:   c1 09 00                  rorl   $0x0,(%ecx)
>Code;  c0136e63 <grow_buffers+43/110>
>   5:   e2 25                     loop   2c <_EIP+0x2c> c0136e8a 
><grow_buffers+6a/110>
>Code;  c0136e65 <grow_buffers+45/110>
>   7:   c0 8b 44 24 20 05 00      rorb   $0x0,0x5202444(%ebx)
>Code;  c0136e6c <grow_buffers+4c/110>
>   e:   fe                        (bad)  
>Code;  c0136e6d <grow_buffers+4d/110>
>   f:   ff                        (bad)  
>Code;  c0136e6e <grow_buffers+4e/110>
>  10:   ff                        (bad)  
>Code;  c0136e6f <grow_buffers+4f/110>
>  11:   3d 00 0e 00 00            cmp    $0xe00,%eax
>
>
>2 warnings issued.  Results may not be reliable.
>
>
>  
>
>>Nehal
>>
>>    
>>
>>>Hi,
>>>
>>>is this the same problem as this one?
>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=102890250915062&w=2
>>>
>>>Nobody ever answered on that, though.
>>>
>>>On Wednesday 02 April 2003 12:49, Randy.Dunlap wrote:
>>>      
>>>
>>>>First post said Linux 2.4.20... that's good info.
>>>>That info has been deleted from subsequent postings.
>>>>
>>>>Would it make sense for the BUG() message to include a kernel
>>>>version number???  I'm wondering since people do omit that data.
>>>>
>>>>~Randy
>>>>
>>>>On Wed, 02 Apr 2003 10:15:21 -0800 Nehal <nehal@canada.com> wrote:
>>>>| > i have a hybrid cd (both HFS, ISO9660) , i have two CD drives,
>>>>| > one IDE CD-Rom (actima 32x), and one SCSI CD-burner (yamaha 6416)
>>>>| > on an advansys cfg-510 ISA scsi card
>>>>| >
>>>>| > when i try to mount on IDE using hfs with:
>>>>| >
>>>>| >    mount -v -r -t hfs /dev/hdc /cdrom
>>>>| >
>>>>| > it works fine, yet when i try on scsi with:
>>>>| >
>>>>| >    mount -v -r -t hfs /dev/scd0 /cdrom
>>>>| >
>>>>| > i get a "Segmentation fault" error, no more output given,
>>>>| > it also locks the drive, and sometimes i can use the
>>>>| > 'eject' command to eject it, sometimes i cant and i gotta reboot
>>>>| >
>>>>| > note: when i try to mount the cd using regular iso9660 fs, it
>>>>| > works perfectly on both cd drives,
>>>>| > also i have tried 2 hybrid cd's, both times i have trouble mounting
>>>>| > hfs on the scsi drive only
>>>>| >
>>>>| > Nehal
>>>>|
>>>>| ok i updated firmware of writer from 1.0c to 1.0d with no help,
>>>>| but i found when i do 'dmesg' after mounting i get this error:
>>>>| ========
>>>>| kernel BUG at buffer.c:2518!
>>>>| invalid operand: 0000
>>>>| CPU:    0
>>>>| EIP:    0010:[<c013c329>]    Not tainted
>>>>| EFLAGS: 00013206
>>>>| eax: 000007ff   ebx: 00000b00   ecx: 00000800   edx: c11ee640
>>>>| esi: 00000b00   edi: 00000200   ebp: 00000b00   esp: c3425db4
>>>>| ds: 0018   es: 0018   ss: 0018
>>>>| Process mount (pid: 514, stackpage=c3425000)
>>>>| Stack: c6d0d760 c3425e48 c0257a59 c7f1c574 00000000 00000b00 00000200
>>>>| 00000000
>>>>|        c0139f66 00000b00 00000000 00000200 00000000 00000001 c7568400
>>>>| 00000000
>>>>|        c013a1e0 00000b00 00000000 00000200 00000000 c019280a 00000b00
>>>>| 00000000
>>>>| Call Trace:    [<c0257a59>] [<c0139f66>] [<c013a1e0>] [<c019280a>]
>>>>| [<c019188a>]
>>>>|   [<c01925ff>] [<c0285c30>] [<c013cdca>] [<c013e908>] [<c013d64b>]
>>>>| [<c013cd3c>]
>>>>|   [<c013d9a1>] [<c014fcf3>] [<c0150020>] [<c014fe69>] [<c0150441>]
>>>>| [<c01090ff>]
>>>>|
>>>>| Code: 0f 0b d6 09 9a 2b 33 c0 8d 87 00 fe ff ff 3d 00 0e 00 00 76
>>>>|
>>>>| root@Nehal:~#
>>>>| ========
>>>>| then when i try it again it doesnt give this message, it locks up my
>>>>| drive
>>>>|
>>>>| can someone please help debug this problem,
>>>>| thx, Nehal
>>>>
>>>>-
>>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>>>>in the body of a message to majordomo@vger.kernel.org
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>>        
>>>>
>
>  
>


