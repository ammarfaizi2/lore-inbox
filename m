Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSKTUxy>; Wed, 20 Nov 2002 15:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSKTUxy>; Wed, 20 Nov 2002 15:53:54 -0500
Received: from ns.splentec.com ([209.47.35.194]:56325 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S261894AbSKTUxr>;
	Wed, 20 Nov 2002 15:53:47 -0500
Message-ID: <3DDBF7FC.B0DBC75D@splentec.com>
Date: Wed, 20 Nov 2002 16:00:44 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH]: jiffies wrap in ll_rw_blk.c
References: <3DDBF413.C06DAF2E@splentec.com> <1037827173.3267.78.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
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

0x2 - (-0x1) = 0x2 + 0x1 = 0x3

Right! I thought (signed) does the job. I actually tried
it both ways and works all right. I guess either way works fine.

-- 
Luben
