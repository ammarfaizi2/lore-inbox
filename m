Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286969AbRL1ScY>; Fri, 28 Dec 2001 13:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286971AbRL1ScN>; Fri, 28 Dec 2001 13:32:13 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:20747 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286969AbRL1ScD>; Fri, 28 Dec 2001 13:32:03 -0500
Message-ID: <3C2CB9F3.DC25E959@zip.com.au>
Date: Fri, 28 Dec 2001 10:29:07 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sound fails to build when non-modular with new binutils
In-Reply-To: <20011228151608.GA1870@telia.com> <4841.1009556591@ocs3.intra.ocs.com.au>,
		<4841.1009556591@ocs3.intra.ocs.com.au> <20011228170349.GA4955@telia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

André Dahlqvist wrote:
> 
> Keith Owens <kaos@ocs.com.au> wrote:
> 
> > Run this, it will say precisely where the problem lies:
> 
> Thanks Keith. Below is the output:
> 
> Finding objects, 315 objects, ignoring 0 module(s)
> Finding conglomerates, ignoring 29 conglomerate(s)
> Scanning objects
> Error: ./drivers/sound/via82cxxx_audio.o .data refers to 00000034
> R_386_32          .text.exit
> Done

Could you please check that this works OK?

--- linux-2.4.18-pre1/drivers/sound/via82cxxx_audio.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/sound/via82cxxx_audio.c	Fri Dec 28 10:27:51 2001
@@ -365,7 +365,7 @@ static struct pci_driver via_driver = {
 	name:		VIA_MODULE_NAME,
 	id_table:	via_pci_tbl,
 	probe:		via_init_one,
-	remove:		via_remove_one,
+	remove:		__devexit_p(via_remove_one),
 };
 
 
@@ -3271,7 +3271,7 @@ err_out:
 }
 
 
-static void __exit via_remove_one (struct pci_dev *pdev)
+static void __devexit via_remove_one (struct pci_dev *pdev)
 {
 	struct via_info *card;
