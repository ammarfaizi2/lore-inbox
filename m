Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269990AbUIDB5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269990AbUIDB5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 21:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270012AbUIDB5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 21:57:53 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:56958 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269990AbUIDB5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 21:57:51 -0400
Message-ID: <41392112.7030206@yahoo.com.au>
Date: Sat, 04 Sep 2004 11:57:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [sched] fix sched_domains hotplug bootstrap ordering vs. cpu_online_map
 issue
References: <1094246465.1712.12.camel@mulgrave> <20040903145925.1e7aedd3.akpm@osdl.org> <20040903222212.GV3106@holomorphy.com> <20040903153434.15719192.akpm@osdl.org> <20040903224507.GX3106@holomorphy.com>
In-Reply-To: <20040903224507.GX3106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> 
>>>This is the whole thing; the "other half" referred to a new hunk added to
>>>the patch (identical to this one) posted in its entirety.
> 
> 
> On Fri, Sep 03, 2004 at 03:34:34PM -0700, Andrew Morton wrote:
> 
>>ho-hum. changelog, please?
> 
> 
> cpu_online_map is not set up at the time of sched domain initialization
> when hotplug cpu paths are used for SMP booting. At this phase of
> bootstrapping, cpu_possible_map can be used by the various
> architectures using cpu hotplugging for SMP bootstrap, but the
> manipulations of cpu_online_map done on behalf of NUMA architectures,
> done indirectly via node_to_cpumask(), can't, because cpu_online_map
> starts depopulated and hasn't yet been populated. On true NUMA
> architectures this is a distinct cpumask_t from cpu_online_map and so
> the unpatched code works on NUMA; on non-NUMA architectures the
> definition of node_to_cpumask() this way breaks and would require an
> invasive sweeping of users of node_to_cpumask() to change it to e.g.
> cpu_possible_map, as cpu_possible_map is not suitable for use at
> runtime as a substitute for cpu_online_map.
> 
> Signed-off-by: William Irwin <wli@holomorphy.com>
> 

Yeah I guess this is probably the best thing to do for now.

Martin, I wonder if this patch fixes your z/VM problem?
