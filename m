Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290181AbSAWWbs>; Wed, 23 Jan 2002 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSAWWbl>; Wed, 23 Jan 2002 17:31:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:14346 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290181AbSAWWb3>; Wed, 23 Jan 2002 17:31:29 -0500
Message-ID: <3C4F3844.2CAC3D13@zip.com.au>
Date: Wed, 23 Jan 2002 14:25:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
CC: Ruben =?iso-8859-1?Q?P=FCttmann?= <ruben.puettmann@freenet-ag.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems compiling 2.4.18-pre6
In-Reply-To: <3C4F32F5.6080807@freenet-ag.de>,
		<3C4F32F5.6080807@freenet-ag.de> <20020123222650.GA5005@telia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

André Dahlqvist wrote:
> 
> Ruben Püttmann <ruben.puettmann@freenet-ag.de> wrote:
> 
> > i want test the pre 6 but I ever get this message:
> >
> > drivers/sound/sounddrivers.o (.data+0xB4): undefined reference to 'local
> > symbols in discarded section .text.exit'
> 
> As a workaround, compile VIA82CXXX as a module. I'm pretty sure Andrew
> Morton (?) came up with a patch for this before, but it seams it did't get
> included.

hmm.  So I did.

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
