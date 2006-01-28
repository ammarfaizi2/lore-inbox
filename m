Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWA1DOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWA1DOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWA1DOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:14:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63158 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751380AbWA1DOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:14:11 -0500
Date: Fri, 27 Jan 2006 19:14:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Jack Steiner <steiner@sgi.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-Id: <20060127191400.aacb8539.pj@sgi.com>
In-Reply-To: <20060127230659.GA4752@sgi.com>
References: <20060127230659.GA4752@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack wrote:
> Should the following change be made to sched_getaffinity(). 
> 
> Index: linux/kernel/sched.c
> ===================================================================
> --- linux.orig/kernel/sched.c	2006-01-25 08:50:21.401747695 -0600
> +++ linux/kernel/sched.c	2006-01-27 16:57:24.504871895 -0600
> @@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
>  		goto out_unlock;
>  
>  	retval = 0;
> -	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
> +	cpus_and(*mask, p->cpus_allowed, cpu_online_map);

Adding Robert Love to the cc list, as he is Mr. sched_getaffinity,
I believe.

I ended up doing a similar change, to the cpus (and mems) masks
in the root (all encompassing) cpuset.  These now show the values
of cpu_online_map and node_online_map, not *_MASK_ALL.

My hunches are:
 * This change to cpu_online_map is a good one.
 * The man page sentence "Usually, all bits in the mask are set."
   might have meant something when it was written, but it is not
   now clear what.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
