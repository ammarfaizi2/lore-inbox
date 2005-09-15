Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVIOHDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVIOHDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVIOHDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:03:54 -0400
Received: from [210.76.114.20] ([210.76.114.20]:24210 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1030442AbVIOHDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:03:53 -0400
Message-ID: <43291CCF.4010902@ccoss.com.cn>
Date: Thu, 15 Sep 2005 15:03:43 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Question about page allocation failure
References: <432914F1.4090001@rentalia.com>
In-Reply-To: <432914F1.4090001@rentalia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the related code is here:

        /* This allocation should allow future memory freeing. */
 
        if (((p->flags & PF_MEMALLOC) || 
unlikely(test_thread_flag(TIF_MEMDIE)))
                        && !in_interrupt()) {
                if (!(gfp_mask & __GFP_NOMEMALLOC)) {
                        /* go through the zonelist yet again, ignoring 
mins */
                        for (i = 0; (z = zones[i]) != NULL; i++) {
                                if (!cpuset_zone_allowed(z))
                                        continue;
                                page = buffered_rmqueue(z, order, gfp_mask);
                                if (page)
                                        goto got_pg;
                        }
                }
                goto nopage;
        }
 
        /* Atomic allocations - we can't balance anything */
        if (!wait)
                goto nopage;
                                                                                                    

nopage:
        if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
                printk(KERN_WARNING "%s: page allocation failure."
                        " order:%d, mode:0x%x\n",
                        p->comm, order, gfp_mask);
                dump_stack();
        }
        return NULL;



if we are in normal case, there have two possbiles:
    1. total of memory  is too low.
    2. /* Atomic allocations - we can't balance anything */

I think this is not too dangerous.

PS: I use 2.6.12.

Any more clear idea?


sailor



nopage:
   
