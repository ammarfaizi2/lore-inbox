Return-Path: <linux-kernel-owner+w=401wt.eu-S1762564AbWLKGEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762564AbWLKGEM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 01:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762566AbWLKGEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 01:04:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48074 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762563AbWLKGEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 01:04:12 -0500
Date: Sun, 10 Dec 2006 22:03:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: mingo@elte.hu, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       myron.stowe@hp.com, axboe@kernel.dk, dipankar@in.ibm.com,
       ego@in.ibm.com
Subject: Re: workqueue deadlock
Message-Id: <20061210220343.e58614ae.akpm@osdl.org>
In-Reply-To: <20061211054545.GC5339@in.ibm.com>
References: <20061207105148.20410b83.akpm@osdl.org>
	<20061207113700.dc925068.akpm@osdl.org>
	<20061208025301.GA11663@in.ibm.com>
	<20061207205407.b4e356aa.akpm@osdl.org>
	<20061209102652.GA16607@elte.hu>
	<20061209114723.138b6e89.akpm@osdl.org>
	<20061210082616.GB14057@elte.hu>
	<20061210004318.8e1ef324.akpm@osdl.org>
	<20061210114943.GA14749@elte.hu>
	<20061210041600.56306676.akpm@osdl.org>
	<20061211054545.GC5339@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 11 Dec 2006 11:15:45 +0530 Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> On Sun, Dec 10, 2006 at 04:16:00AM -0800, Andrew Morton wrote:
> > One quite different way of addressing all of this is to stop using
> > stop_machine_run() for hotplug synchronisation and switch to the swsusp
> > freezer infrastructure: all kernel threads and user processes need to stop
> > and park themselves in a known state before we allow the CPU to be removed.
> > lock_cpu_hotplug() becomes a no-op.
> 
> Well ...you still need to provide some mechanism for stable access to
> cpu_online_map in blocking functions (ex: do_event_scan_all_cpus). 
> Freezing-tasks/Resuming-them-after-hotp-unplug is definitely not one of them 
> (when they resume, online_map would have changed under their feet).

Problems will only occur if a process is holding some sort of per-cpu state
across a call to try_to_freeze().  Surely nobody does that.
