Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277353AbRKABjt>; Wed, 31 Oct 2001 20:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRKABjj>; Wed, 31 Oct 2001 20:39:39 -0500
Received: from firebird.planetinternet.be ([195.95.34.5]:28690 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S277353AbRKABjZ>; Wed, 31 Oct 2001 20:39:25 -0500
Date: Thu, 1 Nov 2001 02:26:08 +0100
From: Kurt Roeckx <Q@ping.be>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ian Maclaine-cross <iml@debian.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011101022608.A1468@ping.be>
In-Reply-To: <20011031125204.A1126@ping.be> <Pine.LNX.4.21.0111010045050.28028-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0111010045050.28028-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Thu, Nov 01, 2001 at 12:52:19AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 12:52:19AM +0000, Riley Williams wrote:
> 
> > Note that hwclock does not adjust the clock if the error is smaller
> > than 1 second, or it already wrote to the RTC is the past 23 hours.
> 
> I knew about the "not less than 1 second" restriction, but not the "only
> once a day" restriction. Can you confirm that the latter restriction is
> indeed the case please?

Oh, I made a little mistake.

It doesn't recalculate the factor if it did in the last 23 hours,
too make it more accurate.  The calculation isn't really
accurate, but gets more accurate the longer the period between
them.

In adjust_drift_factor():

  } else if ((hclocktime - adjtime_p->last_calib_time) < 23 * 60 * 60) {
    if (debug)
      printf(_("Not adjusting drift factor because it has been less than a "
             "day since the last calibration.\n"));

Kurt

