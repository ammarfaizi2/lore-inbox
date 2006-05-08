Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWEHHkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWEHHkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWEHHkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:40:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:57365 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932146AbWEHHke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:40:34 -0400
X-IronPort-AV: i="4.05,100,1146466800"; 
   d="scan'208"; a="32985120:sNHT31048780"
Subject: Re: [PATCH 0/10] bulk cpu removal support
From: Shaohua Li <shaohua.li@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060508062905.GA9344@localdomain>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>
	 <20060508062905.GA9344@localdomain>
Content-Type: text/plain
Date: Mon, 08 May 2006 15:39:19 +0800
Message-Id: <1147073960.2760.104.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 01:29 -0500, Nathan Lynch wrote:
> Shaohua Li wrote:
> > CPU hotremove will migrate tasks and redirect interrupts off dead cpu.
> > To remove multiple CPUs, we should iteratively do single cpu removal.
> > If tasks and interrupts are migrated to a cpu which will be soon
> > removed, then we will trash tasks and interrupts again. The following
> > patches allow remove several cpus one time. It's fast and avoids
> > unnecessary repeated trash tasks and interrupts. This will help NUMA
> > style hardware removal and SMP suspend/resume. Comments and suggestions
> > are appreciated.
> 
> Some quantification of the benefits of adding this complexity would be
> appreciated.  Like, how long does it take to offline all the cpus in a
> node serially, and how much faster is the bulk method?
This depends on the workload and I haven't a data at hand, sorry. Fast
(less tasks/timers/softirqs migration) is one benefit. The method also
means less time in stop_machine_run and less interrupt redirection, so
smaller impact to the whole system.

Thanks,
Shaohua
