Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWBFIgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWBFIgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWBFIgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:36:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64151 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750773AbWBFIgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:36:16 -0500
Date: Mon, 6 Feb 2006 00:35:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206003557.87872264.pj@sgi.com>
In-Reply-To: <20060206073938.GA24366@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060205203711.2c855971.akpm@osdl.org>
	<20060205225629.5d887661.pj@sgi.com>
	<20060205230816.4ae6b6e2.akpm@osdl.org>
	<20060206073938.GA24366@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> if we want to reduce complexity, i'd suggest to consolidate the MPOL_* 
> mechanism into cpusets, and phase out the mempolicy syscalls. (The sysfs 
> interface to cpusets is much cleaner anyway.)

I think that there is an essential place for both interfaces.

Individual tasks need to be able to micromanage their memory placement
and (with sched_setaffinity) cpu scheduling.  For instance, the cpuset
interface would be ill equipped to express the virtual address-range
placement that the mbind(2) system call can express.

Also the cpuset interface affects all tasks equally that are in that
cpuset, which is simply not enough.  Individual threads have their own
special needs, which they are prepared to express in code.

We might have details of the mempolicy system calls that we don't like;
I've complained about such myself in times long past.  But it is quite
servicable, and the API details are probably better left as they are.
Incompatible changes would cause more problems than we fixed. 

The two separate interfaces really do fit the end-usage pattern
rather well.  We have cpusets for the sysadmins and batch schedulers,
and we have the schedaffinity and mempolicy system calls for the
applications.

I will grant that it's a pleasure, after all these years, to be
arguing that "we need mempolicy too", rather than arguing "we
need cpusets in addition."

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
