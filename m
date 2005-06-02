Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVFBXZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVFBXZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVFBXZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:25:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:49607 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261434AbVFBXVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:21:00 -0400
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
From: john stultz <johnstul@us.ibm.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <200506021905.08274.kernel-stuff@comcast.net>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
	 <20050602183904.GC2636@us.ibm.com>
	 <200506021905.08274.kernel-stuff@comcast.net>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 16:20:53 -0700
Message-Id: <1117754453.17804.51.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 19:05 -0400, Parag Warudkar wrote:
> On Thursday 02 June 2005 14:39, Nishanth Aravamudan wrote:
> > Which timesource is being used?
> >
> > cat /sys/devices/system/timesource/timesource0/timesource
> 
> tux-gentoo parag # cat /sys/devices/system/timesource/timesource0/timesource
> jiffies tsc tsc-interp *acpi_pm

You can change the timesource at runtime by doing something like:

echo "tsc" > /sys/devices/system/timesource/timesource0/timesource

The "*" denotes the current timesource, so you'll see it move the next
time you cat the timesource sysfs file.

Could you see if the slowness you're feeling is correlated to the
acpi_pm timesource? It is quite a bit slower to access then the TSC, but
I'd be surprised if you can actually feel the difference.

This is on an x86-64 system, correct?

thanks
-john



