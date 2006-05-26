Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWEZUGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWEZUGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWEZUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 16:06:47 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:41551 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751414AbWEZUGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 16:06:46 -0400
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [openib-general] [PATCH 06/16] ehca: interrupt handling routines
X-Message-Flag: Warning: May contain useful information
References: <4468BD63.6070509@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 26 May 2006 13:06:44 -0700
In-Reply-To: <4468BD63.6070509@de.ibm.com> (Heiko J. Schick's message of "Mon, 15 May 2006 19:41:55 +0200")
Message-ID: <ada3bewh7or.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 May 2006 20:06:45.0486 (UTC) FILETIME=[E9D760E0:01C680FF]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	for_each_online_cpu(cpu) {
 > +		task = create_comp_task(pool, cpu);
 > +		if (task) {
 > +			kthread_bind(task, cpu);
 > +			wake_up_process(task);
 > +		}
 > +	}

How does this creation of a thread pool work with respect to CPU
hotplug?  What happens if a CPU goes away?  How about if only one CPU
is running when the driver is loaded, and then 15 more are hot-added?

 > +	for (i = 0; i < NR_CPUS; i++) {
 > +		if (cpu_online(i))
 > +			destroy_comp_task(pool, i);
 > +	}

And it seems in the destroy function, you will possibly leak threads
or try to kill a non-existent thread if the set of online CPUs has
changed since the driver started...

 - R.
