Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbUDFWBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264033AbUDFWBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:01:41 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:59860 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S264023AbUDFWBi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:01:38 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@redhat.com>, Bjoern Michaelsen <bmichaelsen@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Wed, 7 Apr 2004 00:01:35 +0200
User-Agent: KMail/1.6.1
References: <20040406031949.GA8351@lord.sinclair> <200404062304.12089.volker.hemmann@heim10.tu-clausthal.de> <20040406210811.GA10142@redhat.com>
In-Reply-To: <20040406210811.GA10142@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404070001.35514.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 06 April 2004 23:08, Dave Jones wrote:

> Ok, too strange for words.
> I'm inclined to make things more explicit, and make
> sis_get_driver look like this..
>
> static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
> {
>     if (bridge->dev->device == PCI_DEVICE_ID_SI_648) {
>         sis_driver.agp_enable=sis_648_enable;
>         if (agp_bridge->major_version == 3) {
>             sis_driver.aperture_sizes       = agp3_generic_sizes;
>             sis_driver.size_type            = U16_APER_SIZE;
>             sis_driver.num_aperture_sizes   = AGP_GENERIC_SIZES_ENTRIES;
>             sis_driver.configure            = agp3_generic_configure;
>             sis_driver.fetch_size           = agp3_generic_fetch_size;
>             sis_driver.cleanup              = agp3_generic_cleanup;
>             sis_driver.tlb_flush            = agp3_generic_tlbflush;
>         }
>     }
>
>     if (bridge->dev->device == PCI_DEVICE_ID_SI_746) {
>         /*
>          * We don't know enough about the 746 to enable it properly.
>          * Though we do know that it needs the 'delay' hack to settle
>          * after changing modes.
>          */
>         sis_driver.agp_enable=sis_648_enable;
>     }
> }

ok, I was a little confused so:
vanilla 2.6.5+this patch: old testgart garbeling problem again
patched 2.6.5-rc3+this patch: everything fine
vanilla 2.6.5+agpgart-2004-04-06.diff+ this patch: everything fine, too

In each cases, I removed all .o and .ko files from drivers/char/agp 
and /lib/modules/2.6.5 to be sure.

Well, I dont care, if its believes to be at AGPv3 mode or not, as long X is 
working fine ;o)

Glück Auf
Volker

-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
