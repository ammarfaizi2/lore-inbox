Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWINSeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWINSeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWINSeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:34:23 -0400
Received: from mga07.intel.com ([143.182.124.22]:4213 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751003AbWINSeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:34:22 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,166,1157353200"; 
   d="scan'208"; a="116566943:sNHT19159574"
Subject: Re: Shared page tables patch... some results
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ian Stirling <ian.stirling@mauve.plus.com>,
       Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, akpm@osdl.org, ">" <dmccr@us.ibm.com>
In-Reply-To: <3282373b0609141116n1bce85b3u38924491146a89f2@mail.gmail.com>
References: <1155638047.3011.96.camel@laptopd505.fenrus.org>
	 <3282373b0609141116n1bce85b3u38924491146a89f2@mail.gmail.com>
Content-Type: text/plain
Organization: Intel
Date: Thu, 14 Sep 2006 10:45:37 -0700
Message-Id: <1158255937.18314.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2006 3:34 AM, Arjan van de Ven wrote:

> 
> Hi,
> 
> until OLS of this year, most people thought that Dave's shared page
> table patch was effectively a database-only hack, and thus not all that
> interesting...
> 
> however it's also possible to use shared page tables for shared
> libraries, and thus the gain is MUCH wider in scope. Dave has been so
> kind as to send me his latest patch, and I've done some measurements on
> my new x86-64 test machine (which runs FC6-test2)...
> 
> and the result is interesting:
> Just booting into runlevel 5 and logging into gnome (without starting
> any apps) gets a sharing of 1284 pte pages! This means that five
> megabytes (!!) of memory is saved, and countless pagefaults are avoided.
> 

The shared page table patch also gives a nice boost to the fork speed as
tested on a woodcrest machine using lmbench-3.0-a7.

2.6.18-rc4 with shared page table enabled (usec):
fork 136
exec 303
sh   828

2.6.18-rc4 without shared page table (usec):
fork 179
exec 364
sh   949

The test was done with the lmbench option to pin both parent and child
onto the same cpu core, and lmbench includes the overhead of calling
sched_setaffinity.

Tim Chen
