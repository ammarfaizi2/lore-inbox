Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWFSTLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWFSTLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWFSTLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:11:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:12426 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932408AbWFSTL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:11:29 -0400
Subject: Re: [RFC] CPU controllers?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Chris Friesen <cfriesen@nortel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, vatsa@in.ibm.com,
       Sam Vilain <sam@vilain.net>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       Balbir Singh <balbir@in.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4496E982.3040607@nortel.com>
References: <20060615134632.GA22033@in.ibm.com>
	 <4493C1D1.4020801@yahoo.com.au>  <4496E982.3040607@nortel.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 19 Jun 2006 12:11:25 -0700
Message-Id: <1150744285.30901.6.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 12:14 -0600, Chris Friesen wrote:
> Nick Piggin wrote:
> 
> > So, from my POV, I would like to be convinced of the need for this first.
> > I would really love to be able to keep core kernel simple and fast even if
> > it means edge cases might need to use a slightly different solution.
> 
> We currently use a heavily modified CKRM version "e".
> 
> The "resource groups" (formerly known as CKRM) cpu controls express what 
> we'd like to do, but they aren't nearly accurate enough.  We don't make 
> use the limits, but we do use per-cpu guarantees, along with the 
> hierarchy concept.
> 
> Our engineering guys need to be able to make cpu guarantees for the 
> various type of processes.  "main server app gets 90%, these fault 
> handling guys normally get 2% but should be able to burst to 100% for up 
> to 100ms, that other group gets 5% in total, but a subset of them should 
> get priority over the others, and this little guy here should only be 
> guaranteed .5% but it should take priority over everything else on the 
> system as long as it hasn't used all its allocation".
> 
> Ideally they'd really like sub percentage (.1% would be nice, but .5% is 
> proably more realistic) accuracy over the divisions.  This should be 
> expressed per-cpu, and tasks should be migrated as necessary to maintain 
> fairness.  (Ie, a task belonging to a group with 50% on each cpu should 
> be able to run essentially continuously, bouncing back and forth between 
> cpus.)  In our case, predictability/fairness comes first, then performance.
> 
> If a method is accepted into mainline, it would be nice to have NPTL 
> support it as a thread attribute so that different threads can be in 
> different groups.
> 

Chris,

Resource Groups(CKRM) does allow threads to be in different Resource
Groups ( and since Resource Group assignment is dynamic, a thread can
move to a high priority resource group for a specific operation and get
back to its original resource group after the operation is complete).

Just wondering if that is sufficient or you _would_ need support from
NPTL.

chandra
> Chris
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


