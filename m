Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUJHGIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUJHGIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUJHGIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:08:16 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:19331 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267576AbUJHGIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:08:14 -0400
Message-ID: <41662EC8.4040308@yahoo.com.au>
Date: Fri, 08 Oct 2004 16:08:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
CC: jbarnes@engr.sgi.com, colpatch@us.ibm.com, pj@sgi.com, mbligh@aracnet.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       simon.derr@bull.net, frankeh@watson.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] scheduler: Dynamic sched_domains
References: <1097110266.4907.187.camel@arrakis>	<4164A664.9040005@yahoo.com.au>	<200410071001.07516.jbarnes@engr.sgi.com> <20041008.145516.26538192.t-kochi@bq.jp.nec.com>
In-Reply-To: <20041008.145516.26538192.t-kochi@bq.jp.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takayoshi Kochi wrote:

> Yup, if SD_NODES_PER_DOMAIN is set to 4, our 32-way TX-7 have 
> two disjoint domains ;(
> (though the current default is 6 for ia64...)
> 
> I think the default configuration of the scheduler domains should be
> as identical to its real hardware topology as possible, and should
> modify the default only when necessary (e.g. for Altix).
> 

That is the idea. Unfortunately the ia64 modifications are ia64 wide.
I don't think it should be too hard to make it sn2 only.

> Right now with the sched domain scheduler, we have to setup the 
> domain hierarcy only at boot time statically, which makes it harder to
> find the optimal domain topology/parameter.  The dynamic patch
> makes it easier to modify the default configuration.
> 

No you don't have to. If you have a look at the work in -mm, basically
the whole thing gets recreated on every hoplug operation. It would be
trivial to modify some parameters then reinit the domains in the same
way.

N disjoint domains can be trivially handled by making N passes over
the init code, each using a different set of CPUs as its
"cpu_possible_map". This can easily be done dynamically by using
the above method.

> If the scheduler gains more dynamic configurability like what Jesse
> said, it adds more flexibility for runtime optimization and seems
> a way to go.  I'm not sure runtime configurability of domain topology
> is necessary for all users, but it's extremely useful for developers.
> 

That would be nice. The patch queue is pretty well clogged up at the
moment, so I'm not going to look at the scheduler again until all the
patches from -mm get into 2.6.10-bk.
