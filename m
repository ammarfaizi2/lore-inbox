Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131237AbRCWQrk>; Fri, 23 Mar 2001 11:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRCWQra>; Fri, 23 Mar 2001 11:47:30 -0500
Received: from mail-oak-2.pilot.net ([198.232.147.17]:48816 "EHLO
	mail02-oak.pilot.net") by vger.kernel.org with ESMTP
	id <S131237AbRCWQrU>; Fri, 23 Mar 2001 11:47:20 -0500
Message-ID: <973C11FE0E3ED41183B200508BC7774C0124F07E@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        "Woller, Thomas" <twoller@crystal.cirrus.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au, alan@lxorguk.ukuu.org.uk,
        "'Tim Wright'" <timw@splhi.com>
Subject: RE: Incorrect mdelay() results on Power Managed Machines x86
Date: Fri, 23 Mar 2001 10:43:02 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, results of additional testing are a little different than i anticipated.
here is some recent information using the IBM Thinkpad 600X. for testing
purposes I used an mdelay of 10000 (10 seconds) in the driver in the resume
code.  the results are the same with or without booting with the "notsc"
boot option. ("linux notsc" used as command line to disable tsc).  system
was suspended and then resumed, and the delay time noted. AC power was
removed/applied for both before APM action, as well as between suspend and
resume, no difference in the results below.

1) Boot on AC Power - BogoMips is ~992, cpu_khz is ~500
mdelay() functions as expected (10 sec delay) on AC power.  
remove AC and go to battery, mdelay() ALSO functions as expected (10 sec
delay).   this is good.
2) Boot on Battery - BogoMips is ~280, cpu_khz is ~132
Battery Power - mdelay() fails to delay properly (~2-3 second delay for
mdelay(10000))
apply AC Power - mdelay() fails to delay properly (~2-3 second delay for
mdelay(10000))

Note that apmd() detects a power status change. and indicates via message
that "Now using AC Power", or "Now using Battery Power".  so as Pavel
mentioned there is an APM event that occurs if a recal wants to happen.

for now, I'll just look at why the mdelay() actual wait time is never
correct, if booted up on Battery.  This fix might be all that is needed.
i'll also look into the archives and see if i can find Pavel's patch, but
until mdelay is working when booted up on battery the patch may not be
needed.


> -----Original Message-----
> From:	Pavel Machek [SMTP:pavel@suse.cz]
> Sent:	Thursday, March 22, 2001 5:29 PM
> To:	Woller, Thomas; 'linux-kernel@vger.kernel.org'
> Subject:	Re: Incorrect mdelay() results on Power Managed Machines x86
> 
> Hi!
> 
> > Problem: Certain Laptops (IBM Thinkpads is where i see the issue) reduce
> the
> > CPU frequency based upon whether the unit is on battery power or direct
> > power.  When the Linux kernel boots up, then the cpu_khz (time.c)
> 
> This is issue with my toshiba sattelite, too. I even had a patch to
> detect that speed changed and recalibrate (see archives), but
> recalibrate may come too late.
> 								Pavel
> -- 
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
