Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161770AbWKIABG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161770AbWKIABG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161769AbWKIABG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:01:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:61481 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1161770AbWKIABE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:01:04 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="158496799:sNHT153689228"
Subject: Re: 2.6.19-rc5: known regressions
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061108162202.GA4729@stusta.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de>
	 <m1y7qm425l.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0611080745150.3667@g5.osdl.org>
	 <20061108162202.GA4729@stusta.de>
Content-Type: text/plain
Organization: Intel
Date: Wed, 08 Nov 2006 15:11:34 -0800
Message-Id: <1163027494.10806.229.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 17:22 +0100, Adrian Bunk wrote:

> There's perhaps one thing that might help us to see whether it's just a 
> benchmark effekt or a real problem:
> 
> With Tim's CONFIG_NR_CPUS=8, NR_IRQS only increases from 224 in 2.6.18 
> to 512 in 2.6.19-rc.
> 
> With CONFIG_NR_CPUS=255, NR_IRQS increases from 224 in 2.6.18
> to 8416 in 2.6.19-rc.
> 
> @Tim:
> Can you try CONFIG_NR_CPUS=255 with both 2.6.18 and 2.6.19-rc5?
> 

With CONFIG_NR_CPUS increased from 8 to 64:
2.6.18     see no change in fork time measured.
2.6.19-rc5 see a 138% increase in fork time.

When I increase CONFIG_NR_CPUS to 128, the child process
from fork got killed when it executes sched_getaffinity call
in the routine to pin the process onto a processor.
This happened for both 2.6.18 and 2.6.19-rc5.
I'll need to check more carefully what lmbench is doing
there.

Tim
