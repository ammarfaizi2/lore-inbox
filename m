Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbUALULZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266206AbUALULZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:11:25 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:61229 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S266099AbUALULN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:11:13 -0500
Subject: Re: Laptops & CPU frequency
From: Disconnect <lkml@sigkill.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073937159.28098.46.camel@cog.beaverton.ibm.com>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>  <1073816858.6189.186.camel@nomade>
	 <1073817226.6189.189.camel@nomade>
	 <1073937159.28098.46.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1073938271.2156.10.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 15:11:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 14:52, john stultz wrote:
> More info please. What type of hardware is this?  Could you send me your
> dmesg for booting both with and without AC power? 

I had a similar problem with 2.4 (with and without acpi, speedstep, etc)
on an Inspiron 8500.  Unfortunately, Dell only gives "use speedstep"
(boot in powersave on battery, performance on ac)  and "always in lowest
performance mode" options in the bios.  (Dell, you listening? How about
"don't use speedstep, only use [powersave/performance] mode"? Or "Boot
in last-used mode"..)

When the machine is suspended (swsusp) while on AC, it must be resumed
on AC (and same if suspended on battery) or the kernel gets very
confused.  Time doubles (or halves), etc.  No amount of arguing with
speedstep (or acpi in general, if speedstep wasn't applied/used) will
get it sane.  (FWIW XP gets this right - hibernate XP on battery, resume
on ac, hibernate, resume on battery, etc and it does fine.)

Perhaps linux would benefit from some form of "make sure the cpu is
doing what we think it is" knob?  Something that could be triggered by
scripts (or even swsusp/apm directly) as early in a resume as possible,
before the miscalculation cascades into crashes.  (This would be
completely independent from speedstep or acpi, since I suspect that the
same problems may occur independently of acpi on other machines with
similar braindamaged bios.)

Thoughts?  I can do more rigorous testing and report back if needed.  (I
spent 2 days playing with it a few months ago, then gave it up as
hopeless.)

-- 
Disconnect <lkml@sigkill.net>

