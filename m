Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVFNF11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVFNF11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 01:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFNF10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 01:27:26 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:22672 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261175AbVFNFWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 01:22:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=esxeGHZ9JI4e7vQk3NpOwO3TyXBBCDUGnUYsfTxoLcm0/ZGs+fWnDDfOMJlS5ra89ScSuSC1usy4CU9VR01Odh704l6+ErHsPGL8raqfkwxhtV76r3DxHihC8Zdobzk2gUogxeTDzfYwxjNzLtUS3i7SzDj4IuJGKw3kQtjmZIM=
Message-ID: <b70d738005061322223fc7942@mail.gmail.com>
Date: Mon, 13 Jun 2005 22:22:43 -0700
From: Adam Morley <adam.morley@gmail.com>
Reply-To: Adam Morley <adam.morley@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <b70d738005060821032cc1a4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5549_22052558.1118726563735"
References: <b70d73800506051924546c8931@mail.gmail.com>
	 <b70d7380050608093138eb42df@mail.gmail.com>
	 <b70d738005060819274653fd8@mail.gmail.com>
	 <200506082143.35199.dtor_core@ameritech.net>
	 <b70d738005060821032cc1a4a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_5549_22052558.1118726563735
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi All,

I hadn't heard anything from Dimitry in a few days, so I thought I'd
resend and see if anyone else had any pointers for where I should
look.  I'd still love to have a functional mouse post-mem suspend.

Thanks a bunch!
Adam

On 6/8/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Wednesday 08 June 2005 21:27, Adam Morley wrote:
> > On 6/8/05, Adam Morley <adam.morley@gmail.com> wrote:
> > > Hi Dimitry,
> > >
> > > On 6/8/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > On 6/8/05, Adam Morley <adam.morley@gmail.com> wrote:
> > > > > Hi Dmitry,
> > > > >
> > > > > By Embedded Controller, do you mean CONFIG_ACPI_EC?  Because I ca=
n't
> > > > > disable it w/o disable a bunch of ACPI modules, I think.
> > > >
> > > > As far as I remember EC is only required for smart battery supports=
.
> > > > For testing purposes it is OK to not have it.
> > >
> > > It seems that even when I set it to "# CONFIG_ACPI_EC is not set", it
> > > gets re-enabled by make at some point.  I twiddled a couple of ACPI
> > > modules off (save button), and it was still re-enabled.  I think I'd
> > > have to disable ACPI.  I will play around with it some more though.
> >
> > I'm still poking around trying to figure out how to disable
> > CONFIG_ACPI_EC.  Once I get that done, I will post results.  Yeah, I
> > can't get that to stay unset.  Every time I run make, I end up with it
> > set to Y, even if I've disabled it before.
>
> Try using "make menuconfig" to do that - Help should show you what
> depends on EC.

That's actually part of my problem --- CONFIG_ACPI_EC doesn't show up
in menuconfig.  Under "Power management options (ACPI, APM)" -> "ACPI
(Advanced Configuration and Power Interface) Support," I don't see
anything which says "Embedded controller."

Of course, now that I look at the Kconfig file in drivers/acpi, it
looks like CONFIG_ACPI_EC has "depends on X86," but I'm using
"CONFIG_X86=3Dy," "CONFIG_X86_PC=3Dy" and "CONFIG_MCRUSOE=3Dy."  So I would
think it would show up.

Either way, I changed the default for CONFIG_ACPI_EC from "y" to "n"
(in drivers/acpi/Kconfig) and now I seem to be able to build w/o the
EC.  Attached is a dmesg (w/i8042.debug), and config.  All devices in
/sys/bus/pnp/devices still show "state =3D active" in the resources
file.  No mouse working.  Please note, I disabled almost all ACPI
functionality (button, proc, fan, thermal, etc.) in addition to EC.  I
kept enough to keep suspend working.  And I suspended with "echo mem >
/sys/power/state"

Thanks.  Just wondering my use of Crusoe optimizations shouldn't
matter, should they?  That's the only "weird" thing I'm doing here.

--
adam

------=_Part_5549_22052558.1118726563735
Content-Type: text/plain; name=dmesg.no_ec.pnp_debug.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.no_ec.pnp_debug.txt"

