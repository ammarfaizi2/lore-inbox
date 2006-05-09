Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWEIRa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWEIRa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWEIRa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:30:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35509 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750771AbWEIRaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:30:55 -0400
Date: Tue, 9 May 2006 22:57:16 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
Message-ID: <20060509172716.GB10478@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org> <20060509035320.GC784@in.ibm.com> <44601933.2040905@yahoo.com.au> <20060509054556.GG784@in.ibm.com> <44602F32.1060909@yahoo.com.au> <20060509080638.GB11533@in.ibm.com> <446050BC.5070608@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446050BC.5070608@yahoo.com.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 06:20:12PM +1000, Nick Piggin wrote:
> Balbir Singh wrote:
> 
> >On Tue, May 09, 2006 at 03:57:06PM +1000, Nick Piggin wrote:
> >
> >>Well they'll be _collecting_ the stats, yes. Will they really be using
> >>them for anything?
> >>
> >
> >Hmm.. No, the statistics are sent down using the netlink interface
> >to listeners on the netlink group (on every task exit) or to the task that
> >actually requested for the delay accounting data.
> >
> >The stats are currently gathered in kernel and used by user space.
> >
> 
> So... what are the consumers of this data going to be? That is my question.

More details on the consumers of this data is available at
http://lkml.org/lkml/2006/3/13/367

> 
> >>If you make the whole thing much lighter weight for tasks which aren't
> >>using the accounting, you have a better chance of people turning the
> >>CONFIG option on.
> >>
> >>
> >
> >I am not sure I understand the point completely. Are you suggesting that
> >struct task_delay_info be moved to common data structure as an aggregate
> >containing all the delay stats data?
> >
> 
> My suggestion is basically this: if the accounting is going to be used
> infrequently, it might be a good idea to allocate the accounting structures
> on demand, and only perform the accounting when these structures are
> allocated.
> 
> It all adds up. Extra cache misses, more icache, more logic, etc... I 
> suspect
> that relatively few people will care about these stats.
>

Thanks for clarifying.  I now understand your suggestion better.

The accounting is going to be frequent, with data from all tasks in the
system being collected and processed frequently. Since the accounting is
frequent, I think the current scheme works better than on-demand allocation.

Regarding the usefulness of these stats, please see
http://www.uwsg.iu.edu/hypermail/linux/kernel/0604.2/1731.html


	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
