Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUHBLrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUHBLrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 07:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUHBLrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 07:47:00 -0400
Received: from li2-47.members.linode.com ([69.56.173.47]:60686 "EHLO
	li2-47.members.linode.com") by vger.kernel.org with ESMTP
	id S266479AbUHBLq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 07:46:58 -0400
Date: Mon, 2 Aug 2004 06:46:56 -0500
From: Randall Nortman <linuxkernellist@wonderclown.com>
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
Subject: Re: MSI K8N Neo + powernow-k8: ACPI info is worse than BIOS PST
Message-ID: <20040802114655.GD18254@li2-47.members.linode.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
References: <20040731140008.GJ4108@li2-47.members.linode.com> <20040802100658.GC10412@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802100658.GC10412@atomide.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:07:01AM -0700, Tony Lindgren wrote:
> * Randall Nortman <linuxkernellist@wonderclown.com> [040731 07:01]:
> > 
> > If anybody qualified to hack this code is interested in creating a
> > real workaround for BIOSes like this, I offer my system (and my time,
> > as I cannot give remote access) for testing.  I would suggest adding a
> > compile-time or load-time option to prefer the BIOS over ACPI (as in
> > powernow-k7, I think), and maybe a compile-time option to use Tony's
> > hardcoded tables.
> 
> Just to clarify a bit, my patch only uses the 800MHz hardcoded, which
> should work on all AMD64 processors. The max value used is the current
> running value.


Actually, thanks to an off-list response from Anton Ertl (anton at
mips dot complang dot tuwien dot ac dot at), I have made an important
discovery that's relevant to my situation and your patch: newer amd64
cores (Newcastle cores) cannot clock down to 800MHz!  I apparently am
lucky enough to have gotten the CG stepping of my CPU, which supports
1000, 1800, and 2000MHz modes, exactly as reported by the BIOS.  I
have therefore backed out your patch, and the result is that my system
is actually snappier.  (I suspect that really weird things were
happening when cpufreq tried to clock down to 800MHz; I was getting
high CPU load, periodic temporary freezes, and audio glitches, all of
which went away when I set the minimum clock to 1000MHz.  I hope I
didn't do any permanent damage.)  These new cores actually consume
less power at 1000MHz than the old ones did at 800MHz, so it's a
win-win for the lucky ones like me.

Now that I see that my BIOS table was correct after all, I'm left
wondering why MSI would have gotten that right but the ACPI wrong,
since Windows uses the ACPI information afaik.  And that leads me to
suspect that perhaps the bug is in the powernow-k8 ACPI code rather
than my firmware.  Any thoughts?

Randall Nortman
