Return-Path: <linux-kernel-owner+w=401wt.eu-S1760256AbWLKGw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760256AbWLKGw4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 01:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762597AbWLKGwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 01:52:55 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:58421 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760256AbWLKGwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 01:52:55 -0500
Date: Mon, 11 Dec 2006 12:22:28 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Gautham shenoy <ego@in.ibm.com>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: workqueue deadlock
Message-ID: <20061211065228.GA27761@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200612061726.14587.bjorn.helgaas@hp.com> <20061210114943.GA14749@elte.hu> <20061210041600.56306676.akpm@osdl.org> <200612101518.39334.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612101518.39334.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 03:18:38PM +0100, Rafael J. Wysocki wrote:
> On Sunday, 10 December 2006 13:16, Andrew Morton wrote:
> > On Sun, 10 Dec 2006 12:49:43 +0100
> 
> Hm, currently we're using the CPU hotplug to disable the nonboot CPUs before
> the freezer is called. ;-)
> 
> However, we're now trying to make the freezer SMP-safe, so that we can disable
> the nonboot CPUs after devices have been suspended (we want to do this for
> some ACPI-related reasons).  In fact we're almost there, I'm only waiting for
> the confirmation from Pavel to post the patches.
> 
> When this is done, we won't need the CPU hotplug that much and I think the CPU
> hotplug code will be able to do something like:
> 
> freeze_processes
> suspend_cpufreq (or even suspend_all_devices)
> remove_the_CPU_in_question
> resume_cpufreq
> thaw_processes

Have you thought about how much time this might take on
a machine with say - 128 CPUs of which I want to dynamically
reconvigure 64 of them and make a new partition ? Assume
10,000 tasks are running in the system.

Thanks
Dipankar
