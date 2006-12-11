Return-Path: <linux-kernel-owner+w=401wt.eu-S1762527AbWLKFqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762527AbWLKFqn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 00:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762528AbWLKFqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 00:46:43 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60405 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762524AbWLKFqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 00:46:42 -0500
Date: Mon, 11 Dec 2006 11:15:45 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061211054545.GC5339@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061207105148.20410b83.akpm@osdl.org> <20061207113700.dc925068.akpm@osdl.org> <20061208025301.GA11663@in.ibm.com> <20061207205407.b4e356aa.akpm@osdl.org> <20061209102652.GA16607@elte.hu> <20061209114723.138b6e89.akpm@osdl.org> <20061210082616.GB14057@elte.hu> <20061210004318.8e1ef324.akpm@osdl.org> <20061210114943.GA14749@elte.hu> <20061210041600.56306676.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210041600.56306676.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 04:16:00AM -0800, Andrew Morton wrote:
> One quite different way of addressing all of this is to stop using
> stop_machine_run() for hotplug synchronisation and switch to the swsusp
> freezer infrastructure: all kernel threads and user processes need to stop
> and park themselves in a known state before we allow the CPU to be removed.
> lock_cpu_hotplug() becomes a no-op.

Well ...you still need to provide some mechanism for stable access to
cpu_online_map in blocking functions (ex: do_event_scan_all_cpus). 
Freezing-tasks/Resuming-them-after-hotp-unplug is definitely not one of them 
(when they resume, online_map would have changed under their feet).

> Dunno if it'll work - I only just thought of it.  It sure would simplify
> things.

-- 
Regards,
vatsa
