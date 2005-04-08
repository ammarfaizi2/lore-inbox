Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVDHRP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVDHRP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVDHRPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:15:25 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:44292 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S262881AbVDHRNT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:13:19 -0400
From: "Udo van den Heuvel" <udovdh@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: VIA Rhine ethernet driver bug (any progress?)
Date: Fri, 8 Apr 2005 19:13:14 +0200
Message-ID: <000001c53c5e$4053bff0$450aa8c0@hierzo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Did anyone make progress in the case of the VIA Rhine ethernet bug?

It gives messages like:

Apr  8 18:51:08 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x9 length 0 status 00000600!
Apr  8 18:51:08 epia kernel: eth1: Oversized Ethernet frame cca77090 vs
cca77090.
Apr  8 18:51:08 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0xa length 0 status 00000400!
Apr  8 18:51:08 epia kernel: eth1: Oversized Ethernet frame cca770a0 vs
cca770a0.

[....]

Apr  8 18:51:08 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x7 length 0 status 00000400!
Apr  8 18:51:08 epia kernel: eth1: Oversized Ethernet frame cca77070 vs
cca77070.
Apr  8 18:51:08 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x8 length 24436 status 5f748d10!
Apr  8 18:51:08 epia kernel: eth1: Oversized Ethernet frame cca77080 vs
cca77080.


Most of the time the ethernet connection is gone and needs and ifconfig
down/up or reboot to make it work again.
I see this error on a VIA EPIA CL-6000 board. Using google I see the
mentionings of the error messages in relation to VIA Rhine go back to 1999.
The other side of eth1 is an Alcatel Speedtouch Home. With different
firewall hardware (Tulip DT5/xxx but same Alcatel) I did not see the errors.

Any ideas? A patch to gather more info so the bug can be fixed?
Etc?

Please post!

Info:

eth0: VIA Rhine III at 0x1d000, 00:40:63:d6:xx:xx, IRQ 11.
eth1: VIA Rhine II at 0x1e800, 00:40:63:d6:xx:xx, IRQ 9.

Linux epia 2.6.11-rc1-mm2 #2 Sat Jan 22 10:51:45 CET 2005 i686 i686 i386
GNU/Linux

00:0f.0 Ethernet controller: VIA Technologies, Inc. VT6105 [Rhine-III] (rev
8b)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
74)

# cat /proc/interrupts
           CPU0
  0:    5739616          XT-PIC  timer
  1:         78          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         12          XT-PIC  serial
  4:         12          XT-PIC  serial
  8:          1          XT-PIC  rtc
  9:     804990          XT-PIC  VIA8233, uhci_hcd, uhci_hcd, eth1
 11:     493428          XT-PIC  HiSax, ehci_hcd, uhci_hcd, eth0
 12:        512          XT-PIC  i8042
 14:     453632          XT-PIC  ide0
 15:      50784          XT-PIC  ide1
NMI:          0
ERR:          1

(the ERR value has a relation to the bug? I just rebooted the box and the
error occurred once...)

# ethtool eth1
Settings for eth1:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: pumbg
        Wake-on: d
        Current message level: 0x00000001 (1)
        Link detected: yes


Kind regards,
Udo


