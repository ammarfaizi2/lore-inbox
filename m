Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSLHWxd>; Sun, 8 Dec 2002 17:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSLHWxc>; Sun, 8 Dec 2002 17:53:32 -0500
Received: from bbned239-32-100.dsl.hccnet.nl ([80.100.32.239]:42245 "EHLO
	fw.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id <S261742AbSLHWxb>; Sun, 8 Dec 2002 17:53:31 -0500
Date: Sun, 8 Dec 2002 23:55:51 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Dazed and Confused
Message-ID: <20021208235551.B2150@vdpas.vanvergehaald.nl>
References: <Pine.LNX.4.42.0212060948250.7121-100000@egg> <1039348787.15058.6.camel@klendathu.telaviv.sgi.com> <1039360959.1153.10.camel@lapdog.badbelly.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039360959.1153.10.camel@lapdog.badbelly.com>; from gboyce@rakis.net on Sun, Dec 08, 2002 at 10:22:38AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 10:22:38AM -0500, Gregory Boyce wrote:
> On Sun, 2002-12-08 at 06:59, Gilad Ben-Yossef wrote:
> > On Fri, 2002-12-06 at 16:55, Greg Boyce wrote:
> > 
> > > I have an issue that I've been trying to track down for some time, and I
> > > was hoping that someone might be able to provide me with a definitive
> > > awnser.
> > > 
> > > I work in a company with a large number of Linux machine deployed all
> > > around the country, and in some of the machines we've been seeing the
> > > following error:
> > > 
> > > Uhhuh. NMI received. Dazed and confused, but trying to continue
> > > You probably have a hardware problem with your RAM chips
> > 
> > I have had the exact same error happen a while back on a 2.2.x kernel.
> > It did not seem to hurt anything but it made the QA dept. go bonkers so
> > I've spent some time chasing it down and found out what caused it back
> > then - perhaps the same, or similar, applies to your setup as well:
> > 
> > The machines in question were Intel ISP1100 1U servers and for various
> > non important reasons I have built the kernel which they were running
> > without APM support. Now these machines have 3 small non marked buttons
> > on their front - one is the power button, one is the reset button and
> > one was a suspend button. 
> > 
> > What I found out was that whenever anyone pressed the "suspend" button
> > (usually because they meant to press the power or reset buttons and
> > missed) the error in questions was logged. It seems that APM suspend is
> > implemented (at least on those machines) as an NMI, and if you compiled
> > the kernel sans APM support the NMI handling code simply did not grok
> > that specific NMI and thus reported said error, which was otherwise
> > harmless.
> 
> Most of these machines do have Intel motherboards.  I don't recall
> seeing suspend buttons, but I'll take a look.  Thanks!

Just another datapoint:

I administer a Digitial Prioris server (Pentium II, 512MB memory),
which logs one (yes, exactly one) "Uhhuh. NMI received. Etc.." message
at boot time. After booting it _never_ logs this message again.
The machine is rock stable; it currently has an uptime of 19 months
and is humming along nicely. It runs a pristine 2.2.19 kernel, with
the following patches applied:

	raw-2.2.18.FULL.diff
	linux-2.2.19-reiserfs-3.5.32-patch
	lvm_0.9.1_beta7

It looks like something is producing exactly one NMI during the boot
process. It doesn't seem to be a hardware problem.
Could it be something SMP-related? (the machine runs with one CPU, but
the motherboard can accomodate a second CPU and the BIOS supports that)
Or some power management thing, like was suggested previously in this thread?

Regards,
Toon.
-- 
 /"\                             | "I never much liked Macs.
 \ /     ASCII RIBBON CAMPAIGN   |  All the interesting stuff is hidden away."
  X        AGAINST HTML MAIL     |    --  Linus Torvalds (at the Geek Cruise)
 / \
