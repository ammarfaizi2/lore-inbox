Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVJZAGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVJZAGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVJZAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:06:46 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:40387 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932497AbVJZAGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:06:46 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andi Kleen <ak@suse.de>
Cc: Jonas Oreland <jonas@mysql.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       discuss@x86-64.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <200510250942.25973.ak@suse.de>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <434BE7E9.8000501@mysql.com> <435DE042.9060208@mysql.com> <200510250942.25973.ak@suse.de>
Date: Tue, 25 Oct 2005 17:05:54 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: x86-64: Syncing dualcore cpus TSCs
In-Reply-To: <200510250942.25973.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0510251701290.9116@qynat.qvtvafvgr.pbz>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
 <434BE7E9.8000501@mysql.com> <435DE042.9060208@mysql.com> <200510250942.25973.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2005, Andi Kleen wrote:

> On Tuesday 25 October 2005 09:35, Jonas Oreland wrote:
>> Hi,
>>
>> This might be a very bad suggestion, but here it is:
>>
>> On dualcore cpus (amd64) the TSC will get out of sync when executing hlt
>> instruction. booting with idle=poll, will make it never to execute hlt,
>> hence TSC will be in sync. booting with notsc will make it use other time
>> source...but this is slower (this is default after "[PATCH] x86-64: Fix bad
>> assumption that dualcore cpus have synced TSCs")
>>
>> How about syncing TSC after hlt?
>>
>> If cost of syncing TSC's is smaller than cost of using other time source
>> this might be an alternative.
>
> I very doubt it is. Syncing TSCs requires stopping multiple CPUs for longer
> time. It is unlikely you can make that up.

I may be misunderstanding things, but as I understand it the reason for 
calling hlt is to save power.

if you really care about the last bit of performance then useing idle=poll 
to make the TSC's stay synced makes perfect sense.

it's cases where you care about saving power that you would want to use 
hlt. can the power management be reasonably configured so that when things 
are running close to full-bore hlt isn't called, when things are more idle 
it switches to useing hlt and a non-TSC timesource or re-syncing the TSC 
on wakeup, and then if it's more idle then that it goes into the more 
traditional power saving modes where it works to shutdown individual CPU's 
(obviously having to re-sync the TSC when they wake up).

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
