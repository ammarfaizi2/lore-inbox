Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313985AbSDQAfN>; Tue, 16 Apr 2002 20:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313986AbSDQAfM>; Tue, 16 Apr 2002 20:35:12 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:35806 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S313985AbSDQAfL>; Tue, 16 Apr 2002 20:35:11 -0400
Message-ID: <053d01c1e5a7$b4121e70$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: "Andreas Dilger" <adilger@clusterfs.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020416222156.GB20464@turbolinux.com> <E16xba3-0005tw-00@gondolin.me.apana.org.au> <20020416225631.GD20464@turbolinux.com>
Subject: Re: Why HZ on i386 is 100 ?
Date: Tue, 16 Apr 2002 17:34:58 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andreas Dilger" <adilger@clusterfs.com>

> On Apr 17, 2002  08:37 +1000, Herbert Xu wrote:
> > Why are we still measuring uptime using the tick variable? Ticks != time.
> > Surely we should be recording the boot time somewhere (probably on a
> > file system), and then comparing that with the current time?
> 
> Er, because the 'tick' is a valid count of the actual time that the
> system has been running, while the "boot time" is totally meaningless.
> What if the system has no RTC, or the RTC is wrong until later in the
> boot sequence when it can be set by the user/ntpd?  What if you pass
> daylight savings time?  Does your uptime increase/decrease by an hour?

Well, Andreas, it seems like a very simple thing to define the time
quantum, "tick", differently from the resolution of the count reported
by a call to get the tick counter value. If the latter maintains a
constant resolution even if the tick time changes then all utilities
should continue to work. Of course, with a tick time resolution of 10mS
it gets ugly when setting up a tick time of 1mS. Ideally reporting would
have an LSB of a microsecond or even a tenth microsecond while the
increment might still be a hundredth or thousandth of a second. Of course,
that blows anything that relies on the tick counter to smithereens, I fear.

{^_^}   Joanne "I STILL want a Linux suitable for multimedia applications" Dow.
        jdow@earthlink.net    (1mS ticks is a GREAT help for multimedia apps.)

