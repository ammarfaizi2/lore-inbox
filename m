Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUAPFpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUAPFpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:45:38 -0500
Received: from holomorphy.com ([199.26.172.102]:41126 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265274AbUAPFpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:45:36 -0500
Date: Thu, 15 Jan 2004 21:45:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: James Cleverdon <jamesclv@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Message-ID: <20040116054521.GH1332@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	James Cleverdon <jamesclv@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Chris McDermott <lcm@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <7F740D512C7C1046AB53446D3720017361883D@scsmsx402.sc.intel.com> <Pine.LNX.4.58.0401141815090.15331@montezuma.fsmlabs.com> <200401151357.16807.jamesclv@us.ibm.com> <Pine.LNX.4.58.0401151719460.4208@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401151719460.4208@montezuma.fsmlabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004, James Cleverdon wrote:
>> No, I haven't exceeded the available vectors, but wli has on a large
>> NUMA-Q box.

On Thu, Jan 15, 2004 at 05:40:54PM -0500, Zwane Mwaikambo wrote:
> Yes i believe the 8 node NUMA-Qs do this easily.

The mainline kernel panics before console_init() on the 9th IO-APIC
(the first IO-APIC on the 5th node) and this has been an extreme
annoyance essentially since Linux was ported to the beasts.

It won't be long before currently shipping ia32 boxen catch up with
that blast from the 4+ -year-old past, and x86-64 or whatever will have
similar issues if/when it ever gets chipsets allowing similar numbers
of cpus and devices (presumably they're correlated) to be attached,
since AFAIK it didn't change the number of IDT entries.

One thing that's particularly asinine is that since the things use
physical destinations in the RTE's and use a serial APIC bus or
whatever per node (i.e. can only interrupt cpus in their node), they
really are just a tabulation method away from functioning properly.

-- wli
