Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTLLVoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTLLVoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:44:09 -0500
Received: from legolas.restena.lu ([158.64.1.34]:3562 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S262196AbTLLVmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:42:35 -0500
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic,
	io-apic, udma133 covered
From: Craig Bradney <cbradney@zip.com.au>
To: Josh McKinney <forming@charter.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031212181827.GA3862@forming>
References: <200312072312.01013.ross@datscreative.com.au>
	 <200312111655.25456.ross@datscreative.com.au>
	 <1071143274.2272.4.camel@big.pomac.com>
	 <200312111912.27811.ross@datscreative.com.au>
	 <1071165161.2271.22.camel@big.pomac.com>
	 <20031211182108.GA353@tesore.local> <3FD98A1F.901@nishanet.com>
	 <20031212165929.GA187@tesore.local>  <20031212181827.GA3862@forming>
Content-Type: text/plain
Message-Id: <1071265352.4422.11.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Dec 2003 22:42:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-12 at 19:18, Josh McKinney wrote:
> On approximately Fri, Dec 12, 2003 at 09:59:29AM -0700, Jesse Allen wrote:
> > On Fri, Dec 12, 2003 at 04:27:59AM -0500, Bob wrote:
> > > Jesse Allen wrote:
> > > 
> > > >On Thu, Dec 11, 2003 at 06:52:41PM +0100, Ian Kumlien wrote:
> > > > 
> > > >
> > > >>Heh, yeah, the need for disconnect is somewhat dodgy, i haven't read up
> > > >>on th rest.
> > > >>
> > > >Hmm, weird.  I went to go look at the Shuttle motherboard maker's site - 
> > > >maybe so that I can bug them for a bios disconnect option - but I checked 
> > > >for a bios update first.  And sure enough like they read my mind, just 
> > > >posted online today, an update.  Here are the details of fixes:
> > > >
> > > >" Checksum:   8B00H                         Date Code: 12/05/03
> > > >1.Support 0.18 micron AMD Duron (Palomino) CPU.
> > > >2.Add C1 disconnect item."
> > > >
> > > >It's almost as they're reading this list.  This disconnect problem was 
> > > >discovered on the 5th (well the 5th in my timezone).  Perhaps they're 
> > > >aware of this issue...  I'm gonna talk to them.
> > > >
> > > >Jesse
> > > >
> > > A bios update for MSI K7N2 MCP2-T nforce2 board
> > > fixed the crashing BEFORE these patches were developed,
> > > but there was no documentation that would relate or explain.
> > 
> > Last night, I updated the bios to the 12-5-03 released yesterday (see above).  I looked at the new option under Advanced Chipset Features, "C1 Disconnect".  It has three selections: Auto, Enabled, Disabled.  There seems to be no default.  The item help says:
> > "Force En/Disabled 
> >  or Auto mode:
> >  C17 IGP/SPP NB A03
> >  C18D SPP NM A01 (C01)
> >  enabled C1 disconnect
> >  otherwise disabled it"
> > 
> > Auto sounded nice, so I selected that first.  I compiled a new kernel without the disconnect off patch, or the ack delay.  These are the exact patches I used on 2.6.0-test11:
> > patch-2.6.0-test11-bk8.bz2
> > acpi-2.6.0t11.patch acpi bugfixes from Maciej.
> > nforce-ioapic-timer-2.6t11.patch from Ross Dickson.  Timer patch.
> > forcedeth.patch Patch stolen from -test10-mm1?  Unused.
> > forcedeth-update-2.patch Same.
> > 
> > Sure enough, under this kernel, no lockups.  Athcool reported Disconnect was "on".
> > 
> <snip>
> > So the fix was absolutely a BIOS fix.  It seems a lot of people have buggy BIOSes on nforce2 boards.  Even some that have the option.  I guess I haven't proved that it was the BIOS fix, because I haven't stressed it for a long period of time.  But I don't believe I have to because I can do grep's and kernel compiles with disconnect on now, where before I couldn't (always been very easy to reproduce lockup).
> <snip>
> 
> The thing that strikes me funny is that you get no crashes with the
> updated BIOS and Disconnect on, but without the updated BIOS we have
> to turn disconnect off with athcool or the patch?  This makes me think
> that there is some voodoo going on in the BIOS update that they aren't
> saying, surprise surprise, or something is just slowing down the time
> it takes for it to crash.  I say this because I have gone 5+ days
> without any of the patches from these threads, acpi apic lapic
> enabled, and CPU disconnect on as stated by athcool.  This was with
> much stress testing, idle time, etc.  One day I just ran a grep that I
> have done probably 30 times and boom, hang.  
> 
> Good luck, hope the BIOS is the trick, now off to see how I can get
> ASUS to put the C1 Disconnect in the next revision.    


Yes, thats how it was for me.. I was the only one here saying "no
problems, la la la", then at about 5.25 days.. boom. Then the next day
it crashed twice. Hopefully you make some progress with ASUS.. (for the
A7N8X Deluxe as well as you mobo please :) ).

Ive been playing with hardware in the past few days (new quieter Zalman
PSU, and Zalman 7000 Cu fan etc) so no uptime to speak of here now. I
did compile KDE 3.2 beta 2 last night though.. 6 hours of solid
compilation.. no hassles. I have never turned off Disconnect either.

Thanks to all you guys who are working on this one. Seems to be getting
somewhere.

Craig

