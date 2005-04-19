Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVDSUmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVDSUmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDSUmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:42:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:9880 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261261AbVDSUmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:42:45 -0400
Date: Tue, 19 Apr 2005 13:42:14 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050419134214.6d885229.pj@sgi.com>
In-Reply-To: <20050419095230.GC3963@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<1113891575.5074.46.camel@npiggin-nld.site>
	<20050419095230.GC3963@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> Also I think we can add further restrictions in terms not being able
> to change (add/remove) cpus within a isolated cpuset. Instead one would
> have to tear down an existing cpuset and make a new one with the
> required configuration. that would simplify things even further

My earlier reply to this missed the mark a little.

Instead what I would say is this.  If one wants to move a CPU from one
cpuset to another, where these two cpusets are not in the same
partitioned scheduler domain, then one first has to collapse the
scheduler domain partitions so that both cpusets _are_ in the same
partitioned scheduler domain.  Then one can move the CPU between the two
cpusets, and reestablish the more fine grained partitioned scheduler
domain structure that isolates these two cpusets into different
partitioned scheduler domains.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
