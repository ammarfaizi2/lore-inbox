Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbRC1Xh5>; Wed, 28 Mar 2001 18:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132620AbRC1Xhs>; Wed, 28 Mar 2001 18:37:48 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:58127 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S132615AbRC1Xhi>;
	Wed, 28 Mar 2001 18:37:38 -0500
Message-ID: <3AC27583.2090206@magenta-netlogic.com>
Date: Thu, 29 Mar 2001 00:36:35 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac26 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Hoyle <tmh@magenta-netlogic.com>
CC: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
   linux-kernel@vger.kernel.org
Subject: Re: Repeatable lockup on SMP w/usbprocfs
In-Reply-To: <3AC24EF0.6060800@magenta-netlogic.com>
Content-Type: multipart/mixed;
 boundary="------------080102010208070201000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080102010208070201000204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've enabled spinlock debugging, and generated a nice oops...  The USB 
system is definately doing something wrong somewhere.

Tony

-- 
Don't click on this sig - a cyberwoozle will eat your underwear.

tmh@magenta-netlogic.com        http://www.nothing-on.tv

--------------080102010208070201000204
Content-Type: text/plain;
 name="oops-decoded.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-decoded.txt"

ksymoops 2.3.7 on i686 2.4.2-ac26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-ac26/ (default)
     -m /boot/System.map-2.4.2-ac26 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

eip: d28eb1b5
kernel BUG at /usr/src/linux/include/asm/spinlock.h:90!
invalid operand: 0000
CPU:    1
EIP:    0010:[<d28eb1dc>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000038   ebx: cff44710     ecx: c0264ba0       edx: 00004e26
esi: cda794bc   edi: cff44680     ebp: ffffffea       esp: cd28ded8
ds: 0018        es: 0018       ss: 0018
Process mgmt (pid: 408, stackpage=cd28d000)
Stack: d28edae0 0000005a cda793c8 cda794a0 cda793a0 00000286 cda794c8 cff44710
       00000292 cff44680 d28d90e6 cda794bc d28deb1f cda794bc cda793a0 bffffc70
       <4>fffffdfd cfb69940 00000002 00000000 00000000 00008103 00000000 00000000
Call Trace: [<d28edae0>] [<d28d90e6>] [<d28deb1f>] [<d28df627>] [<c014d588>] [<c014d588>] [<c010756b>]
Code: 0f 0b 83 c4 08 f0 fe 0e 88 ee 27 00 00 8b 46 20 83 f8 8d

>>EIP; d28eb1dc <[uhci]uhci_submit_urb+134/3fc>   <=====
Trace; d28edae0 <[uhci].rodata.start+20/110c>
Trace; d28d90e6 <[usbcore]usb_submit_urb+1e/30>
Trace; d28deb1f <[usbcore]proc_submiturb+56f/64c>
Trace; d28df627 <[usbcore]usbdev_ioctl+1ef/298>
Trace; c014d588 <file_ioctl+148/15c>
Trace; c014d588 <file_ioctl+148/15c>
Trace; c010756b <system_call+33/38>
Code;  d28eb1dc <[uhci]uhci_submit_urb+134/3fc>
00000000 <_EIP>:
Code;  d28eb1dc <[uhci]uhci_submit_urb+134/3fc>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  d28eb1de <[uhci]uhci_submit_urb+136/3fc>
   2:   83 c4 08                  add    $0x8,%esp
Code;  d28eb1e1 <[uhci]uhci_submit_urb+139/3fc>
   5:   f0 fe 0e                  lock decb (%esi)
Code;  d28eb1e4 <[uhci]uhci_submit_urb+13c/3fc>
   8:   88 ee                     mov    %ch,%dh
Code;  d28eb1e6 <[uhci]uhci_submit_urb+13e/3fc>
   a:   27                        daa    
Code;  d28eb1e7 <[uhci]uhci_submit_urb+13f/3fc>
   b:   00 00                     add    %al,(%eax)
Code;  d28eb1e9 <[uhci]uhci_submit_urb+141/3fc>
   d:   8b 46 20                  mov    0x20(%esi),%eax
Code;  d28eb1ec <[uhci]uhci_submit_urb+144/3fc>
  10:   83 f8 8d                  cmp    $0xffffff8d,%eax


1 warning issued.  Results may not be reliable.

--------------080102010208070201000204--

