Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRDQAsv>; Mon, 16 Apr 2001 20:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRDQAsl>; Mon, 16 Apr 2001 20:48:41 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:16468 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132484AbRDQAsZ>; Mon, 16 Apr 2001 20:48:25 -0400
Message-ID: <3ADB9245.43054124@mvista.com>
Date: Mon, 16 Apr 2001 17:45:57 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Salisbury <gonar@mediaone.net>
CC: Mark Salisbury <mbs@mc.com>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Ben Greear <greearb@candelatech.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <3ADA60C6.1593A2BF@candelatech.com> <20010416044630.A18776@pcep-jamie.cern.ch> <0104160841431V.01893@pc-eng24.mc.com> <3ADB45C0.E3F32257@mvista.com> <001801c0c6d1$0528d340$6501a8c0@gonar.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Salisbury wrote:
> 
> > Given a system speed, there is a repeating timer rate which will consume
> > 100% of the system in handling the timer interrupts.  An attempt will
> > be made to detect this rate and adjust the timer to prevent system
> > lockup.  This adjustment will look like timer overruns to the user
> > (i.e. we will take a percent of the interrupts and record the untaken
> > interrupts as overruns)
> 
> just at first blush, there are some things in general but I need to read
> this again and more closely....
> 
> but, with POSIX timers, there is a nifty little restriction/protection built
> into the spec regarding the re-insertion of short interval repeating timers.
> that is: a repeating timer will not be re-inserted until AFTER the
> associated signal handler has been handled.

Actually what it says is: "Only a single signal shall be queued to the
process for a given timer at any point in time.  When a timer for which
a signal is still pending expires, no signal shall be queued, and a
timer overrun shall occur."

It then goes on to talk about the overrun count and how it is to be
managed.

What I am suggesting is that the system should detect when these
interrupts would come so fast as to stall the system and just set up a
percent of them while bumping the overrun count as if they had all
occured.

George

> 
> this has some interesting consequences for signal handling and signal
> delivery implementations, but importantly, it ensures that even a flood of
> POSIX timers with very short repeat intervals will be handled cleanly.
> 
> I will get more detailed comments to you tomorrow.
> 
> Mark Salisbury
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
