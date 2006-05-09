Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWEIMvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWEIMvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWEIMvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:51:23 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:11376 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932295AbWEIMvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:51:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KCitAywvBxa1zXe9FQf/pNy7+t+be4DL3bnK4/s4UjtHNxXqK+koVFiX3q08hkkWAVYYTvPle5UrBxq0jEjRmzw/0YsfZrALBEjvvMkNCOWfh5k0KvFl3r0/zvgPNAeWdoN9yipNArA+40fGAWJl/lb3FUr4maT3lbHIhxVwHTw=  ;
Message-ID: <446050BC.5070608@yahoo.com.au>
Date: Tue, 09 May 2006 18:20:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org> <20060509035320.GC784@in.ibm.com> <44601933.2040905@yahoo.com.au> <20060509054556.GG784@in.ibm.com> <44602F32.1060909@yahoo.com.au> <20060509080638.GB11533@in.ibm.com>
In-Reply-To: <20060509080638.GB11533@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

>On Tue, May 09, 2006 at 03:57:06PM +1000, Nick Piggin wrote:
>
>>Well they'll be _collecting_ the stats, yes. Will they really be using
>>them for anything?
>>
>
>Hmm.. No, the statistics are sent down using the netlink interface
>to listeners on the netlink group (on every task exit) or to the task that
>actually requested for the delay accounting data.
>
>The stats are currently gathered in kernel and used by user space.
>

So... what are the consumers of this data going to be? That is my question.

>>If you make the whole thing much lighter weight for tasks which aren't
>>using the accounting, you have a better chance of people turning the
>>CONFIG option on.
>>
>>
>
>I am not sure I understand the point completely. Are you suggesting that
>struct task_delay_info be moved to common data structure as an aggregate
>containing all the delay stats data?
>

My suggestion is basically this: if the accounting is going to be used
infrequently, it might be a good idea to allocate the accounting structures
on demand, and only perform the accounting when these structures are
allocated.

It all adds up. Extra cache misses, more icache, more logic, etc... I 
suspect
that relatively few people will care about these stats.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
