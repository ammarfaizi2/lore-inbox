Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319055AbSIJGoM>; Tue, 10 Sep 2002 02:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319056AbSIJGoM>; Tue, 10 Sep 2002 02:44:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:10933 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319055AbSIJGoL>;
	Tue, 10 Sep 2002 02:44:11 -0400
Date: Tue, 10 Sep 2002 08:48:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USER_HZ & NTP problems
Message-ID: <20020910084853.A6792@ucw.cz>
References: <200209092314.g89NEnA05992@fokkensr.vertis.nl> <20020910080941.A6298@ucw.cz> <200209100637.g8A6bMm01628@fokkensr.vertis.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209100637.g8A6bMm01628@fokkensr.vertis.nl>; from fokkensr@fokkensr.vertis.nl on Tue, Sep 10, 2002 at 08:37:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 08:37:17AM +0200, Rolf Fokkens wrote:
> On Tuesday 10 September 2002 08:09, Vojtech Pavlik wrote:
> > Actually, the clock true frequency is 1193181.8 Hz, although most
> > manuals say 1.19318 MHz, which, because truncating more digits, also
> > correct. But 1193180 Hz isn't. If you're trying to count the time
> > correctly, you should better use 1193182 Hz if staying in integers.
> 
> I copied the clock frequency from the kernel source, timex.h defines:
> 
> #define CLOCK_TICK_RATE 1193180
> 
> If what you're saying is correct, timex.h uses the wrong value as wel I guess.

Yes, it uses the wrong value.

It's not too big a difference to notice, the error in the frequency from
the ideal value in most cheap mainboard crystals is greater than 2 Hz.
So it's lost in the noise.

The clock is generated from a base crystal of 14.3181818 by division by 12.
The base crystal is the frequency found on ISA for the MDA/CGA adapters,
and is a NTSC dot-clock. All other frequencies on a motherboard (except
the RTC, which has a separate 32.000 kHz clock) are derived from it.

It's just if you try to get the computations correct, you may also want
to have this value correct. :)

-- 
Vojtech Pavlik
SuSE Labs
