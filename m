Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUG1AKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUG1AKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 20:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266738AbUG1AKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 20:10:30 -0400
Received: from nevyn.them.org ([66.93.172.17]:28592 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266737AbUG1AK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 20:10:28 -0400
Date: Tue, 27 Jul 2004 20:09:14 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Intermittent panic at boot on x86-64
Message-ID: <20040728000914.GA1432@nevyn.them.org>
Mail-Followup-To: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20040717230924.GA7174@nevyn.them.org> <20040722211411.GA3575@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722211411.GA3575@nevyn.them.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 05:14:11PM -0400, Daniel Jacobowitz wrote:
> On Sat, Jul 17, 2004 at 07:09:24PM -0400, Daniel Jacobowitz wrote:
> > I'm trying to set up a dual Opteron 244 system using Linux 2.4.7.  It
> > doesn't reliably boot in SMP, although I've never had a problem in UP. It's
> > possible that it's a hardware problem - the machine is new - but I don't
> > think so.
> > 
> > I get a lot of different results when I boot an SMP kernel: an NMI watchdog
> > reported lockup in smp_boot_cpus [first log below], a single processor boot
> > [second log below], an NMI watchdog lockup in ret_from_intr, also during
> > smp_boot_cpus [third log below], an OK boot (maybe 33% of the time, fourth
> > log below), or an error complaining that the IO-APIC and timer don't work
> > and I should go bug Ingo (couldn't reproduce this now but it's from
> > check_timer in io_apic.c).
> > 
> > If it does boot both processors, it seems to run OK.
> 
> Really confused now... I just had a successful boot with somehow messed
> up timers.  Take a look at the BogoMIPS here:

For the record... with a huge amount of assistance from Andi, and a lot
of trial and error, I tracked down the problem.  This is a symptom of
having USB Legacy Support turned on in the BIOS of a K8T Master2-FAR
(BIOS rev 1.2).

I turned it on because, without it, I couldn't talk to grub from my USB
keyboard.  If I hit a key on the keyboard at the grub prompt, before
Linux got going, then all was well.  If I let it try to autoboot,
however, the timer is scrogged.  Andi's guess was that the SMM (System
Management Mode) code in the BIOS is doing something nasty.

Without it I can't kick grub by hand, but I can autoboot.  I should
just go find another PS2 keyboard.

-- 
Daniel Jacobowitz
