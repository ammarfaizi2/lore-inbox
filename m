Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVAXLtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVAXLtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 06:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVAXLtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:49:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:530 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261500AbVAXLtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:49:01 -0500
Date: Mon, 24 Jan 2005 11:48:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, alexn@dsv.su.se,
       kas@fi.muni.cz, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050124114853.A16971@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen> <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org> <20050123200315.A25351@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050123200315.A25351@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Jan 23, 2005 at 08:03:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 08:03:15PM +0000, Russell King wrote:
> I think I may be seeing something odd here, maybe a possible memory leak.
> The only problem I have is wondering whether I'm actually comparing like
> with like.  Maybe some networking people can provide a hint?
> 
> Below is gathered from 2.6.11-rc1.
> 
> bash-2.05a# head -n2 /proc/slabinfo
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>
> bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
> 115
> ip_dst_cache         759    885    256   15    1
> bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
> 117
> ip_dst_cache         770    885    256   15    1
> bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
> 133
> ip_dst_cache         775    885    256   15    1
> bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
> 18
> ip_dst_cache         664    885    256   15    1
>...
> bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
> 24
> ip_dst_cache         675    885    256   15    1
> bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
> 24
> ip_dst_cache         669    885    256   15    1
> 
> I'm fairly positive when I rebooted the machine a couple of days ago,
> ip_dst_cache was significantly smaller for the same number of lines in
> /proc/net/rt_cache.

FYI, today it looks like this:

bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
26
ip_dst_cache         820   1065    256   15    1 

So the dst cache seems to have grown by 151 in 16 hours...  I'll continue
monitoring and providing updates.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
