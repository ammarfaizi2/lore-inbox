Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbTIBMSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTIBMSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:18:15 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:42384 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S261370AbTIBMRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:17:34 -0400
Date: Tue, 2 Sep 2003 13:17:27 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel bug in 2.6.0-test4-mm4 when removing USB flash disc
Message-ID: <20030902121727.GA340@malvern.uk.w2k.superh.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-OS: Linux 2.6.0-test4-mm4 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 02 Sep 2003 12:18:05.0764 (UTC) FILETIME=[43559040:01C3714C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Report below. (Everything is compiled in, I'm not using modules at all
at the moment)  This was when I pulled the flash disc out of the USB
socket.

ksymoops 2.4.9 on i686 2.6.0-test4-mm4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.6.0-test4-mm4/ (default)
     -m /boot/260t4mm4_1/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
kernel BUG at mm/slab.c:1623!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c013fa45>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000031   ebx: 000ab6b6   ecx: 00000001   edx: c04808ac
esi: c04c6320   edi: 6b6b6b6b   ebp: d3e4fdbc   esp: d3e4fd8c
ds: 007b   es: 007b   ss: 0068
Stack: c03d54c0 6b6b6b6b ca451a04 c04c6320 d6a71000 0019aca8 00000286 d3e4fdbc 
       c02a2ef1 ca451984 ca451a04 00000202 d3e4fdd0 c022e097 6b6b6b6b c04cc398 
       cee44760 d3e4fddc c022e0be ca451a04 d3e4fde8 c02a325f ca451a04 d3e4fe1c 
Call Trace:
 [<c02a2ef1>] disk_release+0x29/0x34
 [<c022e097>] kobject_cleanup+0x4b/0x5c
 [<c022e0be>] kobject_put+0x16/0x1c
 [<c02a325f>] put_disk+0x13/0x18
 [<c02db4ce>] sg_remove+0x182/0x1b4
 [<c029cfda>] class_device_del+0x82/0xd8
 [<c029d03d>] class_device_unregister+0xd/0x1c
 [<c02d46d5>] scsi_remove_device+0x21/0xa0
 [<c02d3f3a>] scsi_forget_host+0x16/0x2c
 [<c02ce95f>] scsi_remove_host+0x1b/0x6c
 [<c030dd7a>] storage_disconnect+0x2e/0x3b
 [<c02f76ee>] usb_unbind_interface+0x5e/0x90
 [<c029c488>] device_release_driver+0x48/0x58
 [<c029c5c3>] bus_remove_device+0x53/0x9c
 [<c02fd0f6>] usb_disable_endpoint+0x2a/0x64
 [<c029b57a>] device_del+0x6a/0x90
 [<c029b5ad>] device_unregister+0xd/0x1c
 [<c02f8196>] usb_disconnect+0xb6/0xfc
 [<c02fa2d3>] hub_port_connect_change+0x57/0x2e8
 [<c02f9f03>] hub_port_status+0x27/0x84
 [<c02fa688>] hub_events+0x124/0x2d8
 [<c02fa868>] hub_thread+0x2c/0xe4
 [<c02fa83c>] hub_thread+0x0/0xe4
 [<c011d5b0>] default_wake_function+0x0/0x20
 [<c010ad85>] kernel_thread_helper+0x5/0xc
Code: 7d 08 85 ff 0f 84 92 02 00 00 9c 8f 45 fc fa 8d 9f 00 00 00 40 c1 eb 0c 3b 1d cc 09 55 c0 72 16 57 68 c0 54 3d c0 e8 43 15 fe ff <0f> 0b 57 06 87 51 3d c0 83 c4 08 8d 04 9b c1 e0 03 89 45 f8 03 


>>EIP; c013fa45 <kfree+35/2b0>   <=====

>>edx; c04808ac <log_wait+4/c>
>>esi; c04c6320 <block_subsys+0/58>
>>ebp; d3e4fdbc <_end+138d4a78/3fa81cbc>
>>esp; d3e4fd8c <_end+138d4a48/3fa81cbc>

Trace; c02a2ef1 <disk_release+29/34>
Trace; c022e097 <kobject_cleanup+4b/5c>
Trace; c022e0be <kobject_put+16/1c>
Trace; c02a325f <put_disk+13/18>
Trace; c02db4ce <sg_remove+182/1b4>
Trace; c029cfda <class_device_del+82/d8>
Trace; c029d03d <class_device_unregister+d/1c>
Trace; c02d46d5 <scsi_remove_device+21/a0>
Trace; c02d3f3a <scsi_forget_host+16/2c>
Trace; c02ce95f <scsi_remove_host+1b/6c>
Trace; c030dd7a <storage_disconnect+2e/3b>
Trace; c02f76ee <usb_unbind_interface+5e/90>
Trace; c029c488 <device_release_driver+48/58>
Trace; c029c5c3 <bus_remove_device+53/9c>
Trace; c02fd0f6 <usb_disable_endpoint+2a/64>
Trace; c029b57a <device_del+6a/90>
Trace; c029b5ad <device_unregister+d/1c>
Trace; c02f8196 <usb_disconnect+b6/fc>
Trace; c02fa2d3 <hub_port_connect_change+57/2e8>
Trace; c02f9f03 <hub_port_status+27/84>
Trace; c02fa688 <hub_events+124/2d8>
Trace; c02fa868 <hub_thread+2c/e4>
Trace; c02fa83c <hub_thread+0/e4>
Trace; c011d5b0 <default_wake_function+0/20>
Trace; c010ad85 <kernel_thread_helper+5/c>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c013fa1a <kfree+a/2b0>
00000000 <_EIP>:
Code;  c013fa1a <kfree+a/2b0>
   0:   7d 08                     jge    a <_EIP+0xa> c013fa24 <kfree+14/2b0>
Code;  c013fa1c <kfree+c/2b0>
   2:   85 ff                     test   %edi,%edi
Code;  c013fa1e <kfree+e/2b0>
   4:   0f 84 92 02 00 00         je     29c <_EIP+0x29c> c013fcb6 <kfree+2a6/2b0>
Code;  c013fa24 <kfree+14/2b0>
   a:   9c                        pushf  
Code;  c013fa25 <kfree+15/2b0>
   b:   8f 45 fc                  popl   0xfffffffc(%ebp)
Code;  c013fa28 <kfree+18/2b0>
   e:   fa                        cli    
Code;  c013fa29 <kfree+19/2b0>
   f:   8d 9f 00 00 00 40         lea    0x40000000(%edi),%ebx
Code;  c013fa2f <kfree+1f/2b0>
  15:   c1 eb 0c                  shr    $0xc,%ebx
Code;  c013fa32 <kfree+22/2b0>
  18:   3b 1d cc 09 55 c0         cmp    0xc05509cc,%ebx
Code;  c013fa38 <kfree+28/2b0>
  1e:   72 16                     jb     36 <_EIP+0x36> c013fa50 <kfree+40/2b0>
Code;  c013fa3a <kfree+2a/2b0>
  20:   57                        push   %edi
Code;  c013fa3b <kfree+2b/2b0>
  21:   68 c0 54 3d c0            push   $0xc03d54c0
Code;  c013fa40 <kfree+30/2b0>
  26:   e8 43 15 fe ff            call   fffe156e <_EIP+0xfffe156e> c0120f88 <printk+0/168>

This decode from eip onwards should be reliable

Code;  c013fa45 <kfree+35/2b0>
00000000 <_EIP>:
Code;  c013fa45 <kfree+35/2b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013fa47 <kfree+37/2b0>
   2:   57                        push   %edi
Code;  c013fa48 <kfree+38/2b0>
   3:   06                        push   %es
Code;  c013fa49 <kfree+39/2b0>
   4:   87 51 3d                  xchg   %edx,0x3d(%ecx)
Code;  c013fa4c <kfree+3c/2b0>
   7:   c0 83 c4 08 8d 04 9b      rolb   $0x9b,0x48d08c4(%ebx)
Code;  c013fa53 <kfree+43/2b0>
   e:   c1 e0 03                  shl    $0x3,%eax
Code;  c013fa56 <kfree+46/2b0>
  11:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  c013fa59 <kfree+49/2b0>
  14:   03                        .byte 0x3


1 error issued.  Results may not be reliable.

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Report below. (Everything is compiled in, I'm not using modules at all
at the moment)  This was when I pulled the flash disc out of the USB
socket.

ksymoops 2.4.9 on i686 2.6.0-test4-mm4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.6.0-test4-mm4/ (default)
     -m /boot/260t4mm4_1/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
kernel BUG at mm/slab.c:1623!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c013fa45>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000031   ebx: 000ab6b6   ecx: 00000001   edx: c04808ac
esi: c04c6320   edi: 6b6b6b6b   ebp: d3e4fdbc   esp: d3e4fd8c
ds: 007b   es: 007b   ss: 0068
Stack: c03d54c0 6b6b6b6b ca451a04 c04c6320 d6a71000 0019aca8 00000286 d3e4fdbc 
       c02a2ef1 ca451984 ca451a04 00000202 d3e4fdd0 c022e097 6b6b6b6b c04cc398 
       cee44760 d3e4fddc c022e0be ca451a04 d3e4fde8 c02a325f ca451a04 d3e4fe1c 
Call Trace:
 [<c02a2ef1>] disk_release+0x29/0x34
 [<c022e097>] kobject_cleanup+0x4b/0x5c
 [<c022e0be>] kobject_put+0x16/0x1c
 [<c02a325f>] put_disk+0x13/0x18
 [<c02db4ce>] sg_remove+0x182/0x1b4
 [<c029cfda>] class_device_del+0x82/0xd8
 [<c029d03d>] class_device_unregister+0xd/0x1c
 [<c02d46d5>] scsi_remove_device+0x21/0xa0
 [<c02d3f3a>] scsi_forget_host+0x16/0x2c
 [<c02ce95f>] scsi_remove_host+0x1b/0x6c
 [<c030dd7a>] storage_disconnect+0x2e/0x3b
 [<c02f76ee>] usb_unbind_interface+0x5e/0x90
 [<c029c488>] device_release_driver+0x48/0x58
 [<c029c5c3>] bus_remove_device+0x53/0x9c
 [<c02fd0f6>] usb_disable_endpoint+0x2a/0x64
 [<c029b57a>] device_del+0x6a/0x90
 [<c029b5ad>] device_unregister+0xd/0x1c
 [<c02f8196>] usb_disconnect+0xb6/0xfc
 [<c02fa2d3>] hub_port_connect_change+0x57/0x2e8
 [<c02f9f03>] hub_port_status+0x27/0x84
 [<c02fa688>] hub_events+0x124/0x2d8
 [<c02fa868>] hub_thread+0x2c/0xe4
 [<c02fa83c>] hub_thread+0x0/0xe4
 [<c011d5b0>] default_wake_function+0x0/0x20
 [<c010ad85>] kernel_thread_helper+0x5/0xc
Code: 7d 08 85 ff 0f 84 92 02 00 00 9c 8f 45 fc fa 8d 9f 00 00 00 40 c1 eb 0c 3b 1d cc 09 55 c0 72 16 57 68 c0 54 3d c0 e8 43 15 fe ff <0f> 0b 57 06 87 51 3d c0 83 c4 08 8d 04 9b c1 e0 03 89 45 f8 03 


>>EIP; c013fa45 <kfree+35/2b0>   <=====

>>edx; c04808ac <log_wait+4/c>
>>esi; c04c6320 <block_subsys+0/58>
>>ebp; d3e4fdbc <_end+138d4a78/3fa81cbc>
>>esp; d3e4fd8c <_end+138d4a48/3fa81cbc>

Trace; c02a2ef1 <disk_release+29/34>
Trace; c022e097 <kobject_cleanup+4b/5c>
Trace; c022e0be <kobject_put+16/1c>
Trace; c02a325f <put_disk+13/18>
Trace; c02db4ce <sg_remove+182/1b4>
Trace; c029cfda <class_device_del+82/d8>
Trace; c029d03d <class_device_unregister+d/1c>
Trace; c02d46d5 <scsi_remove_device+21/a0>
Trace; c02d3f3a <scsi_forget_host+16/2c>
Trace; c02ce95f <scsi_remove_host+1b/6c>
Trace; c030dd7a <storage_disconnect+2e/3b>
Trace; c02f76ee <usb_unbind_interface+5e/90>
Trace; c029c488 <device_release_driver+48/58>
Trace; c029c5c3 <bus_remove_device+53/9c>
Trace; c02fd0f6 <usb_disable_endpoint+2a/64>
Trace; c029b57a <device_del+6a/90>
Trace; c029b5ad <device_unregister+d/1c>
Trace; c02f8196 <usb_disconnect+b6/fc>
Trace; c02fa2d3 <hub_port_connect_change+57/2e8>
Trace; c02f9f03 <hub_port_status+27/84>
Trace; c02fa688 <hub_events+124/2d8>
Trace; c02fa868 <hub_thread+2c/e4>
Trace; c02fa83c <hub_thread+0/e4>
Trace; c011d5b0 <default_wake_function+0/20>
Trace; c010ad85 <kernel_thread_helper+5/c>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c013fa1a <kfree+a/2b0>
00000000 <_EIP>:
Code;  c013fa1a <kfree+a/2b0>
   0:   7d 08                     jge    a <_EIP+0xa> c013fa24 <kfree+14/2b0>
Code;  c013fa1c <kfree+c/2b0>
   2:   85 ff                     test   %edi,%edi
Code;  c013fa1e <kfree+e/2b0>
   4:   0f 84 92 02 00 00         je     29c <_EIP+0x29c> c013fcb6 <kfree+2a6/2b0>
Code;  c013fa24 <kfree+14/2b0>
   a:   9c                        pushf  
Code;  c013fa25 <kfree+15/2b0>
   b:   8f 45 fc                  popl   0xfffffffc(%ebp)
Code;  c013fa28 <kfree+18/2b0>
   e:   fa                        cli    
Code;  c013fa29 <kfree+19/2b0>
   f:   8d 9f 00 00 00 40         lea    0x40000000(%edi),%ebx
Code;  c013fa2f <kfree+1f/2b0>
  15:   c1 eb 0c                  shr    $0xc,%ebx
Code;  c013fa32 <kfree+22/2b0>
  18:   3b 1d cc 09 55 c0         cmp    0xc05509cc,%ebx
Code;  c013fa38 <kfree+28/2b0>
  1e:   72 16                     jb     36 <_EIP+0x36> c013fa50 <kfree+40/2b0>
Code;  c013fa3a <kfree+2a/2b0>
  20:   57                        push   %edi
Code;  c013fa3b <kfree+2b/2b0>
  21:   68 c0 54 3d c0            push   $0xc03d54c0
Code;  c013fa40 <kfree+30/2b0>
  26:   e8 43 15 fe ff            call   fffe156e <_EIP+0xfffe156e> c0120f88 <printk+0/168>

This decode from eip onwards should be reliable

Code;  c013fa45 <kfree+35/2b0>
00000000 <_EIP>:
Code;  c013fa45 <kfree+35/2b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013fa47 <kfree+37/2b0>
   2:   57                        push   %edi
Code;  c013fa48 <kfree+38/2b0>
   3:   06                        push   %es
Code;  c013fa49 <kfree+39/2b0>
   4:   87 51 3d                  xchg   %edx,0x3d(%ecx)
Code;  c013fa4c <kfree+3c/2b0>
   7:   c0 83 c4 08 8d 04 9b      rolb   $0x9b,0x48d08c4(%ebx)
Code;  c013fa53 <kfree+43/2b0>
   e:   c1 e0 03                  shl    $0x3,%eax
Code;  c013fa56 <kfree+46/2b0>
  11:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  c013fa59 <kfree+49/2b0>
  14:   03                        .byte 0x3


1 error issued.  Results may not be reliable.

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
