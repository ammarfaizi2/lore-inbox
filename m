Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVJQGTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVJQGTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 02:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVJQGTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 02:19:35 -0400
Received: from tornado.reub.net ([202.89.145.182]:36492 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751227AbVJQGTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 02:19:34 -0400
Message-ID: <43534273.2050106@reub.net>
Date: Mon, 17 Oct 2005 19:19:31 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051016)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
References: <fa.h4unqgj.l34e31@ifi.uio.no>
In-Reply-To: <fa.h4unqgj.l34e31@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/10/2005 10:42 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> 
> - Lots of i2c, PCI and USB updates
> 
> - Large input layer update to convert it all to dynamic input_dev allocation
> 
> - Significant x86_64 updates
> 
> - MD updates
> 
> - Lots of core memory management scalability rework

Compiles and runs here, but noting these messages when ethernet link down:

Oct 17 18:49:40 tornado kernel: NEIGH: BUG, double timer add, state is 1
Oct 17 18:51:04 tornado last message repeated 3 times
Oct 17 18:52:05 tornado last message repeated 5 times
Oct 17 18:52:11 tornado last message repeated 2 times

net/core/neighbour.c has this:

static inline void neigh_add_timer(struct neighbour *n, unsigned long when)
{
         if (unlikely(mod_timer(&n->timer, when))) {
                 printk("NEIGH: BUG, double timer add, state is %x\n",
                        n->nud_state);
         }
}


Network guys?

reuben
