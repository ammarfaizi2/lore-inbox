Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWJRSGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWJRSGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWJRSGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:06:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46732 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161254AbWJRSGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:06:14 -0400
Date: Wed, 18 Oct 2006 11:05:54 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: suresh.b.siddha@intel.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, rohitseth@google.com,
       dipankar@in.ibm.com, nickpiggin@yahoo.com.au
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061018110554.2cace98e.pj@sgi.com>
In-Reply-To: <20061018175458.GC7885@in.ibm.com>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018175458.GC7885@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> I have a patch (though a very old one...) for handling hotplug and cpusets.
> However there were some ugly locking issues and nesting of locks ...

The interaction of cpusets and hotplug should be in good shape.  Look
in kernel/cpuset.c for CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG,
and you will see the two routines to call for cpu and memory hotplug
events, cpuset_handle_cpuhp() and cpuset_track_online_nodes().

The problem area is the interaction of dynamic sched domains and
cpusets with hot plug events.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
