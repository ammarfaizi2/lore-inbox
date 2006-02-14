Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWBNAFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWBNAFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWBNAFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:05:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2308 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030325AbWBNAFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:05:41 -0500
Date: Tue, 14 Feb 2006 01:05:30 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Yoss <bartek@milc.com.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.33-pre1?
Message-ID: <20060214000529.GJ11380@w.ods.org>
References: <20060213214651.GA27844@milc.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213214651.GA27844@milc.com.pl>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 13, 2006 at 10:46:51PM +0100, Yoss wrote:
> Hello.
> My server have lost about ~300MB of RAM. Details:
> 
> webcache:~# uname -a
> Linux webcache 2.4.33-pre1 #2 Wed Feb 8 18:26:44 CET 2006 i686 GNU/Linux
> 
> No other patches. Only basic elements needed to work in network
> enviroment.
> 	
> webcache:~# dmesg | grep MEM
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
> 
> When I count memmory used by processes (column SIZE from ps or RES from
> top) there is about 650MB used. (There is only squid, named and basic
> system deamons running on that host). But:
> 
> webcache:~# free -m
>             total       used       free     shared  buffers    cached
> Mem:         1009        996         13          0       18        32
> -/+ buffers/cache:       945         64
> Swap:        1953          0       1952
> 
> 
> So there is missing about ~300MB.
> If anyone wants to have more detailed info feel free to ask.

You don't have to worry. Simply check /proc/slabinfo, you'll see plenty
of memory used by dentry_cache and inode_cache and that's expected. This
memory will be reclaimed when needed (for instance by calls to malloc()).

If you don't believe me, simply allocate 1 GB in a process, then free it.

Regards,
Willy

