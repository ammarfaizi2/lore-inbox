Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319531AbSIMFgS>; Fri, 13 Sep 2002 01:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319532AbSIMFgS>; Fri, 13 Sep 2002 01:36:18 -0400
Received: from franka.aracnet.com ([216.99.193.44]:40348 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S319531AbSIMFgR>; Fri, 13 Sep 2002 01:36:17 -0400
Date: Thu, 12 Sep 2002 22:38:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>
cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] per-zone kswapd process
Message-ID: <619179322.1031870337@[10.10.2.3]>
In-Reply-To: <3D817BC8.785F5C44@digeo.com>
References: <3D817BC8.785F5C44@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I don't buy that.
> 
> a) It does not need to be architecture neutral.  
> 
> b) You surely need a way of communicating the discovered topology
>    to userspace anyway.
> 
> c) $EDITOR /etc/numa-layouf.conf
> 
> d) $EDITOR /etc/kswapd.conf

I guess you could do that, but it seems overly complicated to me.
  
>> I think mbligh recently got the long-needed arch code in
>> for cpu to node... But I'm just not able to make the leap of faith that
>> memory detection is something that can ever comfortably be given to
>> userspace.
> 
> A simple syscall which alows you to launch a kswapd instance against
> a group of zones on any group of CPUs provides complete generality 
> and flexibility to userspace.  And it is architecture neutral.
> 
> If it really is incredibly hard to divine the topology from userspace
> then you need to fix that up.  Provide the topology to userspace.
> Which has the added benefit of providing, umm, the topology to userspace ;)

Can we make a simple default of 1 per node, which is what 99% 
of people want, and then make it more complicated later if people 
complain? It's really pretty easy:

for (node = 0; node < numnodes; ++node) {
	kswapd = kick_off_kswapd_for_node(node);
	kswapd->cpus_allowed = node_to_cpus(node);
}

Or whatever the current cpus_allowed method is. All we seem to need
is node_to_cpus ... I can give that to you tommorow with no problem,
it's trivial.

M.

