Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbSJYJ5O>; Fri, 25 Oct 2002 05:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSJYJ5N>; Fri, 25 Oct 2002 05:57:13 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:46533 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261301AbSJYJ5N>; Fri, 25 Oct 2002 05:57:13 -0400
Subject: Re: Csum and csum copyroutines benchmark
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Momchil Velikov <velco@fadata.bg>, Russell King <rmk@arm.linux.org.uk>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210250906.g9P96Yp14775@Port.imtp.ilyichevsk.odessa.ua>
References: <200210231218.18733.roy@karlsbakk.net>
	<200210250643.g9P6hop13980@Port.imtp.ilyichevsk.odessa.ua>
	<87n0p3x8lh.fsf@fadata.bg> 
	<200210250906.g9P96Yp14775@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 11:19:51 +0100
Message-Id: <1035541191.12995.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 14:59, Denis Vlasenko wrote:
> Well, that makes it run entirely in L0 cache. This is unrealistic
> for actual use. movntq is x3 faster when you hit RAM instead of L0.
> 
> You need to be more clever than that - generate pseudo-random
> offsets in large buffer and run on ~1K pieces of that buffer.

In a lot of cases its extremely realistic to assume the network buffers
are in cache. The copy/csum path is often touching just generated data,
or data we just accessed via read(). The csum RX path from a card with
DMA is probably somewhat different.

