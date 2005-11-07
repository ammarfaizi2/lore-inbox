Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVKGLl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVKGLl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVKGLl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:41:56 -0500
Received: from orb.pobox.com ([207.8.226.5]:33965 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S964785AbVKGLlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:41:55 -0500
Date: Mon, 7 Nov 2005 05:41:44 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, linux@brodo.de, davej@redhat.com, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 4/4] create and destroy cpufreq sysfs entries based on cpu notifiers.
Message-ID: <20051107114144.GH7806@otto>
References: <20051021203818.753754000@araj-sfield> <20051021204327.843400000@araj-sfield>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051021204327.843400000@araj-sfield>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

Ashok Raj wrote:
> cpufreq entries in sysfs should only be populated when CPU is online state.
> When we either boot with maxcpus=x and then boot the other cpus by 
> echoing to sysfs online file, these entries should be created and destroyed
> when CPU_DEAD is notified. Same treatement as cache entries under sysfs.
> 
> We place the processor in the lowest frequency, so hw managed P-State 
> transitions can still work on the other threads to save power.
> 
> Primary goal was to just make these directories appear/disapper dynamically.

I see this patch series has already been merged, but in light of the
issues that it has caused[1], and the hack that Andrew is carrying to
deal with them[2], could we revisit the original justification for
these changes?

Why is it important that cpufreq-related files in sysfs be added and
removed as cpus go online and offline?  I see that the information
that these entries provide can be derived only when the cpu is online,
is that the primary justification?

Would it be undesirable for the cpufreq drivers to create their
entries under all cpu sysdevs at init time, regardless of whether the
cpus are online?  The "show" methods for entries attached to offline
cpus could be made to return "Unavailable" or some equivalent.

I'm not terribly familiar with x86 or cpufreq, so forgive me if I'm
missing something obvious.


[1] http://lkml.org/lkml/2005/10/31/144
[2] ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/broken-out/cpu-hotplug-fix-locking-in-cpufreq-drivers.patch
