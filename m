Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSKTVI4>; Wed, 20 Nov 2002 16:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSKTVI4>; Wed, 20 Nov 2002 16:08:56 -0500
Received: from ns.splentec.com ([209.47.35.194]:4614 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S262604AbSKTVIe>;
	Wed, 20 Nov 2002 16:08:34 -0500
Message-ID: <3DDBFB75.6A3221A8@splentec.com>
Date: Wed, 20 Nov 2002 16:15:33 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH]: jiffies wrap in ll_rw_blk.c
References: <3DDBF413.C06DAF2E@splentec.com>
		<1037827173.3267.78.camel@irongate.swansea.linux.org.uk> 
		<3DDBF7FC.B0DBC75D@splentec.com> <1037827888.3267.84.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Wed, 2002-11-20 at 21:00, Luben Tuikov wrote:sk) {
> > > > -               unsigned long duration = jiffies - req->start_time;
> > > > +               unsigned long duration = (signed) jiffies - (signed) req->start_time;
> > > >                 switch (rq_data_dir(req)) {
> > >
> > > It was right before. Your patch breaks it. Think about it in unsigned
> > > maths
> > >
> > >               0x00000002 - 0xFFFFFFFF = 0x00000003
> >
> > 0x2 - (-0x1) = 0x2 + 0x1 = 0x3
> >
> > Right! I thought (signed) does the job. I actually tried
> > it both ways and works all right. I guess either way works fine.
> 
> (signed long) maybe - but not signed - long is 64bit on Alpha, (signed)
> is 32

Aaaah, I see where you're coming from.

I basically tried to stay away from knowing _what_ actual
type it is and just to make it signed and do the arithmetic,
but didn't know the specific for the Alpha.

Shouldn't this be (symbolically:) (signed (typeof(jiffes)) jiffies -
(signed (typeof(start)) start -- you know what I mean.

But yes both ways should work:
a, b are both unsigned, then a-b = a+(-b) and there's just no
other way to compute the result.

Anyway, doesn't matter,
-- 
Luben
