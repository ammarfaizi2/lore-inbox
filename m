Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132298AbRC1U5E>; Wed, 28 Mar 2001 15:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132390AbRC1U4i>; Wed, 28 Mar 2001 15:56:38 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:3588 "EHLO bug.ucw.cz") by vger.kernel.org with ESMTP id <S132444AbRC1Uy6>; Wed, 28 Mar 2001 15:54:58 -0500
Date: Mon, 26 Mar 2001 00:00:49 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Woller, Thomas'" <twoller@crystal.cirrus.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
Message-ID: <20010326000048.A50@(none)>
References: <4148FEAAD879D311AC5700A0C969E8905DE7A2@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE7A2@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Thu, Mar 22, 2001 at 02:53:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > During resume the IBM thinkpad with the cs46xx driver needs 
> > to delay 700
> > milleseconds, so if the machine is booted up on battery power, then to
> > ensure that the delay is long enough, then a value of 3000 
> > milleseconds is
> > must be programmed into the driver (3 seconds!).  all the 
> > mdelay and udelay
> > wait times are incorrect by the same factor, resulting in some serious
> > problems when attempting to wait specific delay times in 
> > other parts of the
> > driver.  
> 
> Well yes this is a problem, but only when starting out with a low effective
> CPU freq and going high - the reverse is usually OK because longer than
> anticipated waits are OK.
> 
> However, you can alleviate this problem by not using udelay (or mdelay) but
> using a kernel timer. I would think you should be doing this anyway (700ms
> is a LONG TIME) but this should also work regardless of effective CPU freq.

Going from 59usec to 19usec is probably as fatal as going from 10sec to 3sec.

> A grep of the kernel source shows cs46xx isn't even doing the biggest
> mdelay. I can understand the use of spinning on a calibrated loop for less
> than a clock tick, but I gotta think there are better ways for longer
> periods.
> 
> I wonder if there is a way to modify mdelay to use a kernel timer if
> interval > 10msec? I am not familiar with this section of the kernel, but I
> do know that Microsoft's similar function KeStallExecutionProcessor is not
> recommended for more than 50 *micro*seconds.

You can't use kernel timer from within interrupts.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

