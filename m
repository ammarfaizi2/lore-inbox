Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284951AbRLKOWo>; Tue, 11 Dec 2001 09:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284997AbRLKOWd>; Tue, 11 Dec 2001 09:22:33 -0500
Received: from ltspc67.epfl.ch ([128.178.121.34]:64643 "EHLO ltspc67.epfl.ch")
	by vger.kernel.org with ESMTP id <S284951AbRLKOWa>;
	Tue, 11 Dec 2001 09:22:30 -0500
Subject: Re: 2.4.16 / 2.4.17pre6 hang when loading agpgart
From: Diego SANTA CRUZ <Diego.SantaCruz@epfl.ch>
To: Roel.Teuwen@advalvas.be, reid.hekman@ndsu.nodak.edu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Dec 2001 15:22:19 +0100
Message-Id: <1008080540.14022.12.camel@ltspc67.epfl.ch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On my HP Omnibook 4150, 2.4.16 and 2.4.17-pre6 hang on boot right
after
> the messages below.
> I need to press the reset button and load a kernel without agpgart
> compiled in to boot. When compiled as a module, the machine hangs
after
> printing these lines when loading the module.
> 

I also have an HP Omnibook 4150 (model F1629N, PII 300 MHz and Neomagic
NM2200 card) and I have similar problems (if I try to load the agpgart
module it locks up the machine). Some time ago I did a bit of debugging
and I arrived to the conclusion that the BIOS does not initialize the
base of the aperture table (that can be seen by reading the APBASE
register of the PCI AGP controller or by doing "lspci -v" and seeing
that the memory is unassigned). That locks up the system whenever AGP is
enabled by the agpgart module (will try to access memory at 0x0).

Have you ever managed to get agpgart working on the OB 4150? If yes,
which exact model and with which BIOS on which kernel?

I'm using BIOS 2.28 and running kernel 2.4.9-13 (RedHat 7.2).

Relevant lspci data is:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 02)
	Flags: bus master, medium devsel, latency 64
	Memory at <unassigned> (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fe700000-fecfffff
	Prefetchable memory behind bridge: fd000000-fe3fffff


As you can see, 00:00.0 has the memory unassigned. I guess the BIOS
should set that up.

Any feedback very much appreciated!

Diego

PS: I'm not on lkml so a CC would be appreciated. More info on my HP
4150 setup at http://ltswww.epfl.ch/~dsanta/resources/hp4150-linux


-- 
-------------------------------------------------------
Diego Santa Cruz
PhD. student
Publications available at http://ltswww.epfl.ch/~dsanta
Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)
EPFL - DE - LTS, CH-1015 Lausanne, Switzerland
E-mail:     Diego.SantaCruz@epfl.ch
Phone:      +41 - 21 - 693 26 57
Fax:        +41 - 21 - 693 76 00
-------------------------------------------------------

