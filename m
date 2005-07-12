Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVGLQLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVGLQLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVGLQJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:09:22 -0400
Received: from styx.suse.cz ([82.119.242.94]:31659 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261487AbVGLQHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:07:19 -0400
Date: Tue, 12 Jul 2005 18:07:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       George Anzinger <george@mvista.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org, torvalds@osdl.org,
       christoph@lameter.org
Subject: Re: i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050712160717.GB8740@ucw.cz>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <42D310ED.2000407@mvista.com> <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org> <20050712133018.GA8467@ucw.cz> <Pine.LNX.4.61.0507121546160.8594@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507121546160.8594@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 04:05:16PM +0200, Jan Engelhardt wrote:

> >> >     HZ   ticks/jiffie  1 second      error (ppm)
> >> > ---------------------------------------------------
> >> >    100      11932      1.000015238      15.2
> 
> I was not quite able to reproduce these values, probably because I got the
> math wrong. I used:
>   $oneSecond = $ticksJiffie * $HZ / 1193182
> which yields 11932*100/1193182 = 1.00001508571198693912, !=1.000015238
> Math corrections welcome.

I used 1.19318[18] MHz periodic as the true clock speed - 1/3rd of the
NTSC color subcarrier frequency.

1193182 Hz is already a rounded value, and as such introduces some error
by the rounding.

It is possible the standard value is 1.1931816[6] MHz periodic, as
Richard B. Johnson corrected me, being 1/12th of 14.31818000 MHz, the
CGA dotclock. 

Anyway, both 14.31818 MHz and 14.3181818 MHz crystals are being
manufactured, and thus we'll see both these numbers in the wild.

> Anyway, I've done some graphs. Intersting that the smaller the HZ, the less
> error (seen on a whole, esp. view_1k and view_8k.png) we get. 20Hz seems to
> be the 0.0 case, and 18Hz is not bad either. IIRC, DOS used 18HZ ;)
> http://jengelh.hopto.org/tick/

DOS used 65535 as the divisor (ticks/jiffie), which doesn't give an
integer HZ.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
