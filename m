Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSFROLn>; Tue, 18 Jun 2002 10:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSFROLm>; Tue, 18 Jun 2002 10:11:42 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:61707 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S317416AbSFROLk> convert rfc822-to-8bit; Tue, 18 Jun 2002 10:11:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.4.19-pre10 link error - cpqarray related ?
Date: Tue, 18 Jun 2002 09:11:23 -0500
Message-ID: <A2C35BB97A9A384CA2816D24522A53BB01E88FF0@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.19-pre10 link error - cpqarray related ?
Thread-Index: AcIWpCtJXhogBs6RQhKXrsZRsOA8AgALSfqg
From: "White, Charles" <Charles.White@hp.com>
To: "Adrian Bunk" <bunk@fs.tum.de>, "Filip Sneppe" <filip.sneppe@chello.be>
Cc: <linux-kernel@vger.kernel.org>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>, "Arrays" <arrays@hp.com>
X-OriginalArrivalTime: 18 Jun 2002 14:11:23.0994 (UTC) FILETIME=[073963A0:01C216D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting... It compiled for me fine.  Both statically and dynamic. 
 
What version of the compiler are you using?


-----Original Message-----
From: Adrian Bunk [mailto:bunk@fs.tum.de]
Sent: Tuesday, June 18, 2002 3:43 AM
To: Filip Sneppe
Cc: linux-kernel@vger.kernel.org; Marcelo Tosatti; Arrays
Subject: Re: 2.4.19-pre10 link error - cpqarray related ?


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



