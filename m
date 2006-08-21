Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWHUXF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWHUXF5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWHUXF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:05:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58053 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751277AbWHUXFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:05:55 -0400
Date: Mon, 21 Aug 2006 16:04:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: anton@samba.org, simon.derr@bull.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] cpuset code prevents binding tasks to new cpus
Message-Id: <20060821160454.9e44427b.pj@sgi.com>
In-Reply-To: <20060821204251.GB9828@localdomain>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821204251.GB9828@localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> -	top_cpuset.cpus_allowed = cpu_online_map;
> +	top_cpuset.cpus_allowed = cpu_possible_map;

NAQ

While this seems sensible on systems not using cpusets (but still using
kernels configured for cpusets), it is surprising on systems using
cpusets, on which one expects the cpuset that a task is in to reflect
the cpus that a task is allowed to use.

A long time ago, this code actually had cpu_possible_map here, not
cpu_online_map.  That was changed, in the patch:

  http://lkml.org/lkml/2004/9/12/104
  [Patch] cpusets interoperate with hotplug online maps

Lets discuss this further.  See further my previous reply to Anton.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
