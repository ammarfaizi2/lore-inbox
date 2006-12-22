Return-Path: <linux-kernel-owner+w=401wt.eu-S1946024AbWLVKuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946024AbWLVKuW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946034AbWLVKuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:50:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36662 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946024AbWLVKuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:50:21 -0500
Date: Fri, 22 Dec 2006 02:44:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: ego@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, David Wilder <dwilder@us.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>, kiran@scalex86.org,
       venkatesh.pallipadi@intel.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       torvalds@osdl.org, davej@redhat.com
Subject: Re: [PATCH] Relay CPU Hotplug support
Message-Id: <20061222024458.322adffd.akpm@osdl.org>
In-Reply-To: <20061222103724.GA29348@in.ibm.com>
References: <20061221003101.GA28643@Krystal>
	<20061220232350.eb4b6a46.akpm@osdl.org>
	<20061222103724.GA29348@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 16:07:24 +0530
Gautham R Shenoy <ego@in.ibm.com> wrote:

> While we are at this per-subsystem cpuhotplug "locking", here's a
> proposal that might put an end to the workqueue deadlock woes.

Oleg is working on some patches which will permit us to cancel or wait upon
a particular work_struct, rather than upon all pending work_structs.  

This will fix the problem where we accidentlly wait upon some unrelated
work_struct which takes a lock which is related to one which we already
hold.

I hope.  It'll be a bit tricky to implement: if some foreign work_struct is
running right now, we cannot wait upon it - we must non-blockingly dequeue
the work_struct which we want to kill before it gets to run.


