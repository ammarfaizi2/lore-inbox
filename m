Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUHBMnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUHBMnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUHBMnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:43:22 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:45840
	"EHLO muru.com") by vger.kernel.org with ESMTP id S264153AbUHBMnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:43:20 -0400
Date: Mon, 2 Aug 2004 05:43:18 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Subject: Re: MSI K8N Neo + powernow-k8: ACPI info is worse than BIOS PST
Message-ID: <20040802124318.GA30100@atomide.com>
References: <20040731140008.GJ4108@li2-47.members.linode.com> <20040802100658.GC10412@atomide.com> <20040802114655.GD18254@li2-47.members.linode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802114655.GD18254@li2-47.members.linode.com>
User-Agent: Mutt/1.3.28i
X-Mailer: Mutt http://www.mutt.org/
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Randall Nortman <linuxkernellist@wonderclown.com> [040802 04:47]:
> On Mon, Aug 02, 2004 at 03:07:01AM -0700, Tony Lindgren wrote:
> > * Randall Nortman <linuxkernellist@wonderclown.com> [040731 07:01]:
> > > 
> > > If anybody qualified to hack this code is interested in creating a
> > > real workaround for BIOSes like this, I offer my system (and my time,
> > > as I cannot give remote access) for testing.  I would suggest adding a
> > > compile-time or load-time option to prefer the BIOS over ACPI (as in
> > > powernow-k7, I think), and maybe a compile-time option to use Tony's
> > > hardcoded tables.
> > 
> > Just to clarify a bit, my patch only uses the 800MHz hardcoded, which
> > should work on all AMD64 processors. The max value used is the current
> > running value.
> 
> 
> Actually, thanks to an off-list response from Anton Ertl (anton at
> mips dot complang dot tuwien dot ac dot at), I have made an important
> discovery that's relevant to my situation and your patch: newer amd64
> cores (Newcastle cores) cannot clock down to 800MHz!  I apparently am
> lucky enough to have gotten the CG stepping of my CPU, which supports
> 1000, 1800, and 2000MHz modes, exactly as reported by the BIOS.  I
> have therefore backed out your patch, and the result is that my system
> is actually snappier.  (I suspect that really weird things were
> happening when cpufreq tried to clock down to 800MHz; I was getting
> high CPU load, periodic temporary freezes, and audio glitches, all of
> which went away when I set the minimum clock to 1000MHz.  I hope I
> didn't do any permanent damage.)  These new cores actually consume
> less power at 1000MHz than the old ones did at 800MHz, so it's a
> win-win for the lucky ones like me.

OK, then my patch does not work any more unless there's some way to
detect what's the correct minimum speed. Since my system works with
just the ACPI tables, it's unlikely that I'll spend more time on 
this :)

> Now that I see that my BIOS table was correct after all, I'm left
> wondering why MSI would have gotten that right but the ACPI wrong,
> since Windows uses the ACPI information afaik.  And that leads me to
> suspect that perhaps the bug is in the powernow-k8 ACPI code rather
> than my firmware.  Any thoughts?

No idea...

Tony
