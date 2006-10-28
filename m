Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWJ1Tx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWJ1Tx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWJ1Tx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:53:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751367AbWJ1Tx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:53:58 -0400
Date: Sat, 28 Oct 2006 15:53:49 -0400
From: Dave Jones <davej@redhat.com>
To: Ben Collins <bcollins@ubuntu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Pallipadi@pressure.kernelslacker.org,
       Venkatesh <venkatesh.pallipadi@intel.com>
Subject: p4-clockmod N60 errata workaround.
Message-ID: <20061028195349.GH27101@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben Collins <bcollins@ubuntu.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, Pallipadi,
	Venkatesh <venkatesh.pallipadi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,
 For the best part of a year since that N60 errata workaround
went in, I've had floods of complaints from users of that driver
about this driver becoming even more useless than it was before
"I had 8 frequencies, now I have 2" being the common complaint.
which was to be expected given that the intention of the errata
workaround was to cripple frequencies <2GHz.

The point worth noting however, is that none of these users ever
noticed any problems when we didn't have the workaround in place,
so they were somewhat miffed when it stopped working.

The actual errata states..

"If a system de-asserts STPCLK# at a 12.5% duty cycle, the processor
 is running below 2 GHz, and the processor thermal control circuit (TCC)
 on-demand clock modulation is active, the processor may hang.
 This erratum does not occur under the automatic mode of the TCC."

I believe the reason we never saw any problems is that we _are_ using
the TCC by default.  See the code in arch/i386/kernel/cpu/mcheck/p4.c
intel_init_thermal() and friends.

So my current feeling is that we're working around an errata that
can never happen, and crippling functionality in the process for
no good reason.  I'm leaning towards just removing this workaround.

	Dave

-- 
http://www.codemonkey.org.uk
