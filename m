Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUJDE1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUJDE1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 00:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268400AbUJDE1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 00:27:39 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:42709 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268392AbUJDE1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 00:27:37 -0400
Date: Sun, 3 Oct 2004 21:24:52 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041003212452.1a15a49a.pj@sgi.com>
In-Reply-To: <838090000.1096862199@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> Then when I fork off exclusive subset for CPUs 1&2, I have to push A & B
> into it.

Tasks A & B must _not_ be considered members of that exclusive cpuset,
even though it seems that A & B must be attended to by the sched_domain
and memory_domain associated with that cpuset.

The workload managers expect to be able to list the tasks in a cpuset,
so it can hibernate, migrate, kill-off, or wait for the finish of these
tasks.  I've been through this bug before - it was one that cost Hawkes
a long week to debug - I was moving the per-cpu migration threads off
their home CPU because I didn't have a clear way to distinguish tasks
genuinely in a cpuset, from tasks that just happened to be indigenous to
some of the same CPUs.  My essential motivation for adapting a cpuset
implementation that has a task struct pointer to a shared cpuset struct
was to track exactly this relation - which tasks are in which cpuset.

No ... tasks A & B are not allowed in that new exclusive cpuset.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
