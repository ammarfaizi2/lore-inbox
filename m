Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbSKDLHY>; Mon, 4 Nov 2002 06:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbSKDLHY>; Mon, 4 Nov 2002 06:07:24 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15108 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262159AbSKDLHS>; Mon, 4 Nov 2002 06:07:18 -0500
Message-Id: <200211041108.gA4B8Pp32085@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jussi Laako <jussi.laako@kolumbus.fi>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Mon, 4 Nov 2002 14:00:20 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <200211031925.gA3JPHp29128@Port.imtp.ilyichevsk.odessa.ua> <1036358886.26281.19.camel@vaarlahti.uworld>
In-Reply-To: <1036358886.26281.19.camel@vaarlahti.uworld>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 19:28, Jussi Laako wrote:
> On Mon, 2002-11-04 at 02:17, Denis Vlasenko wrote:
> > Alignment does not eliminate jump. It only moves jump target to 16
> > byte boundary.
>
> Exactly. And P4 cache is _very_ bad at anything not 16-byte aligned.
> The speed penalty is big. This seems to be problem only with Intel
> CPU's, no such large effects on AMD ones.

So we are going to waste that space in _all_ kernels just for Intel P4
being stupid? I compile fernels for _486_! At home I have a Duron.
I don't want to pay "P4 tax" ;)

Also, once it gets cached at first access, subsequent accesses won't
hurt that much, right?

> > This _probably_ makes execution slightly faster but on average
> > it costs you 7,5 bytes. This price is too high when you take into
> > account L1 instruction cache wastage and current bus/core clock
> > ratios.
>
> 7.5 bytes is not much compared to possibility of trashed cache or
> pipeline flush.

You definitely need to play with objdump -d just to see those 7.5 bytes
everywhere.

Pipeline flush is moot, you have jump penalty regrdless of alignment.

> Do you have execution time numbers of jump to 16-byte aligned address
> vs unaligned address?

I will do.

Let me say this clear:

	If you do million iterations loop, maybe you should align it.

	It is very dumb to align everything in the hope it will
	magically make your kernel run 2x faster.
--
vda
