Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUEJWh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUEJWh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEJWh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:37:56 -0400
Received: from pD9E09B92.dip.t-dialin.net ([217.224.155.146]:39554 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S262113AbUEJWhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:37:21 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at include/linux/dcache.h:277!
Date: Tue, 11 May 2004 00:37:13 +0200
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405110037.13819@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Happend while removing or inserting bluetooth (via some amgic key combo on my 
thinkpad).
linux 2.6.6-mm1, IMB t40p, lspci:
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 
03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 
03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller 
(rev 01)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 
01)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 01)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 
Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
[Radeon Mobility 9000 M9] (rev 02)
0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab 
NIC (rev 01)

lsusb
errm.. doesn't work after the bug..

dmesg:

       ___      ______
      0--,|    /OOOOOO\
     {_o  /  /OO plop OO\
       \__\_/OO oh dear OOO\s
          \OOOOOOOOOOOOOOOO/
           __XXX__   __XXX__
- ------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:277!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c015bf2a>]    Tainted: PF  VLI
EFLAGS: 00010246   (2.6.6-mm1)
EIP is at d_alloc+0x13f/0x17f
eax: 00000000   ebx: d15dd6b4   ecx: 00000000   edx: cdc2b474
esi: cdc2b474   edi: d15dd72a   ebp: df55fe70   esp: df55fe30
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 452, threadinfo=df55f000 task=c169ae50)
Stack: cdc2b474 df55fe70 cdc2b474 00000000 c0153107 fffffff4 cdc2b474 00000000
       dc2f5418 c015403b df55fe70 baf3f719 cdc2b474 c042172f e1d65220 c0174f60
       baf3f719 c0421729 00000006 00000001 e1d65220 d99fd330 e1d651c0 c0174f92
Call Trace:
 [<c0153107>] cached_lookup+0x6e/0x76
 [<c015403b>] __lookup_hash+0x74/0xac
 [<c0174f60>] sysfs_get_dentry+0x5d/0x64
 [<c0174f92>] sysfs_hash_and_remove+0x2b/0x171
 [<c029e131>] class_device_del+0x70/0xa1
 [<e1d5bb47>] hci_unregister_dev+0x8/0x90 [bluetooth]
 [<e1d4c9bc>] hci_usb_disconnect+0x2f/0x6f [hci_usb]
 [<e18e0b74>] usb_disable_interface+0x28/0x35 [usbcore]
 [<e18db0b8>] usb_unbind_interface+0x60/0x62 [usbcore]
 [<c029d77d>] device_release_driver+0x56/0x58
 [<c029d874>] bus_remove_device+0x48/0x84
 [<c029cae4>] device_del+0x5a/0x8f
 [<c029cb21>] device_unregister+0x8/0x10
 [<e18e0be2>] usb_disable_device+0x61/0xa5 [usbcore]
 [<e18dba91>] usb_disconnect+0x90/0xd7 [usbcore]
 [<e18ddc57>] hub_port_connect_change+0x247/0x26d [usbcore]
 [<e18dd154>] hub_port_status+0x3c/0xa8 [usbcore]
 [<c03dc19a>] schedule+0x282/0x475
 [<e18ddf09>] hub_events+0x28c/0x2fd [usbcore]
 [<e18ddfa5>] hub_thread+0x2b/0xd8 [usbcore]
 [<c0113086>] default_wake_function+0x0/0xc
 [<e18ddf7a>] hub_thread+0x0/0xd8 [usbcore]
 [<c0103a49>] kernel_thread_helper+0x5/0xb

Code: 53 28 89 48 04 89 47 30 83 05 bc 6e 46 c0 01 8b 46 08 83 6e 14 01 a8 08 
75 0a 89 d8 83 c4 14 5b 5e 5f 5d c3 e8 65 04 28 00 eb ef <0f> 0b 15 01 fe 2d 
40 c0 eb 98 8d 43 28 89 43 28 89 43 2c eb 9b


regards
Alex



- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoAQZ/aHb+2190pERAgIrAKCId4D46E6nSP3prbS1L45shnVitQCgmaqN
sgrFvhqODo7N8f59lvTc8Dc=
=qCme
-----END PGP SIGNATURE-----
