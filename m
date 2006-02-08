Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWBHEWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWBHEWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBHEWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:22:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63458 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932190AbWBHEWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:22:41 -0500
Date: Tue, 7 Feb 2006 20:21:37 -0800
From: Paul Jackson <pj@sgi.com>
To: Sam Vilain <sam@vilain.net>
Cc: Kevin.Fox@pnl.gov, frankeh@watson.ibm.com, riel@redhat.com,
       ebiederm@xmission.com, dev@openvz.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, kuznet@ms2.inr.ac.ru, saw@sawoct.com,
       devel@openvz.org, dim@sw.ru, ak@suse.de
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
Message-Id: <20060207202137.d5b80c47.pj@sgi.com>
In-Reply-To: <43E94651.2090009@vilain.net>
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net>
	<43E8D160.4040803@watson.ibm.com>
	<43E92602.8040403@vilain.net>
	<1139364483.7169.20.camel@localhost.localdomain>
	<43E94651.2090009@vilain.net>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driving force for cpusets are NUMA architectures.

Cpusets represent the topologies of NUMA systems, with hierarchies
of cabinets, drawers, boards, packages, cores, hyperthreads, and
with chunks of main memory associated usually with the board, but
sometimes a layer or two up or down.

Since not all cpus have the same access performance (delay and
bandwidth) to all memory chunks (nodes), for optimum performance one
wants to bind tasks, cpus and memory together, so as to run tasks on
sets of cpus and memory that are "near" to each other, and to size the
sets appropriately for the workload presented by the tasks.

Cpusets have no explicit awareness of topology; they just provides a
file system style hierarchy of named, permissioned sets, where each set
has:
  mems - the memory nodes in that set
  cpus - the cpus in that set
  tasks - the tasks running on these cpus and mems

For any cpuset, the 'cpus' and 'mems' are a subset of its parent in the
hierarchy, and the root of the hierarchy (usually mounted at /dev/cpuset)
contains all the online cpus and mems in the system.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
