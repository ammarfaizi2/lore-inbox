Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVLAD6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVLAD6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 22:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVLAD6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 22:58:00 -0500
Received: from fsmlabs.com ([168.103.115.128]:21635 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751412AbVLAD6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 22:58:00 -0500
X-ASG-Debug-ID: 1133409476-15925-56-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 30 Nov 2005 20:03:33 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Raj, Ashok" <ashok.raj@intel.com>
X-ASG-Orig-Subj: x86_64/HOTPLUG_CPU: NULL dereference doesn't #PF with init_level4_pgt
Subject: x86_64/HOTPLUG_CPU: NULL dereference doesn't #PF with init_level4_pgt
Message-ID: <Pine.LNX.4.64.0511301859070.13220@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5747
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NULL dereferences don't cause a page fault if the 4th level pagetable 
being used is init_level4_pgt because we never zap_low_mappings. Since 
the idle thread uses init_level4_pgt any bad dereferences happening there 
(e.g. from interrupts) won't cause a fault. Andi would you be fine with 
switching the idle threads to a different level4?

Thanks,
	Zwane

