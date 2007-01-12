Return-Path: <linux-kernel-owner+w=401wt.eu-S1161053AbXALVZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbXALVZ0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbXALVZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:25:26 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56054 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161006AbXALVZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:25:25 -0500
Date: Fri, 12 Jan 2007 13:25:13 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, apw@shadowen.org, clameter@engr.sgi.com,
       mm-commits@vger.kernel.org
Subject: Re: - sys_mbind-use-cpuset-accessors-for-mems_allowed.patch removed
 from -mm tree
Message-Id: <20070112132513.a14e7e70.pj@sgi.com>
In-Reply-To: <200701122039.l0CKdTiP028254@shell0.pdx.osdl.net>
References: <200701122039.l0CKdTiP028254@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, regarding a patch by Andy:
> +	nodemask_t allowed_nodes;
>  
>  	err = get_nodes(&nodes, nmask, maxnode);
> -	nodes_and(nodes, nodes, current->mems_allowed);
> +	allowed_nodes = cpuset_mems_allowed(current);

Not that it matters now, as we're messing with other variations,
but I notice that the above is (1) better looking than having an
#ifdef, (2) better than being broken in the NUMA yes, CPUSETS no,
config, but (3) burdens this code with another nodemask and
nodes_and() op, even in the case that CPUSETS are not configured.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
