Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbVCXKOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbVCXKOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVCXKOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:14:11 -0500
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:65168
	"EHLO live1.axiros.com") by vger.kernel.org with ESMTP
	id S263079AbVCXKNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:13:40 -0500
In-Reply-To: <42421FF2.7050501@candelatech.com>
References: <42421FF2.7050501@candelatech.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-207994160"
Message-Id: <9538d4ed18eab6ae1983ce32f7564237@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel List Kernel Mailing <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
From: Daniel Egger <de@axiros.com>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
Date: Thu, 24 Mar 2005 11:13:00 +0100
To: Ben Greear <greearb@candelatech.com>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3-207994160
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 24.03.2005, at 03:03, Ben Greear wrote:

> When trying to send/receive traffic, I get TX watchdog timeouts.  The 
> other
> interfaces seem to work just fine.

No idea whether my problem is related but due to a broken motherboard
I had to switch from a SiS based Athlon board (ECS K7S5A) to a new
one which is VIA based:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 
AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:09.0 VGA compatible controller: Cirrus Logic GD 5446
0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8169 Gigabit Ethernet (rev 10)
0000:00:0b.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit 
Ethernet Controller
0000:00:0d.0 FireWire (IEEE 1394): NEC Corporation uPD72874 IEEE1394 
OHCI 1.1 3-port PHY-Link Ctrlr (rev 01)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 
SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 
[Rhine-II] (rev 78)

Strange enough the beforehand very reliable Intel Pro/1000 MT
controller would also see watchdog errors in an otherwise
unchanged environment (same kernel, cards, CPU, etc.). I tried
different kernels 2.6.8-2.6.10, but no change; I tried without
ACPI information for IRQ routing -- nope. I tried swapping PCI
slots -- negative, sir.

As a temporary counter measure (this box is not only a ethernet
bridge between 100Mbit and 1000Mbit switched networks but also
the primary fileserver for my netboot TFTP/NFS environment, so
dropouts are especially nasty since it takes some time until the
NFS machines on the Gbit network will resume operation) I popped
in the cheeeep RealTek card (which caused some slight problems
like permanent hangs and bad performance before) and everything
works like a charm. Of course, after throwing in some extra
money to get at least somewhat professional equipment, I'd like
to use it, too.

This is the (strange?) ethtool output:
Settings for eth0:
         Supported ports: [ TP ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Full
         Supports auto-negotiation: Yes
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Full
         Advertised auto-negotiation: Yes
         Speed: Unknown! (65535)
         Duplex: Unknown! (255)
         Port: Twisted Pair
         PHYAD: 0
         Transceiver: internal
         Auto-negotiation: on
         Supports Wake-on: umbg
         Wake-on: g
         Current message level: 0x00000007 (7)
         Link detected: no

The card is still in the system and running, so if someone wants
me to run to more tests or diagnostic, please be my guest.

Servus,
       Daniel

--Apple-Mail-3-207994160
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCQpKtchlzsq9KoIYRAhk2AKCJCZ8H1WGw8prwZB2M2tlZGDaADwCgtmge
fRumGFNBZ2OY0MdYV+OmfBY=
=Inhw
-----END PGP SIGNATURE-----

--Apple-Mail-3-207994160--

