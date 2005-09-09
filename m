Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965263AbVIIF5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbVIIF5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 01:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965264AbVIIF5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 01:57:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32985 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965263AbVIIF5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 01:57:51 -0400
Date: Thu, 8 Sep 2005 22:55:39 -0700
From: Paul Jackson <pj@sgi.com>
To: magnus.damm@gmail.com
Cc: kurosawa@valinux.co.jp, dino@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
Message-Id: <20050908225539.0bc1acf6.pj@sgi.com>
In-Reply-To: <aec7e5c305090821126cea6b57@mail.gmail.com>
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	<20050908002323.181fd7d5.pj@sgi.com>
	<20050908081819.2EA4E70031@sv1.valinux.co.jp>
	<20050908050232.3681cf0c.pj@sgi.com>
	<20050909013804.1B64B70037@sv1.valinux.co.jp>
	<aec7e5c305090821126cea6b57@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

magnus wrote:
> Maybe it is possible to have an hierarchical model and keep the
> framework simple and easy to understand while providing guarantees,

Dinakar's patches to use cpu_exclusive cpusets to define dynamic
sched domains accomplish something like this.

What scheduler domains and resource control domains both need
are non-overlapping subsets of the CPUs and/or Memory Nodes.

In the case of sched domains, you normally want the subsets
to cover all the CPUs.  You want every CPU to have exactly
one scheduler that is responsible for its scheduling.

In the case of resource control domains, you perhaps don't
care if some CPUs or Memory Nodes have no particular resources
constraints defined for them.  In that case, every CPU and
every Memory Node maps to _either_ zero or one resource control
domain.

Either way, a 'flat model' non-overlapping partitioning of the
CPUs and/or Memory Nodes can be obtained from a hierarchical
model (nested sets of subsets) by selecting some of the subsets
that don't overlap ;).  In /dev/cpuset, this selection is normally
made by specifying another boolean file (contains '0' or '1')
that controls whether that cpuset is one of the selected subsets.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
