Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWEKRTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWEKRTc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWEKRTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:19:32 -0400
Received: from proof.pobox.com ([207.106.133.28]:45764 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1030383AbWEKRTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:19:32 -0400
Date: Thu, 11 May 2006 12:19:20 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca, vatsa@in.ibm.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060511171920.GB10833@localdomain>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com> <20060510230606.076271b2.akpm@osdl.org> <20060511095308.A15483@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511095308.A15483@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Wed, May 10, 2006 at 11:06:06PM -0700, Andrew Morton wrote:
> Hi Andrew,
> 
> > Shaohua Li <shaohua.li@intel.com> wrote:
> > >
> > > CPU hotremove will migrate tasks and redirect interrupts off dead cpu.
> > 
> > This seems an awful lot of code for something which happens so infrequently.
> > 
> > How big is the problem you're fixing here, and what are the
> > user-observeable effects of these changes?
> 
> This is useful when say a NUMA node is being removed. With new multi-core
> CPUs comming up, considering a 2 core with HT, we could have up to 4 logical
> per socket. On NUMA node with 4 sockets, a node removal will mean we 
> do 16 single cpu offlines. Each time the process and interrupts could
> end up on a CPU that might be removed just immediatly.

But offlining all the cpus in a node is already something that just
works.  If the user is all that concerned about not thrashing the
tasks running on that node, they would have a workload manager that
migrates the tasks off the node before shooting down cpus.  Similar
argument applies to interrupt affinity.

I really haven't seen a compelling argument for why this is needed,
just a bunch of handwaving so far, sorry.

