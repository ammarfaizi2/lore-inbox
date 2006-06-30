Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWF3Wxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWF3Wxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWF3Wxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:53:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932106AbWF3Wxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:53:32 -0400
Date: Fri, 30 Jun 2006 15:56:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060630155612.36189ced.akpm@osdl.org>
In-Reply-To: <44A57310.3010208@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<449999D1.7000403@engr.sgi.com>
	<44999A98.8030406@engr.sgi.com>
	<44999F5A.2080809@watson.ibm.com>
	<4499D7CD.1020303@engr.sgi.com>
	<449C2181.6000007@watson.ibm.com>
	<20060623141926.b28a5fc0.akpm@osdl.org>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<44A57310.3010208@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> Based on previous discussions, the above solutions can be expanded/modified to:
> 
> a) allow userspace to listen to a group of cpus instead of all. Multiple
> collection daemons can distribute the load as you pointed out. Doing collection
> by cpu groups rather than individual cpus reduces the aggregation burden on
> userspace (and scales better with NR_CPUS)
> 
> b) do flow control on the kernel send side. This can involve buffering and sending
> later (to handle bursty case) or dropping (to handle sustained load) as pointed out
> by you, Jamal in other threads.
> 
> c) increase receiver's socket buffer. This can and should always be done but no
> involvement needed.
> 
> 
> With regards to taskstats changes to handle the problem and its impact on userspace
> visible changes,
> 
> a) will change userspace
> b) will be transparent.
> c) is immaterial going forward (except perhaps as a change in Documentation)
> 
> 
> I'm sending a patch that demonstrates how a) can be done quite simply
> and a patch for b) is in progress.
> 
> If the approach suggested in patch a) is acceptable (and I'll provide the testing, stability
> results once comments on it are largely over), could taskstats acceptance in 2.6.18 go ahead
> and patch b) be added later (solution outline has already been provided and a prelim patch should
> be out by eod)

Throwing more CPUs at the problem makes heaps of sense.

It's not necessarily a userspace-incompatible change.  As long as userspace
sets nl_pid to 0x00000000, future kernel revisions can treat that as "all
CPUs".  Or userspace can be forward-compatible by setting nl_pid to
0xffff0000, or whatever.
