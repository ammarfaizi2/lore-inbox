Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317362AbSFRInB>; Tue, 18 Jun 2002 04:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317364AbSFRInA>; Tue, 18 Jun 2002 04:43:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:47871 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317362AbSFRIm7>; Tue, 18 Jun 2002 04:42:59 -0400
Date: Tue, 18 Jun 2002 10:42:53 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Filip Sneppe <filip.sneppe@chello.be>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       <arrays@compaq.com>
Subject: Re: 2.4.19-pre10 link error - cpqarray related ?
In-Reply-To: <1024355796.27926.23.camel@exile>
Message-ID: <Pine.NEB.4.44.0206181035480.7375-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2002, Filip Sneppe wrote:

> Hi,

Hi Filip,

first of all thanks for your report!

> I ran into some problems doing a "make bzImage" on 2.4.19-pre10:
>...
> drivers/block/block.o(.data+0xc54): undefined reference to `local
> symbols in discarded section .text.exit'
> make: *** [vmlinux] Error 1
>...
> After looking at the changelog and my kernel options, I found that
> the compilation failed when:
>
> CONFIG_BLK_CPQ_DA=y
> CONFIG_BLK_CPQ_CISS_DA=y
>...


The following patch fixes it (cpqarray_remove_one is __devexit but the
pointer to it didn't use __devexit_p):


--- drivers/block/cpqarray.c.old	Tue Jun 18 10:19:55 2002
+++ drivers/block/cpqarray.c	Tue Jun 18 10:30:27 2002
@@ -602,7 +602,7 @@
 static struct pci_driver cpqarray_pci_driver = {
         name:   "cpqarray",
         probe:  cpqarray_init_one,
-        remove:  cpqarray_remove_one,
+        remove:  __devexit_p(cpqarray_remove_one),
         id_table:  cpqarray_pci_device_id,
 };



> Kind regards,
> Filip
>...

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



