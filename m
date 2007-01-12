Return-Path: <linux-kernel-owner+w=401wt.eu-S1030504AbXALVUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbXALVUZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbXALVUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:20:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55444 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030504AbXALVUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:20:24 -0500
Date: Fri, 12 Jan 2007 13:20:16 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, sander@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 'struct task_struct' has no member named 'mems_allowed'  (was:
 Re: 2.6.20-rc4-mm1)
Message-Id: <20070112132016.f11ffc8a.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701121123410.2296@schroedinger.engr.sgi.com>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	<20070112105224.GA12813@favonius>
	<20070112032820.9c995718.pj@sgi.com>
	<Pine.LNX.4.64.0701121123410.2296@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> +++ linux-2.6.20-rc4-mm1/mm/mempolicy.c	2007-01-12 13:21:30.220968608 -0600
> ...
> +#ifdef CONFIG_CPUSETS

Argh - minor detail, but this is the first (outside of fs/proc/base.c)
"#ifdef CONFIG_CPUSETS" in a kernel *.c file.  I prefer to avoid that.

How about doing this as I suggested in my previous message, like the
other cpuset hooks, with a cpuset_* macro in include/linux/cpuset.h?


This macro would either be the 'nodes_and(...)' code if CPUSETS are
configured, else a no-op.  Say something like ...

	cpuset_restrict_to_current_mems_allowed(nodes);

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
