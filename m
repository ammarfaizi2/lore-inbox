Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbSJYLIr>; Fri, 25 Oct 2002 07:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSJYLIq>; Fri, 25 Oct 2002 07:08:46 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:32775 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261352AbSJYLIq>; Fri, 25 Oct 2002 07:08:46 -0400
Message-Id: <200210251108.g9PB86p15344@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Csum and csum copyroutines benchmark
Date: Fri, 25 Oct 2002 14:00:37 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Momchil Velikov <velco@fadata.bg>, Russell King <rmk@arm.linux.org.uk>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <200210250906.g9P96Yp14775@Port.imtp.ilyichevsk.odessa.ua> <1035541191.12995.12.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1035541191.12995.12.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 October 2002 08:19, Alan Cox wrote:
> On Fri, 2002-10-25 at 14:59, Denis Vlasenko wrote:
> > Well, that makes it run entirely in L0 cache. This is unrealistic
> > for actual use. movntq is x3 faster when you hit RAM instead of L0.
> >
> > You need to be more clever than that - generate pseudo-random
> > offsets in large buffer and run on ~1K pieces of that buffer.
>
> In a lot of cases its extremely realistic to assume the network
> buffers are in cache. The copy/csum path is often touching just
> generated data, or data we just accessed via read(). The csum RX path
> from a card with DMA is probably somewhat different.

'Touching' is not interesting since it will pump data
into cache, no matter how you 'touch' it.

Running benchmarks against 1K static buffer makes cache red hot
and causes _all writes_ to hit it. It may lead to wrong conclusions. 

Is _dst_ buffer of csum_copy going to be used by processor soon?
If yes, we shouldn't use movntq, we want to cache dst.
If no, we should by all means use movntq.
If sometimes, then optimal strategy does not exist. :(
--
vda
