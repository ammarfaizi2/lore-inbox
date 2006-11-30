Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759002AbWK3ENY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759002AbWK3ENY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759003AbWK3ENY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:13:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46754 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1759001AbWK3ENX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:13:23 -0500
Date: Wed, 29 Nov 2006 20:13:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Felix Obenhuber <felix@obenhuber.de>
Cc: linux-kernel@vger.kernel.org, dynsched-devel@lists.sourceforge.net,
       menage@google.com
Subject: Re: [RFC] dynsched - different cpu schedulers per cpuset
Message-Id: <20061129201310.54da1618.pj@sgi.com>
In-Reply-To: <1164557189.10306.12.camel@athrose>
References: <1164557189.10306.12.camel@athrose>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix wrote:
> The cpu<->scheduler mapping is controlled via cpusets. Thus you
> can switch the scheduler for a cpuset containing multiple cpus and
> keep the rest untouched.

I don't have comments on the main focus of this work - schedulers are
not my expertise.

I just noticed this lkml post because of my interest in cpusets.

You should take a look at the work of Paul Menage (added to the
cc list), who is splitting the cpuset code into:
 1) a generic "container" mechanism,
 2) separate CPU and Memory "controllers", and
 3) various other additional "controllers".

See Paul Menage's most recent patch proposal at:
  http://lkml.org/lkml/2006/11/17/217
  Subject: [PATCH 0/6] Multi-hierarchy Process Containers
  Date:    Fri, 17 Nov 2006 11:11:59 -0800

The container mechanism uses a virtual file system derived from
the cpuset code to provide a file system style (hierarchical names
and classic Unix style file and directory permissions) naming of a
partitioning of the tasks on a system.

By partitioning here, I mean a division of the tasks into several
subsets, aka partition elements, which are non-overlapping and covering.

That is, each task is in one and only one of the partition elements,
these partitions elements are named by the directories in the container
file system, and the regular files in the container file system provide
per-element attributes.

Then kernel facilities that can be considered as providing attributes
for and control of subsets of tasks is represented as a controller,
and attached to such a container.

Your dynamic scheduler mechanisms appear (from what I can tell after a
brief glance) to be a candidate for being such a controller.

The upshot of this is that, if your work should proceed and eventually
be considered for inclusion in the kernel (I have --no-- idea if that
would be a good idea, either for the purposes of your student group,
or for the kernel itself) then it would likely (if Menage's work
is accepted) need to be recast as a "controller" in Menage's terms,
not as an extension to cpusets.

If Menage succeeds, that should not actually be that big of a change,
either semantically, or in coding details.

Good luck.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
