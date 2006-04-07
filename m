Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWDGOmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWDGOmr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWDGOmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:42:46 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:32647 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932355AbWDGOmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:42:45 -0400
Subject: Re: [Patch] Change interface of add/remove_memory() from paddr to
	pfn
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060404135636.ED23.Y-GOTO@jp.fujitsu.com>
References: <20060404135636.ED23.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 07:41:56 -0700
Message-Id: <1144420916.9731.208.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-04 at 14:06 +0900, Yasunori Goto wrote:
> This patch is to change interfaces of add/remove_memory()
> from physicall address to pfn.
> Current add_memory() of each architecture changes paddr to pfn,
> and __add_pages() are called by pfn after all.
> So, it is not for un-alignment memory.
> Using pfn is a bit better to avoid misunderstanding to use add_memory().
> 
> In addition, this patch reduces a few lines of kernel.
> (Unfortunately, x86-64 and powerpc look using paddr for some
>  reasons.)

Sorry for the horribly late response.  I've been without email since
shortly before you sent this.

I don't have a horribly serious problem with this patch, but I would
prefer that it not go in.

I really wanted to have a uniform, easily understood interface for each
of the firmware drivers which will do memory hotplug.  As far as I have
seen, they almost exclusively deal in physical addresses.

I just think that keeping the interfaces at u64 is a _clearer_
interface, although it does cost a few shifts in each implementation.  I
would have less of a problem with something like
__add_memory_pfn_range() that sits under add_memory() where and the
architectures only implement *it*.  

-- Dave