erio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [341228]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [341230]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [341231]
drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, KBD, 1) [341449]
drivers/input/serio/i8042.c: 09 <- i8042 (interrupt, AUX, 12) [341599]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [341600]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [341604]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [341707]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [341708]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [341712]
drivers/input/serio/i8042.c: b8 <- i8042 (interrupt, KBD, 1) [341782]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341824]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [341826]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341828]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [341854]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [341855]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [341857]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341865]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [341866]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341867]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341876]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [341877]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341878]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341887]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [341888]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341889]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341897]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, AUX, 12) [341899]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341900]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341908]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, AUX, 12) [341910]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341911]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341919]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, AUX, 12) [341920]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [341922]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341930]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [341931]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341933]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341941]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, AUX, 12) [341942]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [341943]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341952]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, AUX, 12) [341953]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341954]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341962]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, AUX, 12) [341964]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [341965]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341973]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, AUX, 12) [341975]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [341976]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [341984]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [341985]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [341987]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342002]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, AUX, 12) [342004]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342005]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342021]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [342022]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [342023]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342032]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [342033]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342034]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342050]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [342052]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [342053]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342062]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [342063]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342065]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342080]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342082]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342083]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342092]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [342093]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342095]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342104]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342105]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342106]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342115]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [342116]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342117]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [342125]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342127]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [342128]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342136]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342138]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342139]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342147]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342149]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342150]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342158]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342159]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342161]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342169]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342170]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342172]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [342180]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342181]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [342183]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342191]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [342192]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342193]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [342202]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342203]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [342204]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [342245]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [342247]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [342249]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [342257]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [342259]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [342260]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [344067]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344094]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [344095]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [344099]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344109]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [344111]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344115]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344125]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [344126]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344130]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344140]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [344142]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344145]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344156]
drivers/input/serio/i8042.c: fd <- i8042 (interrupt, AUX, 12) [344158]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [344161]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344171]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [344172]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344176]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344187]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [344188]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [344192]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344202]
drivers/input/serio/i8042.c: fd <- i8042 (interrupt, AUX, 12) [344203]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [344206]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344208]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344216]
drivers/input/serio/i8042.c: fd <- i8042 (interrupt, AUX, 12) [344217]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, AUX, 12) [344219]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [344227]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [344228]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344230]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344238]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [344240]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344242]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344257]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [344259]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344260]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344275]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [344277]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [344278]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, AUX, 12) [344286]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [344288]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344289]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, AUX, 12) [344344]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [344346]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, AUX, 12) [344347]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [344386]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [344388]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [344389]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [345368]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [345368]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [345370]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [345370]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [345371]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [345371]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, AUX, 12) [345374]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [345376]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [345944]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [345944]
Stopping tasks: =======================================|
drivers/input/serio/i8042.c: 60 -> i8042 (command) [348547]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [348547]
eth1: Orinoco-PCI entering sleep mode (state=3)
 hwsleep-0306 [03] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKU] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKH] -> GSI 9 (level, low) -> IRQ 9
 pci_irq-0370 [06] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI - using IRQ 0
eth1: Orinoco-PCI waking up
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
drivers/input/serio/i8042.c: 60 -> i8042 (command) [367471]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [367471]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [367472]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [367472]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [367472]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [367472]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [367473]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [367477]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [367484]
drivers/input/serio/i8042.c: 54 <- i8042 (interrupt, KBD, 1) [367489]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [367573]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [367576]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [367673]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [367676]
drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [367773]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [367776]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [367873]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [367876]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [367973]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [367976]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [368073]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [368076]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [368173]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [368176]
Restarting tasks...<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [368356]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [368356]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [368357]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [368357]
 done
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [368379]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [368381]
drivers/input/serio/i8042.c: ed -> i8042 (parameter) [368381]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [368403]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [368403]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [368403]
usb 1-3: USB disconnect, address 2
usb 1-3: new low speed USB device using ohci_hcd and address 3
drivers/input/serio/i8042.c: 60 -> i8042 (command) [369034]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [369034]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [369035]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [369035]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [369056]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [369057]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [369057]
input: USB HID v1.00 Mouse [Fujitsu Takamisawa USB Touch Panel] on usb-0000:00:02.0-3
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [382976]

------=_Part_5549_22052558.1118726563735
Content-Type: text/plain; name=config.no_ec.pnp_debug.2.6.12-rc5.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config.no_ec.pnp_debug.2.6.12-rc5.txt"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.12-rc5
# Wed Jun  8 20:03:20 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
CONFIG_MCRUSOE=y
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda3"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
# CONFIG_ACPI_EC is not set
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set

#
# CPUFreq processor drivers
#
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
CONFIG_X86_LONGRUN=m
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=m

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_DEBUG=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
# CONFIG_IP_NF_MATCH_OWNER is not set
# CONFIG_IP_NF_MATCH_PHYSDEV is not set
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
# CONFIG_IP_NF_TARGET_TCPMSS is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# Bridge: Netfilter Configuration
#
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=m
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
CONFIG_PCMCIA_WL3501=m

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=600
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=1024
CONFIG_INPUT_TSDEV_SCREEN_Y=600
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_MWAVE=m
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
# CONFIG_SND_SEQUENCER_OSS is not set
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_ALI5451=m
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
CONFIG_SND_TRIDENT=m
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
CONFIG_USB_BLUETOOTH_TTY=m
# CONFIG_USB_MIDI is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
CONFIG_USB_MTOUCH=m
CONFIG_USB_EGALAX=m
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_MON=m

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_AIRPRIME=m
CONFIG_USB_SERIAL_BELKIN=m
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP2101 is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_HP4X is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

------=_Part_5549_22052558.1118726563735--
