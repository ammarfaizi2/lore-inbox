Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRDBSA7>; Mon, 2 Apr 2001 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbRDBSAt>; Mon, 2 Apr 2001 14:00:49 -0400
Received: from smtp01.web.de ([194.45.170.210]:54034 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S131246AbRDBSAi>;
	Mon, 2 Apr 2001 14:00:38 -0400
Message-ID: <003c01c0bb9e$851756a0$c70ca8c0@klabunde>
From: "Roland Klabunde" <roland.klabunde@web.de>
To: <imesmits@xs4all.nl>, <linux-kernel@vger.kernel.org>
Cc: <r.klabunde@berkom.de>, <info@scitel.de>, <kkeil@suse.de>
In-Reply-To: <3AC4A0A9.EA78984@xs4all.nl>
Subject: Re: [PATCH] drivers/isdn/hisax/bkm_a8.c, kernel 2.4.2 (Scitel Quadro)
Date: Mon, 2 Apr 2001 19:58:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

great to hear, that the fix solves the problem. Is there any information
about, whether and when the fix will migrate into the isdn4l source pool?

Roland



----- Original Message -----
From: <imesmits@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Cc: <r.klabunde@berkom.de>; <info@scitel.de>; <kkeil@suse.de>
Sent: Friday, March 30, 2001 5:05 PM
Subject: [PATCH] drivers/isdn/hisax/bkm_a8.c, kernel 2.4.2 (Scitel Quadro)


> Hi,
>
> Please find attached a patch to fix the following problems with the
> Scitel Quadro ISDN card in 2.4 kernels which suddenly arised when I
> bought
> a K7T Pro motherboard.
>
> kernel: HiSax: Scitel port 0xcc00-0xcd00 already in use
> kernel: HiSax: Card Scitel Quadro not installed !
>
> Credits go to Roland Klabunde who told me early december:
>
> <quote>
> The Scitel [...] resource requirements are as follows:
>
> - 1 shared interrupt for all controllers
> - 1 shared port address for all controllers with a range of 128 bytes
> - 1 port address for each controller with a range of 64 bytes
>
> [...]
>
> I've currently downloaded the ISDN stuff [...] As mentioned above, the
> span is *128* for pci_ioaddr1 and *64* for pci_ioaddr2 to pci_ioaddr5
> [...]. What I see from the source is, that one attempts to claim a
> range of 256 bytes for pci_ioaddr1 to _5. That may cause the problems
> if the range overlaps with other boards. You may try to change the
> following calls in bkm_a8.c:
>
> sct_alloc_io(pci_ioaddr1, 256) to sct_alloc_io(pci_ioaddr1, 128)
> sct_alloc_io(pci_ioaddr2, 256) to sct_alloc_io(pci_ioaddr1, 64)
> sct_alloc_io(pci_ioaddr3, 256) to sct_alloc_io(pci_ioaddr1, 64)
> sct_alloc_io(pci_ioaddr4, 256) to sct_alloc_io(pci_ioaddr1, 64)
> sct_alloc_io(pci_ioaddr5, 256) to sct_alloc_io(pci_ioaddr1, 64)
>
> Please note the necessary changes in release_io_sct_quadro.
> </quote>
>
> Too bad I went on a holiday that time and forgot all about it, untill
> today (shame shame shame). Anyway, this patch to 2.4.2
> drivers/isdn/hisax/bkm_a8.c fixes the problem and everything runs
> fine again.
>
> Ime Smits
>
>

