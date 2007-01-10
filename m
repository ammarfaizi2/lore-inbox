Return-Path: <linux-kernel-owner+w=401wt.eu-S964842AbXAJK0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbXAJK0L (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 05:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbXAJK0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 05:26:11 -0500
Received: from hydra.gt.owl.de ([195.71.99.218]:48790 "EHLO hydra.gt.owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964834AbXAJK0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 05:26:09 -0500
X-Greylist: delayed 1837 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 05:26:08 EST
Date: Wed, 10 Jan 2007 10:55:28 +0100
From: Florian Lohoff <flo@rfc822.org>
To: netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: 2.6.20-rc4 sky2 unsupported chip type 0xff / phy write timeout
Message-ID: <20070110095528.GA14947@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
Organization: rfc822 - pure communication
X-SpiderMe: mh-200701101042@listme.rfc822.org
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i have random problems after fresh boot with the onboard sky2 on an
Fujitsu Siemens Lifebook E8110. With 2.6.18-686-3 from the Debian repositor=
y i see
random crashes on boot - see http://bugs.debian.org/cgi-bin/bugreport.cgi?b=
ug=3D404107

With a=20

	Linux machine 2.6.20-rc4 #0 SMP PREEMPT Mon Jan 8 15:18:15 CET 2007 i686 G=
NU/Linux

i dont see crashes now but instead i see on random boots:

	[   12.412000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) =
-> IRQ 16
	[   12.412000] PCI: Setting latency timer of device 0000:02:00.0 to 64
	[   12.412000] sky2 v1.10 addr 0xf0000000 irq 16 Yukon-EC Ultra (0xb4) rev=
 2
	[   12.412000] sky2 eth0: addr 00:17:42:13:45:8c
	[   24.548000] sky2 eth1: enabling interface
	[   24.552000] sky2 eth1: phy write timeout
	[   24.556000] sky2 eth1: phy write timeout
	[   24.556000] sky2 eth1: phy write timeout
	[   24.560000] sky2 eth1: phy write timeout
	[   24.560000] sky2 eth1: phy write timeout
	[   24.564000] sky2 eth1: phy write timeout
	[   24.564000] sky2 eth1: phy write timeout
	[   24.568000] sky2 eth1: phy write timeout
	[   24.568000] sky2 eth1: phy write timeout
	[   24.572000] sky2 eth1: phy write timeout
	[   24.572000] sky2 eth1: ram buffer 1020K

Afterwards the interface is not usable as one would have expected. rmmod/mo=
dprobe later:

	[  186.536000] sky2 eth1: disabling interface
	[  186.536000] sky2 eth1: phy write timeout
	[  186.564000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
	[  190.464000] PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
	[  190.464000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) =
-> IRQ 16
	[  190.464000] PCI: Setting latency timer of device 0000:02:00.0 to 64
	[  190.464000] sky2 0000:02:00.0: unsupported chip type 0xff
	[  190.464000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
	[  190.464000] sky2: probe of 0000:02:00.0 failed with error -95

On a working boot i see:

	[   12.236000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) =
-> IRQ 16
	[   12.236000] PCI: Setting latency timer of device 0000:02:00.0 to 64
	[   12.236000] sky2 v1.10 addr 0xf0000000 irq 16 Yukon-EC Ultra (0xb4) rev=
 2
	[   12.240000] sky2 eth1: addr 00:17:42:13:45:8c
	[   24.552000] sky2 eth1: enabling interface
	[   24.556000] sky2 eth1: ram buffer 0K
	[   26.200000] sky2 eth1: Link is up at 100 Mbps, full duplex, flow contro=
l none


lspci -vvvn

	02:00.0 0200: 11ab:4363 (rev 12)
		Subsystem: 10cf:139a
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR-
		Latency: 0, Cache Line Size: 64 bytes
		Interrupt: pin A routed to IRQ 220
		Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=3D16K]
		Region 2: I/O ports at 2000 [size=3D256]
		[virtual] Expansion ROM at 38000000 [disabled] [size=3D128K]
		Capabilities: [48] Power Management version 3
			Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3co=
ld+)
			Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
		Capabilities: [50] Vital Product Data
		Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0/0=
 Enable+
			Address: 00000000fee0300c  Data: 4142
		Capabilities: [e0] Express Legacy Endpoint IRQ 0
			Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
			Device: Latency L0s unlimited, L1 unlimited
			Device: AtnBtn- AtnInd- PwrInd-
			Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
			Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
			Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
			Link: Latency L0s <256ns, L1 unlimited
			Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
			Link: Speed 2.5Gb/s, Width x1
		Capabilities: [100] Advanced Error Reporting

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFpLgQUaz2rXW+gJcRAiG7AJ95bprjJs/KOms0gOpvkBX+fn0qowCgtnh4
z5HHqEk0LBrBdK+bMmk2s2I=
=YrGt
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
