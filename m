Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269064AbUIHJVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269064AbUIHJVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269058AbUIHJUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:20:50 -0400
Received: from tag.witbe.net ([81.88.96.48]:1946 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S269046AbUIHJTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:19:49 -0400
Message-Id: <200409080919.i889Jmq09954@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [2.4.27] - Kernel bug - slab.c:815
Date: Wed, 8 Sep 2004 11:19:50 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSVhP4gxEACKUOlS6GPrkgvkTtg0Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've just experienced the following "Kernel bug" when plugging a USB
device on my machine.

kernel BUG at slab.c:815!
invalid operand: 0000
CPU:    0
EIP:    0010:[kmem_cache_create+779/864]    Not tainted 
EIP:    0010:[<c0132bdb>]    Not tainted 
EFLAGS: 00010246
eax: 00000000   ebx: c1677154   ecx: c16772b4   edx: c16773a8
esi: c16772aa   edi: e09102f4   ebp: c16772b4   esp: c177de54
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 7, stackpage=c177d000)
Stack: c177de58 00000058 dc07a800 00000000 0000001c c0406d60 e09016ab
e09102ea 
       00003f88 00000020 00000000 00000000 00000000 c177c000 dfb46000
20000305
       dfeba000 00000000 00000000 dd686200 80000500 de8266e0 00000282
00000000 
Call Trace:    [<e09016ab>] [<e09102ea>] [iget4_locked+233/256] [<e09012ce>]
[<e
0909afc>]      
Call Trace:    [<e09016ab>] [<e09102ea>] [<c0153a39>] [<e09012ce>]
[<e0909afc>]
  [<e0910960>] [<e0910980>] [usb_find_interface_driver+319/496] [<e0909afc>]
[us
b_find_drivers+57/128] [usb_new_device+388/400]
  [<e0910960>] [<e0910980>] [<c025380f>] [<e0909afc>] [<c0253929>]
[<c0255864>]
  [printk+296/320] [usb_hub_port_connect_change+423/560]
[usb_hub_events+265/720
] [free_uid+20/80] [usb_hub_thread+85/256] [_stext+0/80]
  [<c011ad28>] [<c0257027>] [<c02571b9>] [<c01239f4>] [<c02573d5>]
[<c0105000>]
  [arch_kernel_thread+38/48] [usb_hub_thread+0/256]
  [<c0107216>] [<c0257380>]

Code: 0f 0b 2f 03 8d b2 31 c0 89 d1 8b 01 89 c2 0f 18 02 81 f9 6c

Decoded, this gives :

>>EIP; c0132bdb <kmem_cache_create+30b/360>   <=====
Trace; e09016ab <[eagle-usb]eu_init_postfirm+287/6ac>
Trace; e09102ea <[eagle-usb].LC32+78a/e00>
Trace; e09016ab <[eagle-usb]eu_init_postfirm+287/6ac>
Trace; e09102ea <[eagle-usb].LC32+78a/e00>
Trace; c0153a39 <iget4_locked+e9/100>
Trace; e09012ce <[eagle-usb]eu_probe+196/1bc>
Trace; e0909afc <[eagle-usb].LC12+7/9>
Trace; e0910960 <[eagle-usb]eu_driver+0/0>
Trace; e0910980 <[eagle-usb].data.start+20/3c>
Trace; e0910960 <[eagle-usb]eu_driver+0/0>
Trace; e0910980 <[eagle-usb].data.start+20/3c>
Trace; c025380f <usb_find_interface_driver+13f/1f0>
Trace; e0909afc <[eagle-usb].LC12+7/9>
Trace; c0253929 <usb_find_drivers+39/80>
Trace; c0255864 <usb_new_device+184/190>
Trace; c011ad28 <printk+128/140>
Trace; c0257027 <usb_hub_port_connect_change+1a7/230>
Trace; c02571b9 <usb_hub_events+109/2d0>
Trace; c01239f4 <free_uid+14/50>
Trace; c02573d5 <usb_hub_thread+55/100>
Trace; c0105000 <_stext+0/0>
Trace; c0107216 <arch_kernel_thread+26/30>
Trace; c0257380 <usb_hub_thread+0/100>
Code;  c0132bdb <kmem_cache_create+30b/360>
00000000 <_EIP>:
Code;  c0132bdb <kmem_cache_create+30b/360>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0132bdd <kmem_cache_create+30d/360>
   2:   2f                        das    
Code;  c0132bde <kmem_cache_create+30e/360>
   3:   03 8d b2 31 c0 89         add    0x89c031b2(%ebp),%ecx
Code;  c0132be4 <kmem_cache_create+314/360>
   9:   d1 8b 01 89 c2 0f         rorl   0xfc28901(%ebx)
Code;  c0132bea <kmem_cache_create+31a/360>
   f:   18 02                     sbb    %al,(%edx)
Code;  c0132bec <kmem_cache_create+31c/360>
  11:   81 f9 6c 00 00 00         cmp    $0x6c,%ecx

Just before, the traces I had in /var/log/messages are :
hub.c: new USB device 00:1d.1-2, assigned address 4
[eagle-usb] New pre-firmware modem detected
[eagle-usb] Uploading firmware..
[eagle-usb] Binding eu_instance_t to USB 003/004 
usb.c: USB disconnect on device 00:1d.1-2 address 4
[eagle-usb] Pre-firmware modem removed 
hub.c: new USB device 00:1d.1-2, assigned address 5
[eagle-usb] New USB ADSL device detected, waiting for DSP code... 

lsmod shows :
Module                  Size  Used by
eagle-usb              95152   0 

I'm not sure this could be related to the eagle-usb driver (which can be
found at :
https://sourceforge.net/project/showfiles.php?group_id=81588&package_id=8354
0&release_id=264461)


What I did exactly :
 - machine was booted with kernel 2.4.27 (config. avail on request),
 - module was loaded with : insmod eagle-usb
 - first USB ADSL modem was connected to the machine, and went
   thru the init stuff, fine.
 - second modem was connected, and then BUG.

Any good (or bad) reason for this ? Could this be related to
the USB equipment being twice the same ?

I tried to put a copy of /proc/slabinfo but doing 
{root} # cat /proc/slabinfo

resulted in a cat never returning, and being Defunct.

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

 

