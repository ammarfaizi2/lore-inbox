Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752241AbWCEK12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbWCEK12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 05:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbWCEK12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 05:27:28 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49856
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751485AbWCEK11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 05:27:27 -0500
Date: Sun, 05 Mar 2006 02:27:35 -0800 (PST)
Message-Id: <20060305.022735.87818042.davem@davemloft.net>
To: akpm@osdl.org
Cc: christopher.leech@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060305004534.1d94b3cf.akpm@osdl.org>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<20060303214236.11908.98881.stgit@gitlost.site>
	<20060305004534.1d94b3cf.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 5 Mar 2006 00:45:34 -0800

> The __get_cpu_var() here will run smp_processor_id() from preemptible
> context.  You'll get a big warning if the correct debug options are set.
> 
> The reason for this is that preemption could cause this code to hop between
> CPUs.
> 
> Please always test code with all debug options enabled and with full kernel
> preemption.

To be fair that warning doesn't trigger on some platforms, such as
sparc64 where the __get_cpu_var() implementation simply takes the
value from a fixed cpu register and doesn't do the debugging check.

Sparc64 should add the check when debugging options are enabled, for
sure, but the point is that it may not entirely be the tester's fault.
:-)
