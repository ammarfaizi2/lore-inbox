Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWGZWtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWGZWtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 18:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWGZWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 18:49:15 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:9094 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751813AbWGZWtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 18:49:13 -0400
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be
	totally bizare
From: Arjan van de Ven <arjan@linux.intel.com>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, torvalds@osdl.org,
       davej@redhat.com, mingo@elte.hu, 76306.1226@compuserve.com,
       ashok.raj@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <r6ejw8vvsp.fsf@skye.ra.phy.cam.ac.uk>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
	 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
	 <20060725185449.GA8074@elte.hu>
	 <1153855844.8932.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
	 <1153921207.3381.21.camel@laptopd505.fenrus.org>
	 <20060726155114.GA28945@redhat.com>
	 <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
	 <1153942954.3381.50.camel@laptopd505.fenrus.org>
	 <20060726204233.GA23488@in.ibm.com>
	 <1153947786.3381.58.camel@laptopd505.fenrus.org>
	 <1153947786.3381.58.camel@laptopd505.fenrus.org>
	 <20060726143357.2f0787e7.akpm@osdl.org>
	 <r6ejw8vvsp.fsf@skye.ra.phy.cam.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 00:44:22 +0200
Message-Id: <1153953862.3381.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 23:35 +0100, Sanjoy Mahajan wrote:
> From: Andrew Morton <akpm@osdl.org>
> > We should delete lock_cpu_hotplug() and start again.
> 
> Here is another example of possible lock_cpu_hotplug() problems.  Is
> it worth tracking down, or should I just ignore the messages until a
> proper solution is figured out?  The only problem is that it means S3
> suspend doesn't work.
> 
> The hardware is a Thinkpad T60, T2400 dual-core, compiled with SMP and
> PREEMPT, hotpluggable CPUs, and it has a SATA drive.  Kernel is
> 2.6.18-rc1.  Suspend (UP) worked with 2.6.15-25-386 from Ubuntu using
> the same sleep.sh script.  The messages below, including the large
> lockdep backtrace, occur after running sleep.sh (run by Fn-F4):
> 
> 
> [  546.652000] Stopping tasks: ====================================================================================
> [  566.848000]  stopping tasks timed out after 20 seconds (8 tasks remaining):
> [  566.848000]   rt-test-0
> [  566.848000]   rt-test-1
> [  566.848000]   rt-test-2
> [  566.848000]   rt-test-3
> [  566.848000]   rt-test-4
> [  566.848000]   rt-test-5
> [  566.848000]   rt-test-6
> [  566.848000]   rt-test-7
> 
this got fixed in -rc2

> The lockdep code also reported problems:
> 
> [  538.292000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
> [  546.144000] Freezing cpus ...
> [  546.172000] 
> [  546.172000] =======================================================
> [  546.172000] [ INFO: possible circular locking dependency detected ]
> [  546.172000] -------------------------------------------------------
> [  546.172000] sleep.sh/15184 is trying to acquire lock:
> [  546.172000]  (&policy->lock){--..}, at: [<c0310645>] mutex_lock+0x25/0x30
> [  546.172000] 
> [  546.172000] but task is already holding lock:
> [  546.172000]  ((cpu_chain).rwsem){----}, at: [<c0133267>] blocking_notifier_call_chain+0x17/0x40
> [  546.172000] 

and afaik my patches in current git should fix all this up
if not please send a trace ;)

