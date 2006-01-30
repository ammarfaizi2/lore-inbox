Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWA3F6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWA3F6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 00:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWA3F6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 00:58:37 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:23224 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751245AbWA3F6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 00:58:36 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Date: Mon, 30 Jan 2006 15:54:49 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601280520.28816.nigel@suspend2.net> <20060127232251.GC1617@elf.ucw.cz>
In-Reply-To: <20060127232251.GC1617@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1378275.IraQpXNjcZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601301554.54710.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1378275.IraQpXNjcZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 28 January 2006 09:22, Pavel Machek wrote:
> You could swapoff -a to make your cycle a lot faster.... Freezing is
> still done in that case, IIRC.

That was right. I just did the test:

I used

stress -d 5 --hdd-bytes 100M -i 5 -c 5

to test.

In both cases, I:

1) booted to init S on an amd64 laptop with 1GB ram
2) for swsusp, swapoff'd /dev/hda1 and for suspend2 did echo 1 > /proc/susp=
end2/freezer_test
3) started stress
4) then started the attempts at suspending without restarting stress betwee=
n each iteration.

I usually left a couple of seconds between each iteration to allow stress t=
o fill buffers etc again, but
was called away once during swsusp testing, leaving a much bigger period be=
tween 2 tests.

Kernel log output follows (sorry about the long lines):

