Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUHDXp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUHDXp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUHDXpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:45:16 -0400
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:47007 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S267514AbUHDXoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:44:10 -0400
Message-ID: <411174C6.2020109@bigpond.net.au>
Date: Thu, 05 Aug 2004 09:44:06 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
References: <6560000.1091632215@[10.10.2.4]> <7480000.1091632378@[10.10.2.4]> <20040804122414.4f8649df.akpm@osdl.org>
In-Reply-To: <20040804122414.4f8649df.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> 
>>SDET 8  (see disclaimer)
>>                            Throughput    Std. Dev
>>                     2.6.7       100.0%         0.2%
>>                 2.6.8-rc2       100.2%         1.0%
>>             2.6.8-rc2-mm2       117.4%         0.9%
>>
>> SDET 16  (see disclaimer)
>>                            Throughput    Std. Dev
>>                     2.6.7       100.0%         0.3%
>>                 2.6.8-rc2        99.5%         0.3%
>>             2.6.8-rc2-mm2       118.5%         0.6%
> 
> 
> hum, interesting.  Can Con's changes affect the inter-node and inter-cpu
> balancing decisions, or is this all due to caching effects, reduced context
> switching etc?

One candidate for the cause of this improvement is the replacement of 
the active/expired array mechanism with a single array.  I believe that 
one of the short comings of the active/expired array mechanism is that 
it can lead to excessive queuing (possibly even starvation) of tasks 
that aren't considered "interactive".

> 
> I don't expect we'll be merging a new CPU scheduler into mainline any time
> soon, but we should work to understand where this improvement came from,
> and see if we can get the mainline scheduler to catch up.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

