Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSHEKEH>; Mon, 5 Aug 2002 06:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSHEKEG>; Mon, 5 Aug 2002 06:04:06 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26364 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317598AbSHEKED>; Mon, 5 Aug 2002 06:04:03 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028541193.1572.114.camel@ldb>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb> 
	<1028498075.15200.29.camel@irongate.swansea.linux.org.uk> 
	<1028493814.26332.9.camel@ldb> 
	<1028505732.15495.38.camel@irongate.swansea.linux.org.uk> 
	<1028535126.1572.48.camel@ldb> 
	<1028540954.16550.26.camel@irongate.swansea.linux.org.uk> 
	<1028539877.1572.108.camel@ldb> 
	<1028545510.17780.28.camel@irongate.swansea.linux.org.uk> 
	<1028541193.1572.114.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 12:26:06 +0100
Message-Id: <1028546766.17775.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 10:53, Luca Barbieri wrote:
> > If OOSTORE is defined then we can't safely use any mmx operations, so
> > this is all noise and its still the case no change is required
> Yes, this is only for future processors (e.g. out-order AMD/Intels or
> Winchips with extended MMX).

The winchip line is dead so that bit is ok as it is. PPro is sorted with
the current code. The wmb() case therefore seems resolved already. The
guarantees already given by the processors are sufficient to ensure that
wmb is simply a compiler optimisation barrier for other cases (and
indeed the spinlock code breaks if it ceases to be true, as does an
awful lot of 'other vendors' code)

For the rmb() situation then yes your fence changes may well be a win on
the PIV, and would certainly be worth benchmarking. I'd be interested to
see the numbers.

Alan

