Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271965AbTG2SFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTG2SFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:05:18 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:64012
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271965AbTG2SCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:02:12 -0400
Date: Tue, 29 Jul 2003 11:02:09 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030729180209.GB1185@matchmail.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030716201512.GA1821@matchmail.com> <20030718023141.GC5828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718023141.GC5828@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 07:31:41PM -0700, Greg KH wrote:
> On Wed, Jul 16, 2003 at 01:15:12PM -0700, Mike Fedyk wrote:
> > Ok, I only see it when the system is booting, and after looking at the    
> > hotplug script in init.d there is different behaviour on boot, and on later   
> > invocations.                               
> 
> This is really wierd.  I can't see anything strange in your logs, until
> the oops :)
> 
> I also can't duplicate it here myself, sorry, I don't really have any
> ideas.

Ok, I was going through some of my logs, and I came across this one, which
is a little different.

Maybe it will help some...

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Unable to handle kernel paging request at virtual address d492e85c
 printing eip:
c01d3bdd
*pde = 040ce067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[kobject_add+121/244]    Not tainted
EFLAGS: 00010292
EIP is at kobject_add+0x79/0xf4
eax: c03d2280   ebx: d4970184   ecx: d492e85c   edx: d497019c
esi: c03d2288   edi: c03d2224   ebp: d2e13f34   esp: d2e13f28
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 253, threadinfo=d2e12000 task=d3e28080)
Stack: d4970184 d4970184 00000000 d2e13f4c c01d3c70 d4970184 d4970184 d4970184 
       c03d2220 d2e13f70 c0238d6f d4970184 d4970184 d496ea1a 00000014 d4970140 
       00000000 d49701e0 d2e13f7c c023912a d4970168 d2e13f94 c01d9ba0 d4970168 
Call Trace:
 [kobject_register+24/72] kobject_register+0x18/0x48
 [bus_add_driver+63/140] bus_add_driver+0x3f/0x8c
 [driver_register+54/60] driver_register+0x36/0x3c
 [pci_register_driver+116/156] pci_register_driver+0x74/0x9c
 [_end+340077356/1068944012] uhci_hcd_init+0xa0/0x10b [uhci_hcd]
 [sys_init_module+280/576] sys_init_module+0x118/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 89 11 8b 43 24 8b 38 8d 4f 44 89 c8 ba ff ff 00 00 f0 0f c1 
  <7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
SysRq : Emergency Sync
Emergency Sync complete
SysRq : Emergency Remount R/O

Unable to handle kernel paging request at virtual address d493885c
 printing eip:
c01d3bdd
*pde = 040ce067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[kobject_add+121/244]    Not tainted
EFLAGS: 00010292
EIP is at kobject_add+0x79/0xf4
eax: c03d2280   ebx: d49550c4   ecx: d493885c   edx: d49550dc
esi: c03d2288   edi: c03d2224   ebp: d3731f34   esp: d3731f28
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 209, threadinfo=d3730000 task=c4216080)
Stack: d49550c4 d49550c4 00000000 d3731f4c c01d3c70 d49550c4 d49550c4 d49550c4 
       c03d2220 d3731f70 c0238d6f d49550c4 d49550c4 d4953a8a 00000014 d4955080 
       00000000 d4955120 d3731f7c c023912a d49550a8 d3731f94 c01d9ba0 d49550a8 
Call Trace:
 [kobject_register+24/72] kobject_register+0x18/0x48
 [bus_add_driver+63/140] bus_add_driver+0x3f/0x8c
 [driver_register+54/60] driver_register+0x36/0x3c
 [pci_register_driver+116/156] pci_register_driver+0x74/0x9c
 [_end+340077226/1068944012] init+0x1e/0x4c [ehci_hcd]
 [sys_init_module+280/576] sys_init_module+0x118/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 89 11 8b 43 24 8b 38 8d 4f 44 89 c8 ba ff ff 00 00 f0 0f c1 
 <7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : SAK
SAK: killed process 13 (init): p->session==tty->session
SAK: killed process 14 (rcS): p->session==tty->session
SAK: killed process 205 (S36hotplug): p->session==tty->session
SAK: killed process 207 (usb.rc): p->session==tty->session
SAK: killed process 210 (modprobe): p->session==tty->session
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
RPC: sendmsg returned error 101

kobject ehci_hcd: registering. parent: <NULL>, set: drivers
Unable to handle kernel paging request at virtual address d493885c
 printing eip:
c01d3cb7
*pde = 040ce067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[kobject_add+163/292]    Not tainted
EFLAGS: 00010292
EIP is at kobject_add+0xa3/0x124
eax: c03d2980   ebx: d49550c4   ecx: d493885c   edx: d49550dc
esi: c03d2988   edi: c03d2924   ebp: d3ae3f28   esp: d3ae3f1c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 209, threadinfo=d3ae2000 task=d39612e0)
Stack: d49550c4 d49550c4 00000000 d3ae3f40 c01d3d50 d49550c4 d49550c4 d49550c4 
       c03d2920 d3ae3f70 c0238f2e d49550c4 d49550c4 d4953a8a 00000014 c036001c 
       c0341452 d4953a8a d4955080 00000000 d4955120 d3ae3f7c c023931a d49550a8 
Call Trace:
 [kobject_register+24/72] kobject_register+0x18/0x48
 [bus_add_driver+82/160] bus_add_driver+0x52/0xa0
 [driver_register+54/60] driver_register+0x36/0x3c
 [pci_register_driver+116/156] pci_register_driver+0x74/0x9c
 [_end+340077226/1068944012] init+0x1e/0x4c [ehci_hcd]
 [sys_init_module+280/576] sys_init_module+0x118/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 89 11 8b 43 24 8b 38 8d 4f 44 89 c8 ba ff ff 00 00 f0 0f c1 
 <7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
bus pci: add driver ohci-hcd
kobject ohci-hcd: registering. parent: <NULL>, set: drivers
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : SAK
SAK: killed process 13 (init): p->session==tty->session
SAK: killed process 14 (rcS): p->session==tty->session
SAK: killed process 205 (S36hotplug): p->session==tty->session
SAK: killed process 207 (usb.rc): p->session==tty->session
SAK: killed process 210 (modprobe): p->session==tty->session
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
