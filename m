Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTLLQtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTLLQtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:49:31 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:48863 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261309AbTLLQt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:49:29 -0500
Date: Fri, 12 Dec 2003 09:59:29 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031212165929.GA187@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com> <200312111912.27811.ross@datscreative.com.au> <1071165161.2271.22.camel@big.pomac.com> <20031211182108.GA353@tesore.local> <3FD98A1F.901@nishanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD98A1F.901@nishanet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 04:27:59AM -0500, Bob wrote:
> Jesse Allen wrote:
> 
> >On Thu, Dec 11, 2003 at 06:52:41PM +0100, Ian Kumlien wrote:
> > 
> >
> >>Heh, yeah, the need for disconnect is somewhat dodgy, i haven't read up
> >>on th rest.
> >>
> >Hmm, weird.  I went to go look at the Shuttle motherboard maker's site - 
> >maybe so that I can bug them for a bios disconnect option - but I checked 
> >for a bios update first.  And sure enough like they read my mind, just 
> >posted online today, an update.  Here are the details of fixes:
> >
> >" Checksum:   8B00H                         Date Code: 12/05/03
> >1.Support 0.18 micron AMD Duron (Palomino) CPU.
> >2.Add C1 disconnect item."
> >
> >It's almost as they're reading this list.  This disconnect problem was 
> >discovered on the 5th (well the 5th in my timezone).  Perhaps they're 
> >aware of this issue...  I'm gonna talk to them.
> >
> >Jesse
> >
> A bios update for MSI K7N2 MCP2-T nforce2 board
> fixed the crashing BEFORE these patches were developed,
> but there was no documentation that would relate or explain.

Last night, I updated the bios to the 12-5-03 released yesterday (see above).  I looked at the new option under Advanced Chipset Features, "C1 Disconnect".  It has three selections: Auto, Enabled, Disabled.  There seems to be no default.  The item help says:
"Force En/Disabled 
 or Auto mode:
 C17 IGP/SPP NB A03
 C18D SPP NM A01 (C01)
 enabled C1 disconnect
 otherwise disabled it"

Auto sounded nice, so I selected that first.  I compiled a new kernel without the disconnect off patch, or the ack delay.  These are the exact patches I used on 2.6.0-test11:
patch-2.6.0-test11-bk8.bz2
acpi-2.6.0t11.patch acpi bugfixes from Maciej.
nforce-ioapic-timer-2.6t11.patch from Ross Dickson.  Timer patch.
forcedeth.patch Patch stolen from -test10-mm1?  Unused.
forcedeth-update-2.patch Same.

Sure enough, under this kernel, no lockups.  Athcool reported Disconnect was "on".

I decided to wait till this morning, to try the BIOS "C1 Disconnect" set to enabled.  Still no lockups under this kernel.  Tried a vanilla kernel, no lockups (but timer and watchdog messed up still).  Now that I read your message Bob, I understand what you are saying.  Luckily, the updated BIOS changelog states "Add C1 disconnect item."  And this exact version seems to have fixed it, and now we have an exact fix (another one?) to refer to.

So the fix was absolutely a BIOS fix.  It seems a lot of people have buggy BIOSes on nforce2 boards.  Even some that have the option.  I guess I haven't proved that it was the BIOS fix, because I haven't stressed it for a long period of time.  But I don't believe I have to because I can do grep's and kernel compiles with disconnect on now, where before I couldn't (always been very easy to reproduce lockup).

> 
> http://www.msi.com.tw/program/support/bios/bos/spt_bos_detail.php?UID=436&kind=1
> http://download.msi.com.tw/support/bos_exe/6570v76.exe
> 
> Award 7.6 at the top of the list. Maybe somebody can figure
> out what they're doing.

I think I'll continue on contacting shuttle and ask them why they added the option, and how they added it.  Maybe that will give us the right information.

> 
> Nvidia X driver for ti4200 agp8 still locks up linux though,
> but X nv works fine. agp8 3d may expose the timer issue.
> 

That's either an nvidia driver problem, or agpgart-nforce problem.  I'd try 4x agp, and or NVAGP (or agpgart, if already using NVAGP).  If you think it's the timer, try the timer patch, or with nolapic noapic.

Jesse
