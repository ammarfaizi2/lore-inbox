Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319209AbSHTRZb>; Tue, 20 Aug 2002 13:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319210AbSHTRZb>; Tue, 20 Aug 2002 13:25:31 -0400
Received: from krynn.axis.se ([193.13.178.10]:30621 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S319209AbSHTRZ3>;
	Tue, 20 Aug 2002 13:25:29 -0400
From: johan.adolfsson@axis.com
Message-ID: <050b01c2486f$c6701880$b9b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Oliver Xymoron" <oxymoron@waste.org>, <johan.adolfsson@axis.com>
Cc: <linux-kernel@vger.kernel.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org> <03f401c24867$2d5260c0$b9b270d5@homeip.net> <20020820170601.GD19225@waste.org>
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Date: Tue, 20 Aug 2002 19:34:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Put an inline function or macro in asm/timex.h (?) together with an
> > ARCH_HAS_RANDOM_TIMESTAMP define?
> 
> I don't think we want to make it specific to random. I think we just
> want to call it hires. 
> 
> > E.g. like this for i386:
> > #define ARCH_HAS_RANDOM_TIMESTAMP
> > #define RANDOM_TIMESTAMP(time, num) do{\
..  
> > And then in random.c:
> > ifdef ARCH_HAS_RANDOM_TIMESTAMP
> >   RANDOM_TIMESTAMP(time, num);
> > #else
> >   time = jiffies;
> > #endif
> 
> Again, too random-specific. And we need a way to get the timescale.
> Perhaps something like:
> 
> speed=get_timestamp_khz;
> lowbits=get_hires_timestamp();

But isn't the "num ^= high;" a way to improve the randomness
and the high value doesn't really need to be linear to the time?
Thus it would be random-specific and not just a timestamp.

/Johan


