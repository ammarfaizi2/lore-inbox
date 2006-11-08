Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWKHBzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWKHBzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 20:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWKHBzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 20:55:50 -0500
Received: from mga05.intel.com ([192.55.52.89]:372 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751678AbWKHBzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 20:55:49 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,398,1157353200"; 
   d="scan'208"; a="159773206:sNHT3142403936"
Date: Tue, 7 Nov 2006 17:33:06 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: ak@suse.de, akpm@osdl.org
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com, suresh.b.siddha@intel.com
Subject: [patch 0/4] i386, x86_64: fix the irqbalance quirk for E7520/E7320/E7525
Message-ID: <20061107173306.C3262@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mechanism of selecting physical mode in genapic when cpu hotplug is enabled
on x86_64, broke the quirk(quirk_intel_irqbalance()) introduced for working
around the transposing interrupt message errata in E7520/E7320/E7525
(revision ID 0x9 and below. errata #23 in 
http://download.intel.com/design/chipsets/specupdt/30304203.pdf).

This errata requires the mode to be in logical flat, so that interrupts
can be directed to more than one cpu(and thus use hardware IRQ balancing
enabled by BIOS on these platforms).

Following four patches fixes this by moving the quirk to early quirk
and forcing the x86_64 genapic selection to logical flat on these platforms.

Thanks to Shaohua for pointing out the breakage.
