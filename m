Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWHYIyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWHYIyW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWHYIyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:54:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56528 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751263AbWHYIyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:54:21 -0400
Date: Fri, 25 Aug 2006 01:53:59 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, simon.derr@bull.net,
       nathanl@austin.ibm.com, akpm@osdl.org
Subject: memory hotplug - looking for good place for cpuset hook
Message-Id: <20060825015359.1c9eab45.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

I'm looking for a good place to add yet another cpuset hook, this
one to keep a nodemask in my top (root) cpuset always equal to the
current value of node_online_map.

The motivation for this, if you're interested, comes from the
following threads, which added similar cpuset tracking of the
cpu_online_map:

  cpusets not cpu hotplug aware
  http://lkml.org/lkml/2006/8/21/128

  [PATCH] cpuset: top_cpuset tracks hotplug changes to cpu_online_map
  http://lkml.org/lkml/2006/8/24/107

(I cc'd the victims of these threads here, in case they're interested.)

>From what I see so far, the right place to call my cpuset routine to
update its copy of node_online_map would be right after the call:

	node_set_online(nid);

in the routine mm/memory_hotplug.c:add_memory().

Does that seem like a plausible sounding place to you?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
