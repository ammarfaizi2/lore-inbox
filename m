Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbTFSHIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 03:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbTFSHIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 03:08:21 -0400
Received: from [193.219.88.42] ([193.219.88.42]:6793 "EHLO mg.homelinux.net")
	by vger.kernel.org with ESMTP id S265718AbTFSHIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 03:08:19 -0400
Date: Thu, 19 Jun 2003 10:22:16 +0300
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21: Bluetooth oopses with Acer USB dongle
Message-ID: <20030619072216.GB14665@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: If you do not see this message correctly, stop using Outlook.
X-GPG-Fingerprint: 8121 AD32 F00A 8094 748A  6CD0 9157 445D E7A6 D78F
X-GPG-Key: http://www.b4net.lt/~mgedmin/mg-pgp-key.txt
X-URL: http://www.b4net.lt/~mgedmin/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I insert an Acer USB Bluetooth dongle, 2.4.21 (vanilla + CPUfreq
patch found on Con Kolivas patch page, 1100_CFS_0306161356_2.4.21-ck1.patch)
immediately oopses:

Jun 19 02:38:56 perlas kernel: hub.c: new USB device 00:1d.1-1, assigned address 2
Jun 19 02:38:56 perlas hcid[834]: HCI dev 0 registered
Jun 19 02:38:56 perlas kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jun 19 02:38:56 perlas kernel:  printing eip:
Jun 19 02:38:56 perlas kernel: d0a2f431
Jun 19 02:38:56 perlas kernel: *pde = 00000000
Jun 19 02:38:56 perlas kernel: Oops: 0000
Jun 19 02:38:56 perlas kernel: CPU:    0
Jun 19 02:38:56 perlas kernel: EIP:    0010:[<d0a2f431>]    Not tainted
Jun 19 02:38:56 perlas kernel: EFLAGS: 00010096
Jun 19 02:38:56 perlas kernel: eax: 00000000   ebx: ce04cc00   ecx: cdcf5ab4   edx: ce04cc00
Jun 19 02:38:56 perlas kernel: esi: ce04cc00   edi: 00000000   ebp: 00000206   esp: c92a1f28
Jun 19 02:38:56 perlas kernel: ds: 0018   es: 0018   ss: 0018
Jun 19 02:38:56 perlas kernel: Process hcid (pid: 989, stackpage=c92a1000)
Jun 19 02:38:56 perlas kernel: Stack: d0a2f38f cdcf5ab4 00000020 206c6165 68746977 00000008 ce04cc00 ce04cc00
Jun 19 02:38:56 perlas kernel:        00000000 00000206 d0a2f63a ce04cc00 c9434240 ce04cc00 ce04ccbc 00000000
Jun 19 02:38:56 perlas kernel:        d0a263a9 ce04cc00 00000001 00000002 00000000 c9434240 400448c9 ffffffe7
Jun 19 02:38:56 perlas kernel: Call Trace:    [<d0a2f38f>] [<d0a2f63a>] [<d0a263a9>] [sock_ioctl+38/48] [sys_ioctl+185/448]
Jun 19 02:38:56 perlas kernel:   [system_call+51/56]
Jun 19 02:38:56 perlas kernel:
Jun 19 02:38:56 perlas kernel: Code: 0f b7 78 04 c7 44 24 04 20 00 00 00 8d 04 bf 8d 2c 00 89 2c
Jun 19 02:38:56 perlas /sbin/hotplug: no runnable /etc/hotplug/bluetooth.agent is installed
Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: Setup hci_usb for USB product b7a/7d0/134
Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: Setup hci_usb for USB product b7a/7d0/134
Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: missing kernel or user mode driver hci_usb
Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: missing kernel or user mode driver hci_usb

Ksymoops output follows

>>EIP; d0a2f431 <[hci_usb]hci_usb_isoc_rx_submit+11/190>   <=====

>>ebx; ce04cc00 <_end+dd55578/105c59d8>
>>ecx; cdcf5ab4 <_end+d9fe42c/105c59d8>
>>edx; ce04cc00 <_end+dd55578/105c59d8>
>>esi; ce04cc00 <_end+dd55578/105c59d8>
>>esp; c92a1f28 <_end+8faa8a0/105c59d8>

Trace; d0a2f38f <[hci_usb]hci_usb_bulk_rx_submit+cf/160>
Trace; d0a2f63a <[hci_usb]hci_usb_open+8a/90>
Trace; d0a263a9 <[bluez]hci_dev_open+79/220>

Code;  d0a2f431 <[hci_usb]hci_usb_isoc_rx_submit+11/190>
00000000 <_EIP>:
Code;  d0a2f431 <[hci_usb]hci_usb_isoc_rx_submit+11/190>   <=====
   0:   0f b7 78 04               movzwl 0x4(%eax),%edi   <=====
Code;  d0a2f435 <[hci_usb]hci_usb_isoc_rx_submit+15/190>
   4:   c7 44 24 04 20 00 00      movl   $0x20,0x4(%esp,1)
Code;  d0a2f43c <[hci_usb]hci_usb_isoc_rx_submit+1c/190>
   b:   00
Code;  d0a2f43d <[hci_usb]hci_usb_isoc_rx_submit+1d/190>
   c:   8d 04 bf                  lea    (%edi,%edi,4),%eax
Code;  d0a2f440 <[hci_usb]hci_usb_isoc_rx_submit+20/190>
   f:   8d 2c 00                  lea    (%eax,%eax,1),%ebp
Code;  d0a2f443 <[hci_usb]hci_usb_isoc_rx_submit+23/190>
  12:   89 2c 00                  mov    %ebp,(%eax,%eax,1)

I did not have this problem with 2.4.20 (with Debian patches).  (But
2.4.20 did not have rfcomm support.)

The kernel is built with gcc 3.2.3.  Should I try 2.95?  I thought 3.2
was OK.  Should I try a vanilla kernel?  CPUfreq does not touch USB in
any obvious way.

Is this the right list to ask, or is there a more specific one for
bluez?

Marius Gedminas
-- 
There are 10 kinds of people in the world: Those who understand binary
mathematics and those who don't.
