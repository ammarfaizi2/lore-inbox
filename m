Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265364AbSKAT4u>; Fri, 1 Nov 2002 14:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265367AbSKAT4u>; Fri, 1 Nov 2002 14:56:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35575 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265364AbSKAT4s>; Fri, 1 Nov 2002 14:56:48 -0500
Date: Fri, 1 Nov 2002 21:03:10 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, <Jack_Hammer@adaptec.com>
Subject: Re: Linux 2.4.20-rc1
In-Reply-To: <Pine.LNX.4.44L.0210291358010.16425-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0211012056180.8262-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Marcelo Tosatti wrote:


> Hi,

Hi Marcelo,

> Finally, rc1.
>...
> Please stress test it.
>...

the following patch is still needed to fix a .text.exit error:

--- linux-2.4.19-full-nohotplug/drivers/scsi/ips.c.old	2002-10-04 18:49:10.000000000 +0200
+++ linux-2.4.19-full-nohotplug/drivers/scsi/ips.c	2002-10-04 18:50:02.000000000 +0200
@@ -305,21 +305,21 @@
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };

    struct pci_driver ips_pci_driver_5i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_5i,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };

    struct pci_driver ips_pci_driver_i960 = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_i960,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };

 #endif


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



