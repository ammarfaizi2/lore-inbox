Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSKTUzz>; Wed, 20 Nov 2002 15:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSKTUzy>; Wed, 20 Nov 2002 15:55:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:6788 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261646AbSKTUzx>; Wed, 20 Nov 2002 15:55:53 -0500
Subject: Re: [PATCH]: jiffies wrap in ll_rw_blk.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luben Tuikov <luben@splentec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <3DDBF7FC.B0DBC75D@splentec.com>
References: <3DDBF413.C06DAF2E@splentec.com>
	<1037827173.3267.78.camel@irongate.swansea.linux.org.uk> 
	<3DDBF7FC.B0DBC75D@splentec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 21:31:28 +0000
Message-Id: <1037827888.3267.84.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 21:00, Luben Tuikov wrote:sk) {
> > > -               unsigned long duration = jiffies - req->start_time;
> > > +               unsigned long duration = (signed) jiffies - (signed) req->start_time;
> > >                 switch (rq_data_dir(req)) {
> > 
> > It was right before. Your patch breaks it. Think about it in unsigned
> > maths
> > 
> >               0x00000002 - 0xFFFFFFFF = 0x00000003
> 
> 0x2 - (-0x1) = 0x2 + 0x1 = 0x3
> 
> Right! I thought (signed) does the job. I actually tried
> it both ways and works all right. I guess either way works fine.

(signed long) maybe - but not signed - long is 64bit on Alpha, (signed)
is 32

