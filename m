Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWJRCpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWJRCpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 22:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWJRCpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 22:45:39 -0400
Received: from mga06.intel.com ([134.134.136.21]:2568 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751152AbWJRCpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 22:45:38 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,322,1157353200"; 
   d="scan'208"; a="146665971:sNHT24153626"
Date: Tue, 17 Oct 2006 19:25:48 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: pj@sgi.com, dino@in.ibm.com, menage@google.com
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com, nickpiggin@yahoo.com.au
Subject: exclusive cpusets broken with cpu hotplug
Message-ID: <20061017192547.B19901@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When ever a cpu hotplug happens, current kernel calls build_sched_domains()
with cpu_online_map. That will destroy all the domain partitions(done by
partition_sched_domains()) setup so far by exclusive cpusets.

And its not just cpu hotplug, this happens even if someone changes multi core
sched power savings policy.

Anyone would like to fix it up? In the presence of cpusets, we basically
need to traverse all the exclusive sets and setup the sched domains
accordingly.

If no one does :( then I will do that when I get some time...

thanks,
suresh
