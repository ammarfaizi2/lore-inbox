Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293204AbSB1JDo>; Thu, 28 Feb 2002 04:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292965AbSB1JDG>; Thu, 28 Feb 2002 04:03:06 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:38464 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S293203AbSB1JCb> convert rfc822-to-8bit; Thu, 28 Feb 2002 04:02:31 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.18] another oops in smbfs
Date: Thu, 28 Feb 2002 10:02:28 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E16gMSK-0007JJ-00@mrvdomng1.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had an oops in smbfs in 2.4.18. (there was another message from Cyrille 
Chepelov, but with a different call trace)

This oops did not appear with 2.4.17.

[borni@cubus borni]$ ksymoops -m /usr/src/linux-2.4.17/System.map oops
ksymoops 2.4.1 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /usr/src/linux-2.4.17/System.map (specified)

Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says e5bf0050, 
/lib/modules/2.4.17/kernel/drivers/scsi/sr_mod.o says e5befda0.  Ignoring 
/lib/modules/2.4.17/kernel/drivers/scsi/sr_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says 
e09376d0, /lib/modules/2.4.17/kernel/drivers/scsi/scsi_mod.o says e0937104.  
Ignoring /lib/modules/2.4.17/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says 
e09376fc, /lib/modules/2.4.17/kernel/drivers/scsi/scsi_mod.o says e0937130.  
Ignoring /lib/modules/2.4.17/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says 
e09376f8, /lib/modules/2.4.17/kernel/drivers/scsi/scsi_mod.o says e093712c.  
Ignoring /lib/modules/2.4.17/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says 
e0937700, /lib/modules/2.4.17/kernel/drivers/scsi/scsi_mod.o says e0937134.  
Ignoring /lib/modules/2.4.17/kernel/drivers/scsi/scsi_mod.o entry
Unable to handle kernel paging request at virtual address e0000000
c0166d50
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0166d50>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013293
eax: 73f9af07   ebx: cbf21aa9   ecx: f823b3fd   edx: e3febc9b
esi: e0000000   edi: d8cf3e2c   ebp: d8cf3ec0   esp: d8cf3ddc
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 2048, stackpage=d8cf3000)
Stack: 00000000 00000000 00000000 d73e4cc0 d73e64c0 d8cf3dfa 0000000a 000073a1
       e5c30e9a 00000000 0000301e deb19e40 00000000 00000000 d73a5000 00000023
       00000000 00000000 00000001 00000025 d8cf3e90 00000001 e5c30f0a e5c3004a
Call Trace: [<c01655fb>] [<c013d570>] [<c016654e>] [<c013d570>] [<c013d1a8>]
   [<c013d570>] [<c013d6ff>] [<c013d570>] [<c0106d0b>]
Code: 0f b6 06 49 46 89 c2 c1 e2 04 c1 e8 04 8d 14 1a 01 c2 8d 04

>>EIP; c0166d50 <smb_read_super+40/2e0>   <=====
Trace; c01655fb <smb_fill_cache+23b/300>
Trace; c013d570 <wait_for_partner+10/30>
Trace; c016654e <smb_send_trans2+22e/250>
Trace; c013d570 <wait_for_partner+10/30>
Trace; c013d1a8 <do_poll+c8/100>
Trace; c013d570 <wait_for_partner+10/30>
Trace; c013d6ff <fifo_open+14f/230>
Trace; c013d570 <wait_for_partner+10/30>
Trace; c0106d0b <ret_from_sys_call+b/11>
Code;  c0166d50 <smb_read_super+40/2e0>
00000000 <_EIP>:
Code;  c0166d50 <smb_read_super+40/2e0>   <=====
   0:   0f b6 06                  movzbl (%esi),%eax   <=====
Code;  c0166d53 <smb_read_super+43/2e0>
   3:   49                        dec    %ecx
Code;  c0166d54 <smb_read_super+44/2e0>
   4:   46                        inc    %esi
Code;  c0166d55 <smb_read_super+45/2e0>
   5:   89 c2                     mov    %eax,%edx
Code;  c0166d57 <smb_read_super+47/2e0>
   7:   c1 e2 04                  shl    $0x4,%edx
Code;  c0166d5a <smb_read_super+4a/2e0>
   a:   c1 e8 04                  shr    $0x4,%eax
Code;  c0166d5d <smb_read_super+4d/2e0>
   d:   8d 14 1a                  lea    (%edx,%ebx,1),%edx
Code;  c0166d60 <smb_read_super+50/2e0>
  10:   01 c2                     add    %eax,%edx
Code;  c0166d62 <smb_read_super+52/2e0>
  12:   8d 04 00                  lea    (%eax,%eax,1),%eax


5 warnings issued.  Results may not be reliable.

greetings

Christian Bornträger
