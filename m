Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284218AbRLWXI1>; Sun, 23 Dec 2001 18:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284195AbRLWXHx>; Sun, 23 Dec 2001 18:07:53 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:7449 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284191AbRLWXHa>;
	Sun, 23 Dec 2001 18:07:30 -0500
Date: Mon, 24 Dec 2001 00:07:23 +0100
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.17]: oops in usbcore during suspend
Message-ID: <20011223230723.GA1483@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
when suspending my Omnibook XE3 (via Fn+F12) im seeing:

 Unable to handle kernel NULL pointer dereference at virtual address 00000180
  printing eip:
 c8c79577
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[usbcore:usb_devfs_handle_Re9c5f87f+174307/197882781]    Not tainted
 EFLAGS: 00210246
 eax: c7d7e600   ebx: c77cc000   ecx: c1210000   edx: c8c7978c
 esi: 00000000   edi: c7d7e600   ebp: 00000000   esp: c77cdee4
 ds: 0018   es: 0018   ss: 0018
 Process kapm-idled (pid: 46, stackpage=c77cd000)
 Stack: c1210008 c1213ab4 c1213aa0 00000003 c1211808 c8c7979b c7d7e600 00000000 
        c019f7cc c1210000 00000003 c019f8ae c1210000 00000003 c1213aa0 00000003 
        00000003 c0225d80 c019f997 c1213aa0 00000003 c120b2a0 00000000 c019fa26 
 Call Trace: [usbcore:usb_devfs_handle_Re9c5f87f+174855/197882233] [pci_pm_suspend_device+32/36] [pci_pm_suspend_bus+82/104] [pci_pm_suspend+35/68] [pci_pm_callback+46/64] 
    [pm_send+62/112] [pm_send_all+69/144] [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.17-bogon/kernel/drivers+-67872/96] [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.17-bogon/kernel/drivers+-67273/96] [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.17-bogon/kernel/drivers+-66991/96] [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.17-bogon/kernel/drivers+-66861/96] 
    [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.17-bogon/kernel/drivers+-61924/96] [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.17-bogon/kernel/drivers+-60652/96] [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.17-bogon/kernel/drivers+-64376/96] [kernel_thread+31/56] [kernel_thread+40/56] 
 
 Code: 0f ab b5 80 01 00 00 19 c0 85 c0 75 dc 81 bd 7c 01 00 00 00 
  <4>usb-uhci.c: interrupt, status 20, frame# 0
 usb-uhci.c: Host controller halted, trying to restart.

sometimes. The other times the machine simply freezes without any notice
in the logs.

Im suspecting an interrupt handling problem since both USB controller(no
usb devices attached) and maestro3 are sharing interrupt 5:

 00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
 00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)

and this only seems to happen after using the maestro3 module. I'm using
the alsa maestro3 driver as of 0.9.0beta10a. 2.4.13 + kernel's maestro3
worked fine though.
 -- Guido

P.S.: please cc me on replies
