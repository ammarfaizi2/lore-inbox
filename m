Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUCXV1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUCXV1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:27:51 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:33684 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S261942AbUCXV1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:27:48 -0500
Date: Wed, 24 Mar 2004 13:25:54 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       mikpe@csd.uu.se
Subject: Re: apic errors and looping with 2.4, none with 2.2 (supermicro/serverworks
 LE chipset)
In-Reply-To: <20040324212759.GD6572@logos.cnet>
Message-ID: <Pine.LNX.4.58.0403241255480.6032@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0403230420000.25095@potato.cts.ucla.edu>
 <Pine.LNX.4.58.0403240011150.21019@potato.cts.ucla.edu> <20040324212759.GD6572@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also tested with 2.6.5-rc2 with no kernel command line parameters and
locked up the machine hard (no serial console) after about 2 minutes of
APIC errors.  I'll check the BIOS in a few hours after I go reboot the
machine.


-Chris

On Wed, 24 Mar 2004, Marcelo Tosatti wrote:

>
> Chris,
>
> The least I know is that similar IOAPIC errors have been seen due to
> BIOS/hardware misconfigurations.
>
> Maybe Maciej or Mikael have more clue of what might be happening.
>
> On Wed, Mar 24, 2004 at 02:50:32AM -0800, Chris Stromsoe wrote:
> > I've rebooted with noapic and nolapic and the machine seemed to be stable
> > for a while.  Then I got:
> >
> > Mar 24 00:27:08 dahlia kernel: APIC error on CPU1: 00(02)
> > Mar 24 00:27:08 dahlia kernel: APIC error on CPU0: 00(02)
> > Mar 24 00:27:08 dahlia kernel: spurious APIC interrupt on CPU#0, should never happen.
> > Mar 24 00:27:13 dahlia kernel: APIC error on CPU1: 02(08)
> > Mar 24 00:27:13 dahlia kernel: APIC error on CPU0: 02(08)
> > Mar 24 00:28:07 dahlia kernel: APIC error on CPU1: 08(02)
> > Mar 24 00:28:07 dahlia kernel: APIC error on CPU0: 08(02)
> > Mar 24 00:28:07 dahlia kernel: APIC error on CPU0: 02(08)
> > Mar 24 00:28:07 dahlia kernel: APIC error on CPU0: 08(02)
> > Mar 24 00:28:07 dahlia kernel: APIC error on CPU1: 02(0a)
> >
> > I added nosmp to the lilo append line and rebooted.
> >
> > noapic, nolapic, and nosmp seems to be stable.  I haven't had anything
> > logged in the last 2 hours.  Are there known APIC or SMP problems with
> > serverworks LE chipsets or supermicro motherboards and 2.4?  What are the
> > steps to troubleshooting an APIC problem?
> >
> >
> > -Chris
> >
> > On Tue, 23 Mar 2004, Chris Stromsoe wrote:
> >
> > > I have one machine that won't run 2.4.  As soon as a 2.4 kernel boots, it
> > > starts throwing APIC errors.
> > >
> > > The machine is a dual CPU pIII 933MHz system with 512Mb ram on a
> > > SuperMicro motherboard, either a P3TDLR or a 370DLR, with the ServerWorks
> > > LE chipset.  I'm booting using lilo with append="noapic".
> > >
> > > As soon as I boot into a 2.4 kernel, I start getting APIC errors on both
> > > CPUs.  Varying combinations of:
> > >
> > > Mar 23 00:40:45 dahlia kernel: APIC error on CPU0: 02(08)
> > > Mar 23 00:40:45 dahlia kernel: APIC error on CPU1: 01(08)
> > > Mar 23 00:45:45 dahlia kernel: APIC error on CPU1: 08(08)
> > > Mar 23 00:45:45 dahlia kernel: APIC error on CPU0: 08(08)
> > > Mar 23 00:58:27 dahlia kernel: APIC error on CPU0: 08(01)
> > > Mar 23 00:58:27 dahlia kernel: APIC error on CPU1: 08(02)
> > > Mar 23 01:04:54 dahlia kernel: APIC error on CPU1: 02(02)
> > > Mar 23 01:04:54 dahlia kernel: APIC error on CPU0: 01(02)
> > > Mar 23 01:05:46 dahlia kernel: APIC error on CPU1: 02(08)
> > > Mar 23 01:05:46 dahlia kernel: APIC error on CPU0: 02(08)
> > > Mar 23 01:08:37 dahlia kernel: APIC error on CPU1: 08(02)
> > > Mar 23 01:08:37 dahlia kernel: APIC error on CPU0: 08(02)
> > > Mar 23 01:11:04 dahlia kernel: APIC error on CPU1: 02(02)
> > > Mar 23 01:11:04 dahlia kernel: APIC error on CPU0: 02(0a)
> > > Mar 23 01:11:04 dahlia kernel: APIC error on CPU1: 02(08)
> > > Mar 23 01:25:45 dahlia kernel: APIC error on CPU1: 08(08)
> > > Mar 23 01:25:45 dahlia kernel: APIC error on CPU0: 0a(08)
> > >
> > > After a few hours of uptime, the box stops responding to keyboard input.
> > > It begins printing the above messages to console over and over.  I have
> > > several other identical machines that I received in the same batch that
> > > run 2.4 without any problems (though they do seem to require "noapic").
> > >
> > > It runs fine with 2.2 and is running 2.2.26 right now.
> > >
> > > The machine is not in production use and can be used to test.  Any ideas
> > > for what I should look at?
>
