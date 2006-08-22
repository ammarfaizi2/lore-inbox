Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWHVKLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWHVKLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWHVKLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:11:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:5319 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932152AbWHVKLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:11:06 -0400
Date: Tue, 22 Aug 2006 15:40:28 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-ID: <20060822101028.GB5052@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174839.GH13917@in.ibm.com> <1156245036.6482.16.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156245036.6482.16.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 11:10:36AM +0000, Mike Galbraith wrote:
> Doesn't seem to work here, but maybe I'm doing something wrong.
> 
> I set up cpuset "all" containing cpu 0-1 (all, 1.something cpus I have;)

You are assigning all the CPUs to the cpuset "all" and then making it an
exclusive/metered cpuset?

I dont think I am handling that case well (yet), primarily because usage of 
remaining tasks (which are not in cpuset "all", "mikeg" & "root") is not 
accounted/controlled. Note that those remaining tasks will be running on one of 
the CPUs assigned to "all". What needs to happen is those remaining tasks need 
to be moved to a separate group (and a runqueue), being given some left-over 
CPU quota (which is left over from assignment of quota to mikeg and root), 
which is not handled in the patches (yet). One of the reason why I havent 
handled it yet is that there is no easy way to retrieve list of tasks attached 
to a cpuset.

Can you try assigning (NUM_CPUS-1) cpus to "all" and give it a shot?
Essentially you need to ensure that only tasks chosen by you are running in 
cpus given to "all" and other child-cpusets under it.


-- 
Regards,
vatsa