Jan 30 15:33:08 localhost kernel: [  372.681816] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 30 15:33:08 localhost kernel: [  378.714028] Restarting tasks...<6> Str=
ange, kjournald not stopped
Jan 30 15:33:08 localhost kernel: [  378.734593]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  378.755084]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  378.775148]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  378.794802]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  378.813947]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  387.171737]  done
Jan 30 15:33:08 localhost kernel: [  406.457958] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Jan 30 15:33:08 localhost kernel: [  409.527817] Freeing memory...  ^H-^H\^=
H|^H/^H-^H\^H|^H/^H-^H\^Hdone (130644 pages freed)
Jan 30 15:33:08 localhost kernel: [  410.276750] acpi_bus-0201 [02] bus_set=
_power         : Device is not power manageable
Jan 30 15:33:08 localhost kernel: [  410.690283] ACPI: PCI Interrupt 0000:0=
0:14.0[A] -> GSI 17 (level, low) -> IRQ 169
Jan 30 15:33:08 localhost kernel: [  410.739835] acpi_bus-0201 [02] bus_set=
_power         : Device is not power manageable
Jan 30 15:33:08 localhost kernel: [  410.758226] ACPI: PCI Interrupt 0000:0=
0:1d.1[B] -> GSI 22 (level, low) -> IRQ 177
Jan 30 15:33:08 localhost kernel: [  410.776764]  pci_irq-0385 [03] pci_irq=
_derive        : Unable to derive IRQ for device 0000:00:1f.0
Jan 30 15:33:08 localhost kernel: [  410.795579] ACPI: PCI Interrupt 0000:0=
0:1f.0[A]: no GSI
Jan 30 15:33:08 localhost kernel: [  411.472572] Restarting tasks... done
Jan 30 15:33:08 localhost kernel: [  489.731269] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 30 15:33:08 localhost kernel: [  495.767731] Restarting tasks...<6> Str=
ange, stress not stopped
Jan 30 15:33:08 localhost kernel: [  495.786297]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  500.733572]  done
Jan 30 15:33:08 localhost kernel: [  548.200154] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 30 15:33:08 localhost kernel: [  554.229009] Restarting tasks...<6> Str=
ange, stress not stopped
Jan 30 15:33:08 localhost kernel: [  559.584968]  done
Jan 30 15:33:08 localhost kernel: [  772.953163] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Jan 30 15:33:08 localhost kernel: [  774.268679] Freeing memory...  ^H-^H\^=
H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^Hdone (157371 pages freed)
Jan 30 15:33:08 localhost kernel: [  774.948384] acpi_bus-0201 [02] bus_set=
_power         : Device is not power manageable
Jan 30 15:33:08 localhost kernel: [  775.352905] ACPI: PCI Interrupt 0000:0=
0:14.0[A] -> GSI 17 (level, low) -> IRQ 169
Jan 30 15:33:08 localhost kernel: [  775.402457] acpi_bus-0201 [02] bus_set=
_power         : Device is not power manageable
Jan 30 15:33:08 localhost kernel: [  775.421503] ACPI: PCI Interrupt 0000:0=
0:1d.1[B] -> GSI 22 (level, low) -> IRQ 177
Jan 30 15:33:08 localhost kernel: [  775.441055]  pci_irq-0385 [03] pci_irq=
_derive        : Unable to derive IRQ for device 0000:00:1f.0
Jan 30 15:33:08 localhost kernel: [  775.461109] ACPI: PCI Interrupt 0000:0=
0:1f.0[A]: no GSI
Jan 30 15:33:08 localhost kernel: [  776.140128] Restarting tasks... done
Jan 30 15:33:08 localhost kernel: [  793.729930] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 30 15:33:08 localhost kernel: [  799.765453] Restarting tasks...<6> Str=
ange, kjournald not stopped
Jan 30 15:33:08 localhost kernJan 30 15:33:08 localhost kernel: [  825.2473=
34] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Jan 30 15:33:08 localhost kernel: [  825.279168] Freeing memory...  ^H-^H\^=
H|^Hdone (23358 pages freed)
Jan 30 15:33:08 localhost kernel: [  826.844573] acpi_bus-0201 [02] bus_set=
_power         : Device is not power manageable
Jan 30 15:33:08 localhost kernel: [  827.409905] ACPI: PCI Interrupt 0000:0=
0:14.0[A] -> GSI 17 (level, low) -> IRQ 169
Jan 30 15:33:08 localhost kernel: [  827.459457] acpi_bus-0201 [02] bus_set=
_power         : Device is not power manageable
Jan 30 15:33:08 localhost kernel: [  827.476078] ACPI: PCI Interrupt 0000:0=
0:1d.1[B] -> GSI 22 (level, low) -> IRQ 177
Jan 30 15:33:08 localhost kernel: [  827.492796]  pci_irq-0385 [03] pci_irq=
_derive        : Unable to derive IRQ for device 0000:00:1f.0
Jan 30 15:33:08 localhost kernel: [  827.509962] ACPI: PCI Interrupt 0000:0=
0:1f.0[A]: no GSI
Jan 30 15:33:08 localhost kernel: [  828.182831] Restarting tasks... done
Jan 30 15:33:08 localhost kernel: [  870.265642] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 30 15:33:08 localhost kernel: [  876.299090] Restarting tasks...<6> Str=
ange, kjournald not stopped
Jan 30 15:33:08 localhost kernel: [  876.316040]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.332588]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.348638]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.364182]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.379489]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.394073]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.408172]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.422010]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.435853]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.449156]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.462449]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.475099]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  881.427744]  done
el: [  799.785374]  Strange, stress not stopped
Jan 30 15:33:08 localhost kernel: [  799.805440]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  799.825298]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  799.844855]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  799.863529]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  799.881792]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  799.899884]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  799.917305]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  799.934153]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  799.950444]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  805.247267]  done
Jan 30 15:33:08 localhost kernel: [  825.247334] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D|
Jan 30 15:33:08 localhost kernel: [  825.279168] Freeing memory...  ^H-^H\^=
H|^Hdone (23358 pages freed)
Jan 30 15:33:08 localhost kernel: [  826.844573] acpi_bus-0201 [02] bus_set=
_power         : Device is not power manageable
Jan 30 15:33:08 localhost kernel: [  827.409905] ACPI: PCI Interrupt 0000:0=
0:14.0[A] -> GSI 17 (level, low) -> IRQ 169
Jan 30 15:33:08 localhost kernel: [  827.459457] acpi_bus-0201 [02] bus_set=
_power         : Device is not power manageable
Jan 30 15:33:08 localhost kernel: [  827.476078] ACPI: PCI Interrupt 0000:0=
0:1d.1[B] -> GSI 22 (level, low) -> IRQ 177
Jan 30 15:33:08 localhost kernel: [  827.492796]  pci_irq-0385 [03] pci_irq=
_derive        : Unable to derive IRQ for device 0000:00:1f.0
Jan 30 15:33:08 localhost kernel: [  827.509962] ACPI: PCI Interrupt 0000:0=
0:1f.0[A]: no GSI
Jan 30 15:33:08 localhost kernel: [  828.182831] Restarting tasks... done
Jan 30 15:33:08 localhost kernel: [  870.265642] Stopping tasks: =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Jan 30 15:33:08 localhost kernel: [  876.299090] Restarting tasks...<6> Str=
ange, kjournald not stopped
Jan 30 15:33:08 localhost kernel: [  876.316040]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.332588]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.348638]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.364182]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.379489]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.394073]  Strange, stress not stopp=
ed
Jan 30 15:33:08 localhost kernel: [  876.408172]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.422010]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.435853]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.449156]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.462449]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  876.475099]  Strange, pdflush not stop=
ped
Jan 30 15:33:08 localhost kernel: [  881.427744]  done


