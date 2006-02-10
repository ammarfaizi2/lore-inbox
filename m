Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWBJUcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWBJUcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWBJUcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:32:51 -0500
Received: from mail.tmr.com ([64.65.253.246]:47245 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932179AbWBJUcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:32:50 -0500
Message-ID: <43ECF916.9080001@tmr.com>
Date: Fri, 10 Feb 2006 15:35:34 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gcoady@gmail.com
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.4.32 - Neighbour Cache (ARP) State machine bug Fixed
References: <9fda5f510511281257o364acb3gd634f8e412cd7301@mail.gmail.com> <9fda5f510602031806j2f9ef743t206c9ee2c3bef384@mail.gmail.com> <20060203.181839.104353534.davem@davemloft.net> <9fda5f510602062357n38292cebk3c5738ccdbee83@mail.gmail.com> <20060207215341.GC11380@w.ods.org> <9fda5f510602071750o53f76fc8gc94c280a9998343d@mail.gmail.com> <4skiu150r13a2a78i68bg28cvdb67a8qjb@4ax.com>
In-Reply-To: <4skiu150r13a2a78i68bg28cvdb67a8qjb@4ax.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> On Tue, 7 Feb 2006 17:50:03 -0800, Pradeep Vincent <pradeep.vincent@gmail.com> wrote:
> 
> 
>>One more attempt. Attaching the diff file as well.
>>
>>Signed off by: Pradeep Vincent <pradeep.vincent@gmail.com>
>>
>>--- old/net/core/neighbour.c    Wed Nov  9 16:48:10 2005
>>+++ new/net/core/neighbour.c    Tue Feb  7 17:38:26 2006
>>@@ -14,6 +14,7 @@
>> *     Vitaly E. Lavrov        releasing NULL neighbor in neigh_add.
>> *     Harald Welte            Add neighbour cache statistics like rtstat
>> *     Harald Welte            port neighbour cache rework from 2.6.9-rcX
>>+ *     Pradeep Vincent         fix neighbour cache state machine
>> */
>>
>>#include <linux/config.h>
>>@@ -705,6 +706,13 @@
>>                       neigh_release(n);
>>                       continue;
>>               }
>>+               /* Move to NUD_STALE state */
>>+               if (n->nud_state&NUD_REACHABLE &&
>>+                   now - n->confirmed > n->parms->reachable_time) {
> 
> 
> Hmm, you're suffering tab -> space conversion syndrome :(
> 
> Grant.

The attachment has tabs here, don't know what you're seeing.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
