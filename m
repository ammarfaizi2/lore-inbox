Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSG2LbU>; Mon, 29 Jul 2002 07:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSG2LbU>; Mon, 29 Jul 2002 07:31:20 -0400
Received: from maillog21.sis.com.tw ([203.67.208.41]:26583 "EHLO
	maillog01.sis.com.tw") by vger.kernel.org with ESMTP
	id <S315278AbSG2LbT>; Mon, 29 Jul 2002 07:31:19 -0400
Message-ID: <003d01c236f4$110b0450$e6d113ac@sis2262>
From: "L.C. Chang" <lcchang@sis.com.tw>
To: "Daniela Engert" <dani@ngrt.de>, "Lionel Bouton" <Lionel.Bouton@inet6.fr>
Cc: "???" <ollie@sis.com.tw>, "???" <kmliu@sis.com.tw>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <3D448052.4070805@inet6.fr> <20020729070252.9F16E1107A@mail.medav.de> <20020729105626.A16395@bouton.inet6-interne.fr>
Subject: Re: SiS 5513 ATA133 support patch for 2.4.19-rc3-ac3
Date: Mon, 29 Jul 2002 19:35:40 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-MIMETrack: Itemize by SMTP Server on twhqm03/HQ/SiS(Release 5.0.9 |November 16, 2001) at
 07/29/2002 07:25:34 PM,
	Serialize by Router on twhqm03/HQ/SiS(Release 5.0.9 |November 16, 2001) at
 07/29/2002 07:25:35 PM,
	Serialize complete at 07/29/2002 07:25:35 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SiS 745/746/750/... like 645/646/650/..., is an independent north bridge
which may be paired with SiS 961a/961b/962(963).
And as you known, the northbridge ID alone was not able to distinguish
the UDMA support in those chipset family. So I changed all of them
to ATA133 in my patch. When ATA133 family found in
pci_init_sis5513(), I would look for further information to determine
which family it belongs to (ATA100/ATA133a/ATA133).

L.C.

> On lun, jui 29, 2002 at 09:11:34 +0200, Daniela Engert wrote:
> > On Mon, 29 Jul 2002 01:37:54 +0200, Lionel Bouton wrote:
> >
> >
> > Lionel,
> >
> > as you already figured out, looking at the northbridge IDs is simply
> > not sufficient to find out which capabilities and register layout the
> > IDE controller in the southbridge (no matter if integrated or external)
> > has.
> >
> > Some comments:
> >
> > 1) the 745 has an integrated southbridge and an ATA/100 capable IDE
> > controller
> >
>
> I believed so too, but Lei-Chun patch changed it to ATA133.
> Lei-Chun, could you tell us what we can expect from 745 chips ?
>
> > 2) the 646 (and most likely the 645 and others as well) may be paired
> > with a 961 (ATA/100) or 961B (ATA133) MutIOL southbridge with different
> > register programming values.
> >
> > Thus simply ripping out some northbridge IDs wouldn't prevent
> > corruption problems.
> >
>
> I don't see why (unless you refer to the 962/963 problem I did mention).
> If we remove the IDs, the chips will be detected as SiS5513 (ATA_16). If
> I'm correct, in this mode (only allowing PIO modes and SW/MW DMA modes)
> all chips are OK.
> I didn't dig in all specs to check each config register change, but all I
> saw was OK and I *never* received any data corruption report for a chip
that
> was configured as original SiS5513 (though I have many reports of bad
> performance due to PIO modes being used in such cases).
>
> LB.


