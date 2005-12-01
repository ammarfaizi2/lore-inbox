Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVLAT2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVLAT2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVLAT2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:28:37 -0500
Received: from fsmlabs.com ([168.103.115.128]:48526 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932413AbVLAT2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:28:36 -0500
X-ASG-Debug-ID: 1133465313-599-19-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 1 Dec 2005 11:34:13 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Raj, Ashok" <ashok.raj@intel.com>
X-ASG-Orig-Subj: Re: x86_64/HOTPLUG_CPU: NULL dereference doesn't #PF with init_level4_pgt
Subject: Re: x86_64/HOTPLUG_CPU: NULL dereference doesn't #PF with init_level4_pgt
In-Reply-To: <20051201131857.GG19515@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0512010924490.13220@montezuma.fsmlabs.com>
References: <Pine.LNX.4.64.0511301859070.13220@montezuma.fsmlabs.com>
 <20051201131857.GG19515@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5764
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Andi Kleen wrote:

> On Wed, Nov 30, 2005 at 08:03:33PM -0800, Zwane Mwaikambo wrote:
> > NULL dereferences don't cause a page fault if the 4th level pagetable 
> > being used is init_level4_pgt because we never zap_low_mappings. Since 
> > the idle thread uses init_level4_pgt any bad dereferences happening there 
> > (e.g. from interrupts) won't cause a fault. Andi would you be fine with 
> > switching the idle threads to a different level4?
> 
> That recently changed. Are you sure it's still the case?
> 
> idle threads should always run with lazy TLB, no different mms.
> That's important for performance.
> 
> If a NULL reference causes a oops or not depends on if user space
> from the last process mapped a page to NULL or not.

Ah thanks Andi, yes NULL reference causes an oops in the current -git 
repository, i hadn't seen that change so i had last tested it on 2.6.13. 
Sorry for the noise.

	Zwane
