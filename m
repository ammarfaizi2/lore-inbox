Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVLSQF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVLSQF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVLSQF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:05:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10439 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964789AbVLSQF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:05:57 -0500
Date: Mon, 19 Dec 2005 08:04:01 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: paulmck@us.ibm.com, akpm@osdl.org, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, Greg Edwards <edwardsg@sgi.com>,
       clameter@sgi.com
Subject: CONFIG_DEBUG_PREEMPT (was: [PATCH 04/04] Cpuset: skip rcu check
 ...)
Message-Id: <20051219080401.861acca2.pj@sgi.com>
In-Reply-To: <20051219064810.0ec403ee.pj@sgi.com>
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
	<20051214084049.21054.34108.sendpatchset@jackhammer.engr.sgi.com>
	<20051216175201.GA24876@us.ibm.com>
	<20051216120651.cb57ad2e.pj@sgi.com>
	<20051217164723.GA28255@us.ibm.com>
	<20051219064810.0ec403ee.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> instead consider removing CONFIG_DEBUG_PREEMPT from at least sn2

Ah - perhaps not so.  Adding my SGI colleague Greg Edwards to the cc
list.  My email archives suggest that he enabled CONFIG_DEBUG_PREEMPT
in ia64 sn2_defconfig a few months ago, and I presume did so intentionally.

The change enabling CONFIG_DEBUG_PREEMPT was:
    user:        Greg Edwards <edwardsg@sgi.com>
    date:        Tue Aug 16 23:38:16 2005 +0011
    summary:     [IA64] Refresh arch/ia64/configs/sn2_defconfig.

Greg - CONFIG_DEBUG_PREEMPT adds a couple of pages of assembly code 
due to various BUG checks beneath rcu_read_lock() on some hot code
paths (which is where rcu is most popular).  See the two calls
add_preempt_count() and sub_preempt_count() in kernel/sched.c.

Was this intentional to enable CONFIG_DEBUG_PREEMPT in sn2_defconfig?

Other evidence opposing this DEBUG opttion:

    Most other DEBUG options are turned off in the defconfigs.

Other evidence supporting setting this DEBUG option:

    We're not the only arch enabling CONFIG_DEBUG_PREEMPT.  See also:
        collie            simpad            s390              se7705
        lpd7a400          bigsur            dreamcast         sh03
        lpd7a404          microdev          systemh           mx1ads

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
