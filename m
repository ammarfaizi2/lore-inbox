Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130617AbRCISzk>; Fri, 9 Mar 2001 13:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130619AbRCISzb>; Fri, 9 Mar 2001 13:55:31 -0500
Received: from [213.128.193.148] ([213.128.193.148]:18692 "EHLO
	dredd.crimea.edu") by vger.kernel.org with ESMTP id <S130617AbRCISzT>;
	Fri, 9 Mar 2001 13:55:19 -0500
Date: Fri, 9 Mar 2001 21:51:57 +0300
From: Oleg Drokin <green@dredd.crimea.edu>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: usb@in.tum.de, jerdfelt@valinux.com
Subject: khubd oops in 2.4.2-ac16
Message-ID: <20010309215157.A1868@dredd.crimea.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I experience a lot of troubles with uhci driver driver, in different kernels.
   Usually it just panics on device insertion or removal, but this time I got
   lucky, and oops was not fatal, so here it is decoded. As I can see,
   something stomped on usb_device structure of unplugged device.
   (do not sugget to use usb-uhci driver, it work even worse for me).
   Device that's unplugged is compaq ipaq, driver used is usbnet.c
   Host is USB built into Sony Vaio:
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
That's what I have in logs prior to oops:
Mar  9 19:32:21 notebook1 kernel: usb0: register usbnet 001/009, Linux Device
Mar  9 21:11:31 notebook1 kernel: usb.c: USB disconnect on device 1043477052

   Here is oops (decoded):

ksymoops 2.3.5 on i686 2.4.2-ac16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-ac16/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol __module_author  , usbnet says c89338c0, /lib/modules/2.4.2-ac16/kernel/drivers/usb/usbnet.o says c893472c.  Ignoring /lib/modules/2.4.2-ac16/kernel/drivers/usb/usbnet.o entry
Warning (compare_maps): mismatch on symbol __module_description  , usbnet says c8933900, /lib/modules/2.4.2-ac16/kernel/drivers/usb/usbnet.o says c893476c.  Ignoring /lib/modules/2.4.2-ac16/kernel/drivers/usb/usbnet.o entry
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address bde87719
c018cb8b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c018cb8b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0000002e   ebx: 0000000a   ecx: c06e6e00   edx: bde87715
esi: 00000100   edi: 00000001   ebp: 00000000   esp: c127bf60
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 9, stackpage=c127b000)
Stack: 0000000a 00000100 00000001 00000003 c018ec53 c06e6e00 c018ec92 c7f838ec
       00030100 00000000 00000001 00000003 00000000 c7f838ec c7f838ec 00000000
       c127bfdc 00000004 00000064 c018f010 c7f83800 00000000 c127bfdc c127a000
Call Trace: [<c018ec53>] [<c018ec92>] [<c018f010>] [<c018f1b5>] [<c0105000>] [<c010744f>]
Code: 80 7a 04 00 74 6f c7 44 24 10 00 00 00 00 8d b4 26 00 00 00

>>EIP; c018cb8b <usb_disconnect+3f/124>   <=====
Trace; c018ec53 <usb_hub_port_connect_change+2b/2f0>
Trace; c018ec92 <usb_hub_port_connect_change+6a/2f0>
Trace; c018f010 <usb_hub_events+f8/278>
Trace; c018f1b5 <usb_hub_thread+25/44>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c010744f <kernel_thread+23/30>
Code;  c018cb8b <usb_disconnect+3f/124>
00000000 <_EIP>:
Code;  c018cb8b <usb_disconnect+3f/124>   <=====
   0:   80 7a 04 00               cmpb   $0x0,0x4(%edx)   <=====
Code;  c018cb8f <usb_disconnect+43/124>
   4:   74 6f                     je     75 <_EIP+0x75> c018cc00 <usb_disconnect+b4/124>
Code;  c018cb91 <usb_disconnect+45/124>
   6:   c7 44 24 10 00 00 00      movl   $0x0,0x10(%esp,1)
Code;  c018cb98 <usb_disconnect+4c/124>
   d:   00 
Code;  c018cb99 <usb_disconnect+4d/124>
   e:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi


3 warnings issued.  Results may not be reliable.

Bye,
    Oleg
