Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWJJS0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWJJS0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWJJS0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:26:42 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:6805 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965058AbWJJS0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:26:41 -0400
Subject: Re: Keyboard Stuttering
From: john stultz <johnstul@us.ibm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       David Gerber <dg-lkml@zapek.com>
In-Reply-To: <d120d5000610101009h49904afeq61b8e7f5dab79346@mail.gmail.com>
References: <200610061218.36883.dg-lkml@zapek.com>
	 <d120d5000610101009h49904afeq61b8e7f5dab79346@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 11:25:14 -0700
Message-Id: <1160504714.4973.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 13:09 -0400, Dmitry Torokhov wrote:
> On 10/6/06, David Gerber <dg-lkml@zapek.com> wrote:
> > > I'm experiencing some severe keyboard stuttering on my laptop.  The
> > > problem is particularly bad in X, and I believe it also occurs at the
> > > console, though I'm having a difficult time verifying that.  The problem
> > > shows up as repeated characters (not regular key-repeat-related), and
> > > sometimes dropped key presses.
> >
> > (I'm not subscribed to the list, CC: to me if needed)
> >
> > Same problem here. Intel Core 2 Duo with 2.6.19-rc1 x86_64 SMP. Happens on
> > 2.6.17 too. I use 'noapic' as a workaround but that disables one of the CPU
> > core of course.
> >
> > I cannot reproduce the problem within the console nor gdm. Only on the X
> > desktop.
> >
> 
> John,
> 
> It looks like the only clocksource available on David's box is
> "jiffies" although the processor shows that it supporst tsc and PM
> timer is enabled and I think that this is what causes keyboard
> stuttering in X. See http://bugzilla.kernel.org/show_bug.cgi?id=7291.
> I believe clocksources is your turf, could you please take a look at
> this.

Sure thing. I followed up in the bug, but I don't think the clocksource
code is involved. x86_64 hasn't converted to GENERIC_TIME, so jiffies is
what we use to increment xtime, but the TSC, ACPI PM, or HPET is used
for gettimeofday, etc. 

I suspect C3 idling is the culprit, since noapic works around the issue.

thanks
-john

