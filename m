Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSKTWNy>; Wed, 20 Nov 2002 17:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSKTWNx>; Wed, 20 Nov 2002 17:13:53 -0500
Received: from 216-164-48-121.c3-0.gth-ubr1.lnh-gth.md.cable.rcn.com ([216.164.48.121]:37259
	"EHLO zalem.puupuu.org") by vger.kernel.org with ESMTP
	id <S262821AbSKTWNu>; Wed, 20 Nov 2002 17:13:50 -0500
Date: Wed, 20 Nov 2002 17:20:54 -0500
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: jiffies wrap in ll_rw_blk.c
Message-ID: <20021120172054.D12712@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DDBF413.C06DAF2E@splentec.com> <1037827173.3267.78.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1037827173.3267.78.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 20, 2002 at 09:19:33PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 09:19:33PM +0000, Alan Cox wrote:
> On Wed, 2002-11-20 at 20:44, Luben Tuikov wrote:
> > --- ll_rw_blk.c.old     Wed Nov 20 15:32:50 2002
> > +++ ll_rw_blk.c Wed Nov 20 15:33:06 2002
> > @@ -2092,7 +2092,7 @@
> >                 complete(req->waiting);
> >  
> >         if (disk) {
> > -               unsigned long duration = jiffies - req->start_time;
> > +               unsigned long duration = (signed) jiffies - (signed) req->start_time;
> >                 switch (rq_data_dir(req)) {
> 
> It was right before. Your patch breaks it. Think about it in unsigned
> maths
> 
>               0x00000002 - 0xFFFFFFFF = 0x00000003

Signed vs. unsigned is actually irrelevant in two-complement systems
as long as you don't compare.  Only the int/long issue has an actual
effect.

  OG.

