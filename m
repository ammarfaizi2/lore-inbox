Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSFEIS5>; Wed, 5 Jun 2002 04:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSFEIS4>; Wed, 5 Jun 2002 04:18:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:18686 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313508AbSFEIS4>; Wed, 5 Jun 2002 04:18:56 -0400
Date: Wed, 5 Jun 2002 10:18:52 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Keith Owens <kaos@ocs.com.au>, <greg@kroah.com>,
        Johannes Erdfelt <johannes@erdfelt.com>
cc: Joseph Pingenot <trelane@digitasaru.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Build error on 2.5.20 under unstable debian 
In-Reply-To: <23055.1023262706@kao2.melbourne.sgi.com>
Message-ID: <Pine.NEB.4.44.0206050958190.9994-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Keith Owens wrote:

>...
> R_386_32 is an ELF relocation type for ix86 binaries.  It means that
> uhci-hcd.c has code that refers to a function defined as __exit.  The
> only such function is uhci_hcd_cleanup but I cannot see where it is
> being referenced.  The USB people should be able to track this one
> down.

uhci_stop is __devexit but the pointer to it doesn't use __devexit_p.
The fix is simple:

--- drivers/usb/host/uhci-hcd.c.old	Wed Jun  5 09:59:00 2002
+++ drivers/usb/host/uhci-hcd.c	Wed Jun  5 10:13:09 2002
@@ -2515,7 +2515,7 @@
 	suspend:		uhci_suspend,
 	resume:			uhci_resume,
 #endif
-	stop:			uhci_stop,
+	stop:			__devexit_p(uhci_stop),

 	hcd_alloc:		uhci_hcd_alloc,
 	hcd_free:		uhci_hcd_free,

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



