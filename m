Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbTIMBSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 21:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTIMBSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 21:18:12 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:5808 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S261980AbTIMBSJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 21:18:09 -0400
Date: Sat, 13 Sep 2003 03:02:09 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
Subject: [FIX] Re: 2.4.23-pre3-pac2 broke PIIX ata-scsi
In-Reply-To: <3F6254A1.1020006@rackable.com>
Message-ID: <Pine.LNX.4.56.0309130130050.17972@dot.kde.org>
References: <Pine.LNX.4.56.0309111417580.31337@dot.kde.org>
 <3F6254A1.1020006@rackable.com>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-1257539054-1063414929=:18875"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-1257539054-1063414929=:18875
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 12 Sep 2003, Samuel Flory wrote:

>    So it looks like ATA_PIIX is broken:
> In file included from ata_piix.c:31:
> /stuff/src/linux-2.4.23-pac2/include/linux/ata.h:636: redefinition of 
> `irqreturn_t'
> /stuff/src/linux-2.4.23-pac2/include/linux/interrupt.h:16: `irqreturn_t' 
> previously declared here

Thanks for pointing out two bugs ;)

Since I compiled a fully modular kernel w/ everything enabled to 
verify everything builds, the report indicated another bug -- there was 
no way to build ATA_PIIX with modular SCSI.

The attached patch fixes both.

Since this is probably the first version of ATA_PIIX that does compile 
with modular SCSI, I'd like some feedback on whether or not it actually 
works w/ modular SCSI (I don't have any test hardware).

The patch will be in pre4-pac1, which I'm expecting to release tomorrow or 
Sunday.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-1257539054-1063414929=:18875
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.4.23-pre3-pac2-fix-sata.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0309130302090.18875@dot.kde.org>
Content-Description: Fix for SATA problem
Content-Disposition: attachment; filename="2.4.23-pre3-pac2-fix-sata.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yMy1wcmUzLXBhYzIvZHJpdmVycy9zY3Np
L0NvbmZpZy5pbiBsaW51eC0yLjQuMjMtcHJlMy1wYWMzL2RyaXZlcnMvc2Nz
aS9Db25maWcuaW4NCi0tLSBsaW51eC0yLjQuMjMtcHJlMy1wYWMyL2RyaXZl
cnMvc2NzaS9Db25maWcuaW4JMjAwMy0wOS0xMyAwMjozNTowOC4wMDAwMDAw
MDAgKzAyMDANCisrKyBsaW51eC0yLjQuMjMtcHJlMy1wYWMzL2RyaXZlcnMv
c2NzaS9Db25maWcuaW4JMjAwMy0wOS0xMyAwMjo0MTozNS4wMDAwMDAwMDAg
KzAyMDANCkBAIC03MSw3ICs3MSw3IEBADQogICAgZGVwX3RyaXN0YXRlICdB
TUkgTWVnYVJBSUQgc3VwcG9ydCAobmV3IGRyaXZlciknIENPTkZJR19TQ1NJ
X01FR0FSQUlEMiAkQ09ORklHX1NDU0kNCiBmaQ0KIA0KLWRlcF9ib29sICdT
QVRBIHN1cHBvcnQnIENPTkZJR19TQ1NJX0FUQSAkQ09ORklHX1NDU0kNCitk
ZXBfdHJpc3RhdGUgJ1NBVEEgc3VwcG9ydCcgQ09ORklHX1NDU0lfQVRBICRD
T05GSUdfU0NTSQ0KICNkZXBfYm9vbCAnICBQYXJhbGxlbCBBVEEgc3VwcG9y
dCcgQ09ORklHX1NDU0lfQVRBX1BBVEEgJENPTkZJR19TQ1NJX0FUQQ0KIGRl
cF90cmlzdGF0ZSAnICBJbnRlbCBQSUlYL0lDSCBzdXBwb3J0JyBDT05GSUdf
U0NTSV9BVEFfUElJWCAkQ09ORklHX1NDU0lfQVRBICRDT05GSUdfUENJDQog
ZGVwX3RyaXN0YXRlICcgIFZJQSBTQVRBIHN1cHBvcnQnIENPTkZJR19TQ1NJ
X1NBVEFfVklBICRDT05GSUdfU0NTSV9BVEEgJENPTkZJR19QQ0kNCmRpZmYg
LXVyTiBsaW51eC0yLjQuMjMtcHJlMy1wYWMyL2luY2x1ZGUvbGludXgvYXRh
LmggbGludXgtMi40LjIzLXByZTMtcGFjMy9pbmNsdWRlL2xpbnV4L2F0YS5o
DQotLS0gbGludXgtMi40LjIzLXByZTMtcGFjMi9pbmNsdWRlL2xpbnV4L2F0
YS5oCTIwMDMtMDktMTMgMDI6MzU6MTEuMDAwMDAwMDAwICswMjAwDQorKysg
bGludXgtMi40LjIzLXByZTMtcGFjMy9pbmNsdWRlL2xpbnV4L2F0YS5oCTIw
MDMtMDktMTMgMDI6NDE6NTEuMDAwMDAwMDAwICswMjAwDQpAQCAtNjI5LDEz
ICs2MjksNiBAQA0KIAlyZXR1cm4gc3RhdHVzOw0KIH0NCiANCi0vKg0KLSAq
IDIuNSBjb21wYXQuDQotICovDQotDQotdHlwZWRlZiB2b2lkIGlycXJldHVy
bl90Ow0KLSNkZWZpbmUgSVJRX1JFVFZBTCh4KQkvKiBub3RoaW5nICovDQot
DQogI2RlZmluZSBSRVBPUlRfTFVOUwkJMHhhMA0KICNkZWZpbmUgUkVBRF8x
NgkJCTB4ODgNCiAjZGVmaW5lIFdSSVRFXzE2CQkweDhhDQo=

--658386544-1257539054-1063414929=:18875--
