Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283510AbRLMGdZ>; Thu, 13 Dec 2001 01:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283500AbRLMGdP>; Thu, 13 Dec 2001 01:33:15 -0500
Received: from zok.sgi.com ([204.94.215.101]:19354 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S283489AbRLMGc6>;
	Thu, 13 Dec 2001 01:32:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rob Hensley <zoid@zoid.staticky.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, arjanv@redhat.com
Subject: Re: debian unstable and 2.4.16-pre8... 
In-Reply-To: Your message of "Wed, 12 Dec 2001 21:33:44 CDT."
             <Pine.LNX.4.33.0112122124480.21682-100000@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 17:32:38 +1100
Message-ID: <24912.1008225158@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001 21:33:44 -0500 (EST), 
Rob Hensley <zoid@zoid.staticky.com> wrote:
>drivers/pcmcia/pcmcia.o(.data+0x1294): undefined reference to `local
>symbols in discarded section .text.exit'

I converted functions defined as __devexit, i82092.c incorrectly used
__exit.  Patch against 2.4.17-pre8, Marcelo please apply.

I resisted the temptation to clean up the white space at the same time,
i82092.c has 176 lines with spurious trailing white space.

Index: 17-pre8.1/drivers/pcmcia/i82092.c
--- 17-pre8.1/drivers/pcmcia/i82092.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/E/f/35_i82092.c 1.2 644)
+++ 17-pre8.1(w)/drivers/pcmcia/i82092.c Thu, 13 Dec 2001 17:27:28 +1100 kaos (linux-2.4/E/f/35_i82092.c 1.2 644)
@@ -42,7 +42,7 @@ static struct pci_driver i82092aa_pci_dr
 	name:           "i82092aa",
 	id_table:       i82092aa_pci_ids,
 	probe:          i82092aa_pci_probe,
-	remove:         i82092aa_pci_remove,
+	remove:         __devexit_p(i82092aa_pci_remove),
 	suspend:        NULL,
 	resume:         NULL 
 };
@@ -160,7 +160,7 @@ static int __init i82092aa_pci_probe(str
 	return 0;
 }
 
-static void __exit i82092aa_pci_remove(struct pci_dev *dev)
+static void __devexit i82092aa_pci_remove(struct pci_dev *dev)
 {
 	enter("i82092aa_pci_remove");
 	

