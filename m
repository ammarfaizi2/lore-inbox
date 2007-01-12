Return-Path: <linux-kernel-owner+w=401wt.eu-S1161045AbXALL22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbXALL22 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbXALL22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:28:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49862 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161045AbXALL21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:28:27 -0500
Date: Fri, 12 Jan 2007 03:28:20 -0800
From: Paul Jackson <pj@sgi.com>
To: sander@humilis.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: 'struct task_struct' has no member named 'mems_allowed'  (was:
 Re: 2.6.20-rc4-mm1)
Message-Id: <20070112032820.9c995718.pj@sgi.com>
In-Reply-To: <20070112105224.GA12813@favonius>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	<20070112105224.GA12813@favonius>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
> > +mbind-restrict-nodes-to-the-currently-allowed-cpuset.patch
> 
> I had to revert this patch because of:
> 
> ===
> mm/mempolicy.c: In function 'sys_mbind':
> mm/mempolicy.c:885: error: 'struct task_struct' has no member named 'mems_allowed'

You're right - this patch won't build if CONFIG_NUMA is on, and
CONFIG_CPUSETS off.

The line added in the patch:

  +	nodes_and(nodes, nodes, current->mems_allowed);

needs to be macro'ized, using another cpuset.h routine, to a no-op, in
the case that CONFIG_CPUSET is disabled.

I'll leave the honors to Christoph (added to CC), since this is his patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
