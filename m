Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUIUJOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUIUJOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 05:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUIUJOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 05:14:50 -0400
Received: from camus.xss.co.at ([194.152.162.19]:46354 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S267528AbUIUJOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 05:14:42 -0400
Message-ID: <414FF0EB.6020505@xss.co.at>
Date: Tue, 21 Sep 2004 11:14:19 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, andrewm@uow.edu.au
Subject: [PATCH][2.4.28-pre3] 3c59x builtin NIC on Asus Pundit-R
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040209090006020707080303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040209090006020707080303
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcelo!

(Sorry for crossposting, but contact adresses in driver
documentation and MAINTAINERS file look a little bit
outdated and I wanted the right persons to receive this
mail. Methinks the maintainer infos could use some update,
too... :-)

The Asus Pundit-R is a nice barebone system useful to
build small and compact desktop workstations. It uses
an Asus P4R8L motherboard which has an ATI chipsed on
board.

root@install:~ {589} $ lspci
00:00.0 Host bridge: ATI Technologies Inc Radeon 9100 IGP Host Bridge (rev 02)
00:01.0 PCI bridge: ATI Technologies Inc Radeon 9100 IGP AGP Bridge
00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4347 (rev 01)
00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4348 (rev 01)
00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4345 (rev 01)
00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 18)
00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4349
00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audio Controller
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon 9100 IGP
02:08.0 Ethernet controller: 3Com Corporation 3Com 3C920B-EMB-WNM Integrated Fast Ethernet Controller (rev 40)
02:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
02:0c.0 CardBus bridge: ENE Technology Inc CB710 Cardbus Controller (rev 02)
02:0c.1 FLASH memory: ENE Technology Inc CB710 Memory Card Reader Controller

With a standard Linux 2.4.x kernel (tested with x >= 26),
every hardware component(*) works fine, except the built-in
ethernet controller.

As you can see, lspci tells us that this is an 3Com 3c920
integrated NIC. The standard 3c59x driver does not recognise
this piece of hardware. But with a small patch applied, it does,
and the network interface driver works without problems!

root@install:~ {602} $ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0E:A6:C3:5A:76
          inet addr:192.168.162.99  Bcast:192.168.162.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7879510 errors:0 dropped:0 overruns:1 frame:0
          TX packets:7220166 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4193721321 (3999.4 Mb)  TX bytes:496933951 (473.9 Mb)
          Interrupt:18 Base address:0xec00

root@install:~ {604} $ mii-tool -v
eth0: negotiated 100baseTx-FD, link ok
  product info: vendor 00:00:20, model 32 rev 1
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control

dmesg output:
[...]
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:08.0: 3Com PCI 3c920B-EMB-WNM (ATI Radeon 9100 IGP) at 0xec00. Vers LK1.1.18-ac
 00:0e:a6:c3:5a:76, IRQ 18
  product code f800 rev 00.0 date 00-04-02
  Internal config register is 1600000, transceivers 0x40.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 1, status 786d.
  Enabling bus-master transmits and whole-frame receives.
02:08.0: scatter/gather enabled. h/w checksums enabled
[...]

Detailled PCI infos about this device:
[...]
02:08.0 Class 0200: 10b7:9202 (rev 40)
        Subsystem: 1043:8108
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ec00 [size=128]
        Region 1: Memory at fe200000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at fe100000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
[...]

I have tested this patch on three different Pundit-R
barebones with a few different kernels for several weeks now.
I started with linux-2.4.26 and have now 2.4.28pre3 running.
It seems to work well with no ill sideffects. I have not
tested all possible driver options, though.

Note: This patch was not created originally be me, but I do
not remember where I got it from in the first place. As it
works well for me I would like to submit it for inclusion
in the next kernel release.

Please take a look at the patch and consider including it
in the next 2.4 kernel. Thank you.

- - andreas

(*) I did not have the time to test the memory card reader,
so I can't say if it works ;-)

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBT/DYxJmyeGcXPhERAlhGAJ9WJK/Zj3h+8EtLSkularfmV8gqtgCbB+4T
uQuMA/RaiSUurIK3hMxhZk0=
=cSPQ
-----END PGP SIGNATURE-----

--------------040209090006020707080303
Content-Type: application/octet-string;
 name="013-3com_ati_radeon.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="013-3com_ati_radeon.patch"

LS0tIGxpbnV4L2RyaXZlcnMvbmV0LzNjNTl4LmMub3JpZwkyMDA0LTA4LTA0IDExOjI2OjQ0
LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgvZHJpdmVycy9uZXQvM2M1OXguYwkyMDA0LTA4
LTA0IDExOjI3OjMxLjAwMDAwMDAwMCArMDIwMApAQCAtNDI5LDYgKzQyOSw3IEBACiAJQ0hf
M0M5MDVCXzIsCiAJQ0hfM0M5MDVCX0ZYLAogCUNIXzNDOTA1QywKKwlDSF8zQzkyMDIsCiAJ
Q0hfM0M5ODAsCiAJQ0hfM0M5ODA1LAogCkBAIC01MDUsNiArNTA2LDggQEAKIAkgUENJX1VT
RVNfSU98UENJX1VTRVNfTUFTVEVSLCBJU19DWUNMT05FfEhBU19IV0NLU00sIDEyOCwgfSwK
IAl7IjNjOTA1QyBUb3JuYWRvIiwKIAkgUENJX1VTRVNfSU98UENJX1VTRVNfTUFTVEVSLCBJ
U19UT1JOQURPfEhBU19OV0FZfEhBU19IV0NLU00sIDEyOCwgfSwKKwl7IjNjOTIwQi1FTUIt
V05NIChBVEkgUmFkZW9uIDkxMDAgSUdQKSIsCisJUENJX1VTRVNfSU98UENJX1VTRVNfTUFT
VEVSLCBJU19UT1JOQURPfEhBU19NSUl8SEFTX0hXQ0tTTSwgMTI4LCB9LAogCXsiM2M5ODAg
Q3ljbG9uZSIsCiAJIFBDSV9VU0VTX0lPfFBDSV9VU0VTX01BU1RFUiwgSVNfQ1lDTE9ORXxI
QVNfSFdDS1NNLCAxMjgsIH0sCiAJeyIzYzk4MEMgUHl0aG9uLVQiLApAQCAtNTgxLDYgKzU4
NCw3IEBACiAJeyAweDEwQjcsIDB4OTA1OCwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwg
MCwgQ0hfM0M5MDVCXzIgfSwKIAl7IDB4MTBCNywgMHg5MDVBLCBQQ0lfQU5ZX0lELCBQQ0lf
QU5ZX0lELCAwLCAwLCBDSF8zQzkwNUJfRlggfSwKIAl7IDB4MTBCNywgMHg5MjAwLCBQQ0lf
QU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSF8zQzkwNUMgfSwKKwl7IDB4MTBCNywgMHg5
MjAyLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSF8zQzkyMDIgfSwKIAl7IDB4
MTBCNywgMHg5ODAwLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSF8zQzk4MCB9
LAogCXsgMHgxMEI3LCAweDk4MDUsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENI
XzNDOTgwNSB9LAogCg==
--------------040209090006020707080303--

