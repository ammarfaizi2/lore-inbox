Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWJWIOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWJWIOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWJWIOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:14:45 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:44909 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751810AbWJWIOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:14:44 -0400
Date: Mon, 23 Oct 2006 10:14:41 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] x86_64 irq: Only look at per_cpu data for online cpus.
Message-ID: <20061023081441.GP4354@rhun.haifa.ibm.com>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <20061022035109.GM5211@rhun.haifa.ibm.com> <m1psck21fc.fsf@ebiederm.dsl.xmission.com> <20061022085216.GQ5211@rhun.haifa.ibm.com> <m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com> <m1k62ry7hl.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k62ry7hl.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 10:35:34PM -0600, Eric W. Biederman wrote:
> 
> When I generalized __assign_irq_vector I failed to pay attention
> to what happens when you access a per cpu data structure for
> a cpu that is not online.   It is an undefined case making any
> code that does it have undefined behavior as well.
> 
> The code still needs to be able to allocate a vector across cpus
> that are not online to properly handle combinations like lowest
> priority interrupt delivery and cpu_hotplug.  Not that we can do
> that today but the infrastructure shouldn't prevent it.
> 
> So this patch updates the places where we touch per cpu data
> to only touch online cpus, it makes cpu vector allocation
> an atomic operation with respect to cpu hotplug, and it updates
> the cpu start code to properly initialize vector_irq so we
> don't have inconsistencies.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

I tried 1/2 and 2/2 at the same time and it booted, so good work :-)
I'm stressing the machine a little now, will let you know if anything
out of the ordinary comes up.

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli

