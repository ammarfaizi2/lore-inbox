Return-Path: <linux-kernel-owner+w=401wt.eu-S937016AbWLKQbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937016AbWLKQbe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937099AbWLKQbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:31:34 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:48681 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937016AbWLKQbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:31:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dipankar@in.ibm.com
Subject: Re: workqueue deadlock
Date: Mon, 11 Dec 2006 17:34:00 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Gautham shenoy <ego@in.ibm.com>,
       Pavel Machek <pavel@ucw.cz>
References: <200612061726.14587.bjorn.helgaas@hp.com> <200612101518.39334.rjw@sisk.pl> <20061211065228.GA27761@in.ibm.com>
In-Reply-To: <20061211065228.GA27761@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612111734.01911.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 December 2006 07:52, Dipankar Sarma wrote:
> On Sun, Dec 10, 2006 at 03:18:38PM +0100, Rafael J. Wysocki wrote:
> > On Sunday, 10 December 2006 13:16, Andrew Morton wrote:
> > > On Sun, 10 Dec 2006 12:49:43 +0100
> > 
> > Hm, currently we're using the CPU hotplug to disable the nonboot CPUs before
> > the freezer is called. ;-)
> > 
> > However, we're now trying to make the freezer SMP-safe, so that we can disable
> > the nonboot CPUs after devices have been suspended (we want to do this for
> > some ACPI-related reasons).  In fact we're almost there, I'm only waiting for
> > the confirmation from Pavel to post the patches.
> > 
> > When this is done, we won't need the CPU hotplug that much and I think the CPU
> > hotplug code will be able to do something like:
> > 
> > freeze_processes
> > suspend_cpufreq (or even suspend_all_devices)
> > remove_the_CPU_in_question
> > resume_cpufreq
> > thaw_processes
> 
> Have you thought about how much time this might take on
> a machine with say - 128 CPUs of which I want to dynamically
> reconvigure 64 of them and make a new partition ? Assume
> 10,000 tasks are running in the system.

Well, of course it doesn't makes sense to freeze processes and thaw them for
each CPU again and again.  Still the overall idea is to freeze processes and
suspend devices, then do something with as many CPUs as necessary etc.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
