Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbTAXItK>; Fri, 24 Jan 2003 03:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbTAXItK>; Fri, 24 Jan 2003 03:49:10 -0500
Received: from jack.stev.org ([217.79.103.51]:20531 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S267605AbTAXItJ>;
	Fri, 24 Jan 2003 03:49:09 -0500
Message-ID: <00b601c2c387$ebc51c00$0cfea8c0@ezdsp.com>
From: "James Stevenson" <james@stev.org>
To: "Andrey Borzenkov" <arvidjaar@mail.ru>, "Brian King" <brking@charter.net>
Cc: <linux-kernel@vger.kernel.org>
References: <E18bxDI-000Ic3-00@f15.mail.ru>
Subject: Re: Re[2]: OOPS in idescsi_end_request
Date: Fri, 24 Jan 2003 09:06:44 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[LARGE SNIP]

> Would you agree to test the patch (possibly next week).

yeah sure.


> cheers
>
> -andrey
>
> > >
> > > If you can reliably reproduce the problem you could give it a try.
> > >
> > > Anybody sees yet another race condition here? :))
> > >
> > > -andrey
> > >
> > >
> > >>While burning a CD tonight I ended up taking an oops on my system. I
had
> > >>the lkcd patch applied to my 2.4.19 kernel, so I was able to look at
the
> > >>  oops after my system rebooted. After digging into it a little and
> > >>looking at the ide-scsi code I think I found the problem but am not
> > >>sure. How can idescsi_reset simply return SCSI_RESET_SUCCESS to the
scsi
> > >>mid layer? I think what is happening is that a command times out,
> > >>idescsi_abort is called, which returns SCSI_ABORT_SNOOZE. Later on
> > >>idescsi_reset gets called, which returns SCSI_RESET_SUCCESS. At this
> > >>point the scsi mid-layer owns the scsi_cmnd and returns the failure
back
> > >>up the chain. Later on, the command gets run through
> > >>idescsi_end_request, which then tries to access the scsi_cmnd
structure
> > >>which is it no longer owns.
> > >>
> > >>Any help is appreciated. I have a complete lkcd dump of the failure if
> > >>anyone would like more information...
> > >>


