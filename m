Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317406AbSGIUcN>; Tue, 9 Jul 2002 16:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317408AbSGIUcM>; Tue, 9 Jul 2002 16:32:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317406AbSGIUcL>;
	Tue, 9 Jul 2002 16:32:11 -0400
Message-ID: <3D2B487B.FC24E2E@zip.com.au>
Date: Tue, 09 Jul 2002 13:32:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
       Dave Jones <davej@suse.de>
Subject: Re: 2.5: smc9194.c + smc-ircc.c: multiple definition of `smc_init'
References: <Pine.NEB.4.44.0207091203270.20908-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> ...
> irda/built-in.o: In function `smc_init':
> irda/built-in.o(.text.init+0x1624): multiple definition of `smc_init'
> smc9194.o(.text.init+0x0): first defined here
> ld: Warning: size of symbol `smc_init' changed from 101 to 10 in
> irda/built-in.o

yup.   There's an smc_init() in drivers/net/irda/smc-ircc.c and
another in drivers/net/smc9194.c.  The latter cannot be made static
because drivers/net/Space.c refers to it.  But we can make the irda
one static.

And yes, 2.5.25 needs this.

--- 2.5.25/drivers/net/irda/smc-ircc.c~smc-init	Tue Jul  9 13:28:51 2002
+++ 2.5.25-akpm/drivers/net/irda/smc-ircc.c	Tue Jul  9 13:28:53 2002
@@ -1203,7 +1203,7 @@ static int __exit ircc_close(struct ircc
 	return 0;
 }
 
-int __init smc_init(void)
+static int __init smc_init(void)
 {
 	return ircc_init();
 }

-
