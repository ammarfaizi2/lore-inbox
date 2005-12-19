Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVLSOsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVLSOsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLSOsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:48:41 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:29577 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932161AbVLSOsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:48:38 -0500
Date: Mon, 19 Dec 2005 06:48:10 -0800
From: Paul Jackson <pj@sgi.com>
To: paulmck@us.ibm.com
Cc: akpm@osdl.org, dada1@cosmosbay.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, ak@suse.de,
       clameter@sgi.com
Subject: Re: [PATCH 04/04] Cpuset: skip rcu check if task is in root cpuset
Message-Id: <20051219064810.0ec403ee.pj@sgi.com>
In-Reply-To: <20051217164723.GA28255@us.ibm.com>
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
	<20051214084049.21054.34108.sendpatchset@jackhammer.engr.sgi.com>
	<20051216175201.GA24876@us.ibm.com>
	<20051216120651.cb57ad2e.pj@sgi.com>
	<20051217164723.GA28255@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> But it seems like you could gain this
> benefit and more simply by disabling CONFIG_DEBUG_PREEMPT.

Yup - that would save oodles more than what we're dickering over here.

> My usual position would be to avoid putting too much effort into optimizing
> debug code, but please feel free to educate me on this one!

My position too ;).

I should quit wasting your time (and mine) with further fine tuning
of this test to skip rcu check if task->cpuset == &top_cpuset, and
instead consider removing CONFIG_DEBUG_PREEMPT from at least ia64
(sn2), if not also from the other defconfigs that have it:

    collie            simpad            s390              se7705
    lpd7a400          bigsur            dreamcast         sh03
    lpd7a404          microdev          systemh           mx1ads

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
