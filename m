Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUCLKR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUCLKR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:17:27 -0500
Received: from mx02.qsc.de ([213.148.130.14]:46474 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S261844AbUCLKRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:17:10 -0500
Message-ID: <40518CDC.7090805@trash.net>
Date: Fri, 12 Mar 2004 11:11:40 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ron Peterson <rpeterso@mtholyoke.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: network/performance problem
References: <20040311152728.GA11472@mtholyoke.edu> <20040311151559.72706624.akpm@osdl.org> <20040311233525.GA14065@mtholyoke.edu>
In-Reply-To: <20040311233525.GA14065@mtholyoke.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Peterson wrote:
> On Thu, Mar 11, 2004 at 03:15:59PM -0800, Andrew Morton wrote:
>>The profiles tell a story:
>>
>>c0217fb0 wait_for_packet                               2   0.0063
>>c0256660 arpt_do_table                                 2   0.0019
>>c0265ca0 __generic_copy_to_user                        2   0.0278
>>c0106bd0 system_call                                   3   0.0536
>>c0107e8c handle_IRQ_event                              3   0.0326
>>c014bf10 statm_pgd_range                               3   0.0077
>>c0120ed4 do_wp_page                                    5   0.0101
>>c024c0d4 ip_conntrack_expect_related                  47   0.0368
>>c0105250 default_idle                               2817  70.4250
>>c024bae0 init_conntrack                             3053   3.7232
>>00000000 total                                      5962   0.0041
>>
>>It appears that netfilter has gone berzerk and is taking your machine out.
>>
>>Are you really sure that nothing is sitting there injecting new rules all
>>the time?
> 
> 
> You mean a script calling 'iptables' to dynamically add rules?  Nothing
> like that at all.  I dumped the current rules below.
> 
> Are you looking at the init_conntrack numbers?  While they seem, in the
> long run, to be getting larger, they're not increasing monotonically.
> My ping latencies, and the CPU percentage consumed by ksoftirqd_CPU0
> just go up and and up (albeit slowly).
> 

The size-128 slab keeps growing over time, I suspect something is
registering lots of expectations. init_conntrack has to walk the
entire list for each new connection. Which helpers are you using ?
Please also post the content of /proc/net/ip_conntrack and your
config.

Regards
Patrick
