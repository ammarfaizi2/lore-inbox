Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbTEFMFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTEFMFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:05:34 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57999 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262624AbTEFMFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:05:30 -0400
Date: Tue, 6 May 2003 14:17:29 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: "Javi Pardo (DAKOTA)" <dakota@dakotabcn.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ataraid-list@redhat.com>
Subject: Re: promise NEITHER IDE PORT ENABLED
In-Reply-To: <3EB79542.5000903@gmx.net>
Message-ID: <Pine.SOL.4.30.0305061409260.25918-200000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1052223449=:25918"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1052223449=:25918
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi,

It is a config error, CONFIG_PDC202XX_FORCE depends on
CONFIG_BLK_DEV_PDC202XX_NEW. So even if you set it manually
in .config to y, the change won't be propagated.

Here is a quick patch to make force option visible for both old/new pdc.
More elegant solution will be to split force option for old/new pdc
as suggested by #fixme in Config.in.

Patch agaist 2.4.21-rc1, if it works for you please forward to Marcello.

Regards,
--
Bartlomiej

On Tue, 6 May 2003, Carl-Daniel Hailfinger wrote:

> Alan,
>
> could you please elaborate which of the options you meant is missing
> below? Thanks.
>
> Javi Pardo (DAKOTA) wrote:
> > Alan Cox wrote:
> >>Carl-Daniel Hailfinger wrote:
> >>
> >>>could you please take a look at this? I thought the IDE code in
> >>>2.4.21-rc1 is able to force enable the ports of a promise controller.
> >>
> >>It can - if you set the configuration option to do so
> >>
> >
> > i am the problem with the PDC20267 Chipset.
> >
> > i am downloaded the kernel 2.4.20 and 2.4.21-rc1
> > and i am set this options for IDE
> >
> > CONFIG_BLK_DEV_PDC202XX=y
> > # CONFIG_PDC202XX_BURST is not set
> > CONFIG_PDC202XX_FORCE=y                      <- this options force IDE detections
> > CONFIG_BLK_DEV_VIA82CXXX=y
> > # CONFIG_IDE_CHIPSETS is not set
> > CONFIG_IDEDMA_AUTO=y
> > # CONFIG_IDEDMA_IVB is not set
> > # CONFIG_DMA_NONPCI is not set
> > CONFIG_BLK_DEV_IDE_MODES=y
> > CONFIG_BLK_DEV_ATARAID=y
> > CONFIG_BLK_DEV_ATARAID_PDC=y
> > # CONFIG_BLK_DEV_ATARAID_HPT is not set
> >
> >
> > the kernel 2.4.20 and 2.4.21-rc1 NO detect the ide channels and mi system crashes
> >
> > wath is the problem? i am select all correct options but no work...
>
> Regards,
> Carl-Daniel

---559023410-959030623-1052223449=:25918
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pdc_old_force.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0305061417290.25918@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="pdc_old_force.diff"

LS0tIGxpbnV4LTIuNC4yMS1yYzEvZHJpdmVycy9pZGUvQ29uZmlnLmluCVNh
dCBBcHIgMjYgMTc6MTA6NDcgMjAwMw0KKysrIGxpbnV4L2RyaXZlcnMvaWRl
L0NvbmZpZy5pbglUdWUgTWF5ICA2IDEzOjQ2OjE1IDIwMDMNCkBAIC02Niw3
ICs2Niw3IEBADQogCSAgICBkZXBfYm9vbCAgICAgJyAgICAgIFNwZWNpYWwg
VURNQSBGZWF0dXJlJyBDT05GSUdfUERDMjAyWFhfQlVSU1QgJENPTkZJR19C
TEtfREVWX1BEQzIwMlhYX09MRCAkQ09ORklfQkxLX0RFVl9JREVETUFfUENJ
DQogCSAgICBkZXBfdHJpc3RhdGUgJyAgICBQUk9NSVNFIFBEQzIwMns2OHw2
OXw3MHw3MXw3NXw3Nnw3N30gc3VwcG9ydCcgQ09ORklHX0JMS19ERVZfUERD
MjAyWFhfTkVXICRDT05GSUdfQkxLX0RFVl9JREVETUFfUENJDQogCQkjIEZJ
WE1FIC0gcHJvYmFibHkgd2FudHMgdG8gYmUgb25lIGZvciBvbGQgYW5kIGZv
ciBuZXcNCi0JICAgIGRlcF9ib29sICAgICAnICAgICAgU3BlY2lhbCBGYXN0
VHJhayBGZWF0dXJlJyBDT05GSUdfUERDMjAyWFhfRk9SQ0UgJENPTkZJR19C
TEtfREVWX1BEQzIwMlhYX05FVw0KKwkgICAgZGVwX2Jvb2wgICAgICcgICAg
U3BlY2lhbCBGYXN0VHJhayBGZWF0dXJlJyBDT05GSUdfUERDMjAyWFhfRk9S
Q0UNCiAJICAgIGRlcF90cmlzdGF0ZSAnICAgIFJaMTAwMCBjaGlwc2V0IGJ1
Z2ZpeC9zdXBwb3J0JyBDT05GSUdfQkxLX0RFVl9SWjEwMDAgJENPTkZJR19Y
ODYNCiAJICAgIGRlcF90cmlzdGF0ZSAnICAgIFNDeDIwMCBjaGlwc2V0IHN1
cHBvcnQnIENPTkZJR19CTEtfREVWX1NDMTIwMCAkQ09ORklHX0JMS19ERVZf
SURFRE1BX1BDSQ0KIAkgICAgZGVwX3RyaXN0YXRlICcgICAgU2VydmVyV29y
a3MgT1NCNC9DU0I1L0NTQjYgY2hpcHNldHMgc3VwcG9ydCcgQ09ORklHX0JM
S19ERVZfU1ZXS1MgJENPTkZJR19CTEtfREVWX0lERURNQV9QQ0kNCg==
---559023410-959030623-1052223449=:25918--
