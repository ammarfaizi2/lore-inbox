Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSFZRl1>; Wed, 26 Jun 2002 13:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSFZRl0>; Wed, 26 Jun 2002 13:41:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:22760 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316705AbSFZRlZ>; Wed, 26 Jun 2002 13:41:25 -0400
Date: Wed, 26 Jun 2002 19:41:20 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Knut J Bjuland <knutjbj@online.no>
cc: linux-kernel@vger.kernel.org, <jhartmann@addoes.com>
Subject: Re: bug in Linux 2.4.19RC1 i815e agpgart module, unable to determine
 aperture size.
In-Reply-To: <3D19E4F7.304EA4A6@online.no>
Message-ID: <Pine.NEB.4.44.0206261932180.4790-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2002, Knut J Bjuland wrote:

> I think I have found a bug in agpgart code in Linux.  To replicate this
> error boot into linux in text mode. Modeprobe agpgart and get this
> message.  Agpgart work flawless with Linux 2.4.19-pre10 and all other
> 2.4.X kernels. You may notice that I have Nvidia Geforce but NVdriver
>...

Since -rc1 agpgart_be.c uses for the 815 new 815-specific instead of the
generic intel functions.

Could you try whether reverting the following part of the patch fixes the
problem?

--- linux/drivers/char/agp/agpgart_be.c	2002-06-04 01:22:07.000000000 +0000
+++ linux/drivers/char/agp/agpgart_be.c	2002-06-24 15:23:36.000000000 +0000
@@ -3929,7 +4005,7 @@
 		INTEL_I815,
 		"Intel",
 		"i815",
-		intel_generic_setup },
+		intel_815_setup },
 	{ PCI_DEVICE_ID_INTEL_820_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I820,




cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

