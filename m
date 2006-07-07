Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWGGVKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWGGVKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWGGVKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:10:04 -0400
Received: from smtp.ono.com ([62.42.230.12]:28518 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S932239AbWGGVKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:10:01 -0400
Date: Fri, 7 Jul 2006 23:09:22 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060707230922.7c8739a1@werewolf.auna.net>
In-Reply-To: <44AEC618.8040001@garzik.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
	<20060705170228.9e595851.akpm@osdl.org>
	<20060706163646.735f419f@werewolf.auna.net>
	<20060706164802.6085d203@werewolf.auna.net>
	<20060706234425.678cbc2f@werewolf.auna.net>
	<20060706145752.64ceddd0.akpm@osdl.org>
	<1152288168.20883.8.camel@localhost.localdomain>
	<20060707175509.14ea9187@werewolf.auna.net>
	<1152290643.20883.25.camel@localhost.localdomain>
	<20060707093432.571af16e.rdunlap@xenotime.net>
	<1152292196.20883.48.camel@localhost.localdomain>
	<44AE966F.8090506@garzik.org>
	<1152294245.20883.52.camel@localhost.localdomain>
	<44AE9C67.7000204@garzik.org>
	<1152302613.20883.58.camel@localhost.localdomain>
	<44AEBD17.3080107@garzik.org>
	<1152303822.20883.74.camel@localhost.localdomain>
	<44AEC0BF.7090504@garzik.org>
	<1152304961.20883.80.camel@localhost.localdomain>
	<44AEC618.8040001@garzik.org>
X-Mailer: Sylpheed-Claws 2.3.1cvs64 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 16:37:44 -0400, Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > Ar Gwe, 2006-07-07 am 16:14 -0400, ysgrifennodd Jeff Garzik:
> >> I'm a bit surprised to see pata_sis and pata_via:  are you certain there 
> >> is not confusion based on the fact that newer SiS, ULi and VIA 
> >> controllers provide both SATA and PATA on the same controller?
> > 
> > Hard to be sure but it looks like some vendors briefly used marvell
> > bridges of some form with a few generic PATA chipsets.
> 
> Yep.  The sata_xxx should cover most of the Marvell-SATA-bridge + PATA 
> chip controllers already.
> 
> Pretty much everybody except Silicon Image used the Marvell bridge for 
> their first generation SATA.
> 

Dumb view from outside the ATA world: why dont assume all controllers
can do both SATA and PATA, require some {p,s}ata_init(),
{p,s}ata_enumerate_drives() and so on, and provide no-ops as default
for them ? So SATA only can override sata_ ones, same for PATA and
the weird (really ICH5 is so strange ?) ones override both.

So you can decide later about doing

for each controller
	pata_init
	sata_init

or

for each controller
	sata_init
	pata_init

or

for each controller
	sata_init
for each controller
	pata_init

Just an idea. Good designed inheritance is good ;).

AH, and all the drivers could be named as 'ata_xxxx'. Nice.


--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
