Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVILNP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVILNP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVILNP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:15:28 -0400
Received: from tornado.reub.net ([202.89.145.182]:17110 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750815AbVILNP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:15:28 -0400
Message-ID: <43257F6A.5060304@reub.net>
Date: Tue, 13 Sep 2005 01:15:22 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.13-mm3
References: <20050912024350.60e89eb1.akpm@osdl.org>
In-Reply-To: <20050912024350.60e89eb1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/09/2005 9:43 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm3/
> 
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm3.gz)
> 
> - perfctr was dropped.  Mikael has ceased development and recommends that
>   the focus be upon perfmon.  See
>   http://sourceforge.net/mailarchive/forum.php?thread_id=8102899&forum_id=2237
> 
> - There are several performance tuning patches here which need careful
>   attention and testing.  (Does anyone do performance testing any more?)
> 
>   - An update to the anticipatory scheduler to fix a performance problem
>     where processes do a single read then exit, in the presence of competing
>     I/O acticity.
> 
>   - The size of the page allocator per-cpu magazines has been increased
> 
>   - The page allocator has been changed to use higher-order allocations
>     when batch-loading the per-cpu magazines.  This is intended to give
>     improved cache colouring effects however it might have the downside of
>     causing extra page allocator fragmentation.
> 
>   - The page allocator's per-cpu magazines have had their lower threshold
>     set to zero.  And we can't remember why it ever had a lower threshold.
> 
> - Dropped all the virtualisation preparatory patches.  Will later pick these
>   up from a git tree which chrisw is running.
> 
> - There are still quite a few patches here for 2.6.14 (30-50, perhaps).

-mm2 and -mm3 seem good, at least compile and boot up :)

However for both, I'm seeing this when making modules_install:

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map 
2.6.13-mm3; fi
WARNING: /lib/modules/2.6.13-mm3/kernel/net/ipv6/netfilter/ip6t_NFQUEUE.ko 
needs unknown symbol ip6t_unregister_target
WARNING: /lib/modules/2.6.13-mm3/kernel/net/ipv6/netfilter/ip6t_NFQUEUE.ko 
needs unknown symbol ip6t_register_target
[root@tornado linux-2.6]#

Seems to be caused by this option in .config set to 'm':

<M>   Netfilter NFQUEUE over NFNETLINK interface
Symbol: NETFILTER_NETLINK_QUEUE [=m]
Prompt: Netfilter NFQUEUE over NFNETLINK interface
Defined at net/netfilter/Kconfig:7

Full .config up at http://www.reub.net/kernel/2.6.13-mm3-config.

I suspect there is a dependency here on ip6_tables, which I am not currently 
compiling in or building as a module?

reuben