Then with the new version:
[   86.975030] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[   86.975035] suspend_userui: program not configured. suspend_userui disab=
led.
[   86.975223] Freezing processes
[  101.101759] Preparing Image.
[  101.960220] Suspend2 debugging info:
[  101.960223] - SUSPEND core   : 2.2.0.1
[  101.960224] - Kernel Version : 2.6.15
[  101.960225] - Compiler vers. : 4.0
[  101.960227] - Attempt number : 1
[  101.960228] - Parameters     : 0 128 0 0 0 0
[  101.960229] - Overall expected compression percentage: 0.
[  101.960231] - Swapwriter active.
[  101.960232]   Swap available for image: 295184 pages.
[  101.960234] - Filewriter inactive.
[  101.960235] - No I/O speed stats available.
[  113.041463] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  113.041470] suspend_userui: program not configured. suspend_userui disab=
led.
[  113.041557] Freezing processes
[  131.156259] Preparing Image.
[  132.038683] Suspend2 debugging info:
[  132.038685] - SUSPEND core   : 2.2.0.1
[  132.038687] - Kernel Version : 2.6.15
[  132.038688] - Compiler vers. : 4.0
[  132.038689] - Attempt number : 2
[  132.038690] - Parameters     : 0 128 0 0 0 0
[  132.038692] - Overall expected compression percentage: 0.
[  132.038693] - Swapwriter active.
[  132.038694]   Swap available for image: 295184 pages.
[  132.038696] - Filewriter inactive.
[  132.038697] - No I/O speed stats available.
[  145.228742] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  145.228747] suspend_userui: program not configured. suspend_userui disab=
led.
[  145.228974] Freezing processes
[  152.404097] Preparing Image.
[  153.366314] Suspend2 debugging info:
[  153.366316] - SUSPEND core   : 2.2.0.1
[  153.366317] - Kernel Version : 2.6.15
[  153.366319] - Compiler vers. : 4.0
[  153.366320] - Attempt number : 3
[  153.366321] - Parameters     : 0 128 0 0 0 0
[  153.366323] - Overall expected compression percentage: 0.
[  153.366324] - Swapwriter active.
[  153.366325]   Swap available for image: 295184 pages.
[  153.366327] - Filewriter inactive.
[  153.366328] - No I/O speed stats available.
[  163.088026] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  163.088032] suspend_userui: program not configured. suspend_userui disab=
led.
[  163.088217] Freezing processes
[  179.203517] Preparing Image.
[  180.083987] Suspend2 debugging info:
[  180.083989] - SUSPEND core   : 2.2.0.1
[  180.083990] - Kernel Version : 2.6.15
[  180.083992] - Compiler vers. : 4.0
[  180.083993] - Attempt number : 4
[  180.083994] - Parameters     : 0 128 0 0 0 0
[  180.083996] - Overall expected compression percentage: 0.
[  180.083997] - Swapwriter active.
[  180.083998]   Swap available for image: 295184 pages.
[  180.084000] - Filewriter inactive.
[  180.084001] - No I/O speed stats available.
[  190.528302] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  190.528308] suspend_userui: program not configured. suspend_userui disab=
led.
[  190.528461] Freezing processes
[  198.554222] Preparing Image.
[  199.473349] Suspend2 debugging info:
[  199.473351] - SUSPEND core   : 2.2.0.1
[  199.473353] - Kernel Version : 2.6.15
[  199.473354] - Compiler vers. : 4.0
[  199.473355] - Attempt number : 5
[  199.473357] - Parameters     : 0 128 0 0 0 0
[  199.473358] - Overall expected compression percentage: 0.
[  199.473360] - Swapwriter active.
[  199.473361]   Swap available for image: 295184 pages.
[  199.473362] - Filewriter inactive.
[  199.473364] - No I/O speed stats available.
[  208.377977] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  208.377984] suspend_userui: program not configured. suspend_userui disab=
led.
[  208.378079] Freezing processes
[  227.420522] Preparing Image.
[  228.395082] Suspend2 debugging info:
[  228.395084] - SUSPEND core   : 2.2.0.1
[  228.395085] - Kernel Version : 2.6.15
[  228.395087] - Compiler vers. : 4.0
[  228.395088] - Attempt number : 6
[  228.395089] - Parameters     : 0 128 0 0 0 0
[  228.395091] - Overall expected compression percentage: 0.
[  228.395092] - Swapwriter active.
[  228.395093]   Swap available for image: 295184 pages.
[  228.395095] - Filewriter inactive.
[  228.395097] - No I/O speed stats available.
[  238.455606] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  238.455611] suspend_userui: program not configured. suspend_userui disab=
led.
[  238.455802] Freezing processes
[  245.563055] Preparing Image.
[  246.461738] Suspend2 debugging info:
[  246.461741] - SUSPEND core   : 2.2.0.1
[  246.461742] - Kernel Version : 2.6.15
[  246.461743] - Compiler vers. : 4.0
[  246.461745] - Attempt number : 7
[  246.461746] - Parameters     : 0 128 0 0 0 0
[  246.461747] - Overall expected compression percentage: 0.
[  246.461749] - Swapwriter active.
[  246.461750]   Swap available for image: 295184 pages.
[  246.461752] - Filewriter inactive.
[  255.808530] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  255.808537] suspend_userui: program not configured. suspend_userui disab=
led.
[  255.808785] Freezing processes
[  275.877164] Preparing Image.
[  276.277097] Losing some ticks... checking if CPU frequency changed.
[  276.705838] Suspend2 debugging info:
[  276.705841] - SUSPEND core   : 2.2.0.1
[  276.705842] - Kernel Version : 2.6.15
[  276.705844] - Compiler vers. : 4.0
[  276.705845] - Attempt number : 8
[  276.705846] - Parameters     : 0 128 0 0 0 0
[  276.705848] - Overall expected compression percentage: 0.
[  276.705849] - Swapwriter active.
[  276.705850]   Swap available for image: 295184 pages.
[  276.705852] - Filewriter inactive.
[  276.705853] - No I/O speed stats available.
[  288.497553] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  288.497559] suspend_userui: program not configured. suspend_userui disab=
led.
[  288.497791] Freezing processes
[  290.355243] Preparing Image.
[  291.262225] Suspend2 debugging info:
[  291.262228] - SUSPEND core   : 2.2.0.1
[  291.262229] - Kernel Version : 2.6.15
[  291.262230] - Compiler vers. : 4.0
[  291.262232] - Attempt number : 9
[  291.262233] - Parameters     : 0 128 0 0 0 0
[  291.262234] - Overall expected compression percentage: 0.
[  291.262236] - Swapwriter active.
[  291.262237]   Swap available for image: 295184 pages.
[  291.262239] - Filewriter inactive.
[  291.262240] - No I/O speed stats available.
[  309.866461] Suspend2 2.2.0.1: Initiating a software suspend cycle.
[  309.866467] suspend_userui: program not configured. suspend_userui disab=
led.
[  309.866655] Freezing processes
[  322.885993] Preparing Image.
[  323.860115] Suspend2 debugging info:
[  323.860118] - SUSPEND core   : 2.2.0.1
[  323.860119] - Kernel Version : 2.6.15
[  323.860121] - Compiler vers. : 4.0
[  323.860122] - Attempt number : 10
[  323.860123] - Parameters     : 0 128 0 0 0 0
[  323.860125] - Overall expected compression percentage: 0.
[  323.860126] - Swapwriter active.
[  323.860128]   Swap available for image: 295184 pages.
[  323.860129] - Filewriter inactive.
[  323.860130] - No I/O speed stats available.



=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1378275.IraQpXNjcZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3aouN0y+n1M3mo0RAo7WAJ0aNv7ioTk7pu8vXgVojGsc9S3oKwCg6eP+
Zp5oICv5QslVXHe2cGYVUQ4=
=QWtg
-----END PGP SIGNATURE-----

--nextPart1378275.IraQpXNjcZ--
