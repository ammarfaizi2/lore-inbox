Return-Path: <linux-kernel-owner+w=401wt.eu-S1422665AbXAMNQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbXAMNQH (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 08:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbXAMNQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 08:16:07 -0500
Received: from a80-100-32-23.adsl.xs4all.nl ([80.100.32.23]:39262 "EHLO
	mail.vanvergehaald.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422665AbXAMNQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 08:16:06 -0500
Date: Sat, 13 Jan 2007 14:16:01 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Willy Tarreau <w@1wt.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: tuning/tweaking VM settings for low memory (preventing OOM)
Message-ID: <20070113131601.GA12901@shuttle.vanvergehaald.nl>
References: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org> <20070113072217.GW24090@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113072217.GW24090@1wt.eu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 08:22:18AM +0100, Willy Tarreau wrote:
> > 
> > Which makes me think that we aren't writing back fast enough.  If I  
> > mount the drive "sync" the issue clearly goes away.
> > 
> > It appears from an strace we are doing ftruncate64(5, 178257920) when  
> > we OOM.
> > 
> > Any ideas on VM parameters to tweak so we throttle this from occurring?
> 
> Take a look at /proc/sys/vm/bdflush. There are several useful parameters
> there (doc is in linux-xxx/Documentation). For instance, the first column
> is the percentage of memory used by writes before starting to write on
> disk. When using tcpdump intensively, I lower this one to about 1%.
> 
> Willy

Hi Willy,

I know you're doing a great job on keeping the 2.4 kernel in shape,
but do you also have a good advice for people with more recent
kernels?  (hint: the file /proc/sys/vm/bdflush is missing)

Regards,
Toon.

$ uname -a
Linux shuttle 2.6.18-gentoo-r6 #1 Sat Jan 13 12:00:15 CET 2007 x86_64 AMD Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux
$ ls -l /proc/sys/vm/
totaal 0
-rw-r--r-- 1 root root 0 jan 13 14:09 block_dump
-rw-r--r-- 1 root root 0 jan 13 14:09 dirty_background_ratio
-rw-r--r-- 1 root root 0 jan 13 14:09 dirty_expire_centisecs
-rw-r--r-- 1 root root 0 jan 13 14:09 dirty_ratio
-rw-r--r-- 1 root root 0 jan 13 14:09 dirty_writeback_centisecs
-rw-r--r-- 1 root root 0 jan 13 14:09 drop_caches
-rw-r--r-- 1 root root 0 jan 13 14:09 hugetlb_shm_group
-rw-r--r-- 1 root root 0 jan 13 14:09 laptop_mode
-rw-r--r-- 1 root root 0 jan 13 14:09 legacy_va_layout
-rw-r--r-- 1 root root 0 jan 13 14:09 lowmem_reserve_ratio
-rw-r--r-- 1 root root 0 jan 13 14:09 max_map_count
-rw-r--r-- 1 root root 0 jan 13 14:09 min_free_kbytes
-rw-r--r-- 1 root root 0 jan 13 14:09 nr_hugepages
-r--r--r-- 1 root root 0 jan 13 14:09 nr_pdflush_threads
-rw-r--r-- 1 root root 0 jan 13 14:09 overcommit_memory
-rw-r--r-- 1 root root 0 jan 13 14:09 overcommit_ratio
-rw-r--r-- 1 root root 0 jan 13 14:09 page-cluster
-rw-r--r-- 1 root root 0 jan 13 14:09 panic_on_oom
-rw-r--r-- 1 root root 0 jan 13 14:09 percpu_pagelist_fraction
-rw-r--r-- 1 root root 0 jan 13 14:09 swappiness
-rw-r--r-- 1 root root 0 jan 13 14:09 swap_token_timeout
-rw-r--r-- 1 root root 0 jan 13 14:09 vfs_cache_pressure
