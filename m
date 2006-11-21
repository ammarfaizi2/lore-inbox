Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966897AbWKUCSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966897AbWKUCSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 21:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966900AbWKUCSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 21:18:41 -0500
Received: from mga05.intel.com ([192.55.52.89]:26642 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S966897AbWKUCSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 21:18:41 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,441,1157353200"; 
   d="scan'208"; a="166999881:sNHT34886467"
Date: Mon, 20 Nov 2006 17:54:42 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [patch] sched: decrease number of load balances
Message-ID: <20061120175441.C17305@unix-os.sc.intel.com>
References: <20061120142633.A17305@unix-os.sc.intel.com> <Pine.LNX.4.64.0611201625240.23868@schroedinger.engr.sgi.com> <20061120164338.B17305@unix-os.sc.intel.com> <Pine.LNX.4.64.0611201734490.24998@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0611201734490.24998@schroedinger.engr.sgi.com>; from clameter@sgi.com on Mon, Nov 20, 2006 at 05:39:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 05:39:42PM -0800, Christoph Lameter wrote:
> On Mon, 20 Nov 2006, Siddha, Suresh B wrote:
> 
> > My patch is not changing any idle load balancing logic and hence it is no
> > less/more aggressive as the current one.
> 
> But you cannot do anything in addition to idle balancing. You can only 
> draw a process to the cpu you are balancing on. And we are already doing 
> that.

Yes. The above logic is not changed.

Once an idle processor('P') picked up some load(based on load differences of groups
at level 'X) at level 'X', group of cpus(containing 'P') in level 'X-1' will try to
distribute that load among them depending on their groups load at that level. And
this repeats till we reach the lowest level..

> So this cuts down the frequency of idle balance?

Frequency of idle processor doing balance is same as today but what we reduce
is number of processors doing that load balance.

> And only the first idle processor of a group of idle processors does balancing?

That is correct. If all the cpus in a group are busy, then only the first cpu in
the group will do load balance between the groups. We really don't have to
calculate who in the group is leastly loaded, as we can assume that load is equally
balanced at level 'X-1' while doing load balancing at level 'X'.

thanks,
suresh
