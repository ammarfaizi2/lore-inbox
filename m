Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261580AbSIZX4P>; Thu, 26 Sep 2002 19:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSIZX4P>; Thu, 26 Sep 2002 19:56:15 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:33249 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261580AbSIZX4N>;
	Thu, 26 Sep 2002 19:56:13 -0400
Date: Thu, 26 Sep 2002 17:01:15 -0700
To: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Oops in device_shutdown()
Message-ID: <20020927000115.GA19172@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Since I upgraded to 2.5.37/2.5.38, my SMP computer has decided
every night to hang without giving any Oops or error message. I've
also found the following Oops while rebooting the same computer (and
people wonder why I have serial cables between my PCs). My hope is
that fixing the second problem would fix the first ;-)

1) Step to reproduce :
--------------------
	<There might be simpler, didn't bother to trim down>
	o boot
	o modprobe ohci-hcd
	o modprobe irda-usb
	o start the irda stack
	o stop the irda stack
	o rmmod irda-usb irda
	o rmmod ohci-hcd usbcore
	o sync
	o reboot

2) In the log :
-------------

Stopping deferred execution scheduler: atd.
Stopping kernel log daemon: klogd.
Stopping system log daemon: syslogd.
Stopping portmap daemon: portmap.
Sending all processes the TERM signal... done.
Sending all processes the KILL signal... done.
Saving random seed... done.
Unmounting remote filesystems... done.
Deconfiguring network interfaces: done.
Deactivating swap... done.
Unmounting local filesystems... done.
Rebooting... Unable to handle kernel paging request at virtual address 72702f3d
 printing eip:
c0179cfa
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0179cfa>]    Not tainted
EFLAGS: 00010246
eax: 72702f3d   ebx: c7472494   ecx: c11ae4e8   edx: 00000002
esi: c7472494   edi: 72702f3d   ebp: bffffd8c   esp: c6a51e9c
ds: 0068   es: 0068   ss: 0068
Process reboot (pid: 519, threadinfo=c6a50000 task=c6bec7c0)
Stack: 01234567 c6a50000 fee1dead c0122bfd c02f8188 00000001 00000000 c6a50000 
       08049960 c74b5de0 00000000 00000001 000001d0 c118b600 c01c1eca 00000010 
       c118b600 00001000 c6a51f40 c6a51f45 c7933f44 c7d933c0 c01f1115 c118b600 
Call Trace: [<c0122bfd>] [<c01c1eca>] [<c01f1115>] [<c01f1454>] [<c01ba147>] 
   [<c014fcf2>] [<c01508d4>] [<c014e4c9>] [<c013c8d2>] [<c013c80c>] [<c013af9d>] 
   [<c013b005>] [<c0107023>] 

Code: 8b 38 3d e0 c7 28 c0 75 ad b0 01 86 05 f0 c7 28 c0 85 f6 74 
 /etc/rc6.d/S90reboot: line 11:   519 Segmentation fault      reboot -d -f -i
<1>Unable to handle kernel paging request at virtual address c8800087
 printing eip:
c01a8763
*pde = 01315067
*pte = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c01a8763>]    Not tainted
EFLAGS: 00010046
eax: c8800000   ebx: c131016c   ecx: c1333206   edx: c1333200
esi: c130c2c0   edi: c1333200   ebp: 0000000b   esp: c6c0bc08
ds: 0068   es: 0068   ss: 0068
Process init (pid: 520, threadinfo=c6c0a000 task=c6bef7e0)
Stack: c133fd40 c1333200 00000000 00000000 c130c2c0 c1333210 41000002 c1190002 
       c1198a00 c01a80d3 c1333200 c133e160 00000293 c1333400 c1198a00 00000000 
       c019379c c1198a00 c0193c24 c1198a00 c12fa660 c1341400 c6c0bce4 c01994ac 
Call Trace: [<c01a80d3>] [<c019379c>] [<c0193c24>] [<c01994ac>] [<c0190780>] 
   [<c01908f1>] [<c01384c7>] [<c01385be>] [<c012aecf>] [<c012b46b>] [<c012b1b0>] 
   [<c012b524>] [<c0131e41>] [<c01439e8>] [<c01443d5>] [<c014489a>] [<c0105b67>] 
   [<c0107023>] 

Code: 88 88 87 00 00 00 eb 16 90 8d 74 26 00 8b 5c 24 28 88 c8 0f 

3) ksymoops (after a reboot)
----------------------------

ksymoops 2.4.4 on i686 2.5.38.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.38/ (default)
     -m /usr/src/linux/System.map (default)

>>EIP; c0179cfa <device_shutdown+72/94>   <=====
Trace; c0122bfd <sys_reboot+e5/288>
Trace; c01c1eca <dev_change_flags+fa/104>
Trace; c01f1115 <devinet_ioctl+331/6d8>
Trace; c01f1454 <devinet_ioctl+670/6d8>
Trace; c01ba147 <sock_destroy_inode+13/18>
Trace; c014fcf2 <destroy_inode+3a/50>
Trace; c01508d4 <generic_forget_inode+ec/f4>
Trace; c014e4c9 <dput+19/168>
Trace; c013c8d2 <__fput+c2/e8>
Trace; c013c80c <fput+14/18>
Trace; c013af9d <filp_close+a1/ac>
Trace; c013b005 <sys_close+5d/7c>
Trace; c0107023 <syscall_call+7/b>
Code;  c0179cfa <device_shutdown+72/94>
00000000 <_EIP>:
Code;  c0179cfa <device_shutdown+72/94>   <=====
   0:   8b 38                     mov    (%eax),%edi   <=====
Code;  c0179cfc <device_shutdown+74/94>
   2:   3d e0 c7 28 c0            cmp    $0xc028c7e0,%eax
Code;  c0179d01 <device_shutdown+79/94>
   7:   75 ad                     jne    ffffffb6 <_EIP+0xffffffb6> c0179cb0 <device_shutdown+28/94>
Code;  c0179d03 <device_shutdown+7b/94>
   9:   b0 01                     mov    $0x1,%al
Code;  c0179d05 <device_shutdown+7d/94>
   b:   86 05 f0 c7 28 c0         xchg   %al,0xc028c7f0
Code;  c0179d0b <device_shutdown+83/94>
  11:   85 f6                     test   %esi,%esi
Code;  c0179d0d <device_shutdown+85/94>
  13:   74 00                     je     15 <_EIP+0x15> c0179d0f <device_shutdown+87/94>

4) And...
---------
	If you want, I can ksymoops the second oops, but I don't think
it's necessary.
	The IrDA stack is very old fashioned and doesn't use any of
the new device stuff.
	Only two IrDA-USB dongles on the OHCI card.

	Have fun...

	Jean

