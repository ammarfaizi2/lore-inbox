Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWJXPpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWJXPpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWJXPpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:45:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3542 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965153AbWJXPpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:45:16 -0400
Date: Tue, 24 Oct 2006 08:44:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061024084455.477903a5.pj@sgi.com>
In-Reply-To: <20061023134730.62e791a2.pj@sgi.com>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
	<20061022201824.267525c9.pj@sgi.com>
	<453C4E22.9000308@yahoo.com.au>
	<20061023195011.GB1542@in.ibm.com>
	<20061023134730.62e791a2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote to Dinakar:
> The only twist to your patch I would like you to consider - instead
> of a 'sched_domain' flag marking where the partitions go, how about
> a flag that tells the kernel it is ok not to load balance tasks in
> a cpuset?

Dinakar - one possibility that might work well:

  Proceed with the 'sched_domain' patch you are working on, as you planned.

  (If you like, stop reading here ... <grin>.)

  Then I can propose a patch on top of that, to flip the kernel-user API
  to the "ok not to load balance" style I'm proposing.  This patch would:
    - leave your internal logic in place, as is,
    - remove your 'sched_domain' flag from the visible API (keep it internally),
    - add a 'cpu_must_load_balance' (default 1) flag to the API, and
    - add a bit of logic to set, top down, your internal sched_domain flag,
      based on the cpu_must_load_balance and parent sched_domain settings.

  Then we can all see these two alternative API styles, your sched_domain
  style and my cpu_must_load_balance style, and pick one (just by keeping
  or tossing my extra patch.)

A couple of aspects of my cpu_must_load_balance style that I like:

  * The batch scheduler can turn off requiring load balancing on its
    inactive cpusets, without worrying about whether it has the right
    (exclusive control) to do that or not.

  * I figure that users will relate better to a choice of whether or not
    they require cpu load balancing, than they will to the question of
    where to partition scheduler domains.

Of course, if Nick succeeds on his mission to convince us that we can
do this automatically, then the above doesn't matter, and we'd need a
different patch altogether.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
