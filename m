Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbTDFUoI (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTDFUoI (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:44:08 -0400
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:62192
	"EHLO flat") by vger.kernel.org with ESMTP id S263074AbTDFUoG (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 16:44:06 -0400
Date: Sun, 6 Apr 2003 21:55:39 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-pre6] [USB] Oops during reload of usb-uhci (maybe bluetooth related???)
Message-ID: <20030406205539.GA6766@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


USB was previously used for bluetooth (hci-usb.o etc) and stopped working.
Usbnet to Zaurus SL-5000D, also not working so I Attempted to restart hotplug
package (/etc/init.d/hotplug restart) and got this oops when the script ran
modprobe -q usb-uhci.

Can't build 2.4.21-pre7, so waiting on -pre8 to retest. (Shouldn't there be bk
snapshots available somewhere?)

---------------------------------------
ksymoops 2.4.8 on i686 2.4.21-pre6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre6/ (default)
     -m /boot/System.map-2.4.21-pre6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.21-pre6 failed
kernel BUG at slab.c:815!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131a7d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c12c7a74   ecx: c12c7a00   edx: c12c7a6c
esi: c12c7a66   edi: d093636f   ebp: c12c7a6c   esp: c4e65ed0
ds: 0018   es: 0018   ss: 0018
Process modprobe.moduti (pid: 13667, stackpage=c4e65000)
Stack: 00000000 0000003c 00000000 c4e65ee8 c12c7a94 fffffffc 00000038 fffffff4 
       00000001 00000001 d0931000 d0935e15 d0936361 0000003c 00000040 00000000 
       00000000 00000000 ffffffea c011bf76 d0931060 080873f0 000063b0 d0937298 
Call Trace:    [<d0935e15>] [<d0936361>] [<c011bf76>] [<d0931060>] [<d0937298>]
  [<d0931060>] [<c010733f>]
Code: 0f 0b 2f 03 c1 0a 25 c0 8b 01 89 ca 89 c1 0f 0d 00 81 fa 44 


>>EIP; c0131a7d <kmem_cache_create+2bd/430>   <=====

>>ebx; c12c7a74 <___strtok+fb35a0/105efbac>
>>ecx; c12c7a00 <___strtok+fb352c/105efbac>
>>edx; c12c7a6c <___strtok+fb3598/105efbac>
>>esi; c12c7a66 <___strtok+fb3592/105efbac>
>>edi; d093636f <[uhci].text.end+3f0/11a1>
>>ebp; c12c7a6c <___strtok+fb3598/105efbac>
>>esp; c4e65ed0 <___strtok+4b519fc/105efbac>

Trace; d0935e15 <[uhci]uhci_hcd_init+b5/140>
Trace; d0936361 <[uhci].text.end+3e2/11a1>
Trace; c011bf76 <inter_module_put+706/850>
Trace; d0931060 <[usbcore]usb_minors+1e00/1e20>
Trace; d0937298 <[uhci]__module_license+3d/85>
Trace; d0931060 <[usbcore]usb_minors+1e00/1e20>
Trace; c010733f <__up_wakeup+128f/1660>

Code;  c0131a7d <kmem_cache_create+2bd/430>
00000000 <_EIP>:
Code;  c0131a7d <kmem_cache_create+2bd/430>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0131a7f <kmem_cache_create+2bf/430>
   2:   2f                        das    
Code;  c0131a80 <kmem_cache_create+2c0/430>
   3:   03 c1                     add    %ecx,%eax
Code;  c0131a82 <kmem_cache_create+2c2/430>
   5:   0a 25 c0 8b 01 89         or     0x89018bc0,%ah
Code;  c0131a88 <kmem_cache_create+2c8/430>
   b:   ca 89 c1                  lret   $0xc189
Code;  c0131a8b <kmem_cache_create+2cb/430>
   e:   0f 0d 00                  prefetch (%eax)
Code;  c0131a8e <kmem_cache_create+2ce/430>
  11:   81 fa 44 00 00 00         cmp    $0x44,%edx


1 warning and 1 error issued.  Results may not be reliable.
