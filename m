Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVBGMim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVBGMim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVBGMim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:38:42 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:58499 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261410AbVBGMh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:37:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64 [update]
Date: Mon, 7 Feb 2005 13:38:49 +0100
User-Agent: KMail/1.7.1
Cc: linux-acpi@intel.com, Dominik Brodowski <linux@dominikbrodowski.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
References: <200502021428.12134.rjw@sisk.pl> <20050203142203.GB1402@elf.ucw.cz> <200502040015.22457.rjw@sisk.pl>
In-Reply-To: <200502040015.22457.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200502071338.49694.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 4 of February 2005 00:15, Rafael J. Wysocki wrote:
> On Thursday, 3 of February 2005 15:22, Pavel Machek wrote:
[-- snip --] 
> > > I'm currently thinking that the proper approach may be to add a ->suspend()
> > > routine to struct cpufreq_driver and call the driver-specific ->suspend()
> > > (if one is defined) from cpufreq_suspend().  Then, it'll be possible to do
> > > whatever-is-necessary on a per-driver basis.  Just a thought. :-)
> > 
> > Yes, that seems like right solution.
> 
> Then I'll try to do something along this line.

Previously I had made a mistake and compiled the cpufreq drivers as modules
instead of compiling them directly into the kernel.  When I compiled cpufreq
in directly, it turned out that any such patches were not necessary, as the
warning about the differences in the CPU frequency went away.  Nonetheless,
I used such a patch in testing the resume/suspend behaviour when
resuming on either AC or battery power (this patch is available at:
http://www.sisk.pl/kernel/patches/2.6.11-rc3-mm1/cpufreq-k8-suspend.patch).

The results of the testing are as follows:
1) When the cpufreq drivers are compiled directly into the kernel:
	a) the box resumes successfully if:
		i) it is on AC power during resume, or
		ii) it is started on AC power (ie bootloader starts on AC
		power) and disconnected from the AC before the kernel
		is loaded (!?)
	b) the box hangs solid as soon as the image is restored if it is
	started and the kernel is booted on battery power.
2) When the cpufreq drivers are not compiled into the kernel, the box reboots
on resume as soon as the image is restored.

The above results do not depend on whether the patch that forces the minimal
frequency of the CPU before suspend is used.

The results 1)a)ii) and 2) indicate that cpufreq is not to blame in this case,
so sorry for the noise here.

I think it is a BIOS-related issue and it seems to me that it's also related
to ACPI.  As the results 1)a)i) and 1)a)ii) are reproducible with probability
1, I'm going to investigate it a bit further, so if anyone on linux-acpi could
give me a hint on what to do next, I'd be grateful.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
