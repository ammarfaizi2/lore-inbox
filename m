Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVJUHr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVJUHr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVJUHr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:47:56 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:13783 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964899AbVJUHrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:47:55 -0400
Message-ID: <43589CF0.5050609@jp.fujitsu.com>
Date: Fri, 21 Oct 2005 16:46:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Simon Derr <Simon.Derr@bull.net>
CC: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com> <4358588D.1080307@jp.fujitsu.com> <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr> <435896CA.1000101@jp.fujitsu.com> <Pine.LNX.4.61.0510210927140.17098@openx3.frec.bull.fr>
In-Reply-To: <Pine.LNX.4.61.0510210927140.17098@openx3.frec.bull.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Derr wrote:
>>>Christoph Lameter wrote:
>>>>>>+	/* Is the user allowed to access the target nodes? */
>>>>>>+	if (!nodes_subset(new, cpuset_mems_allowed(task)))
>>>>>>+		return -EPERM;
>>>>>>+
>>>
>>>>How about this ?
>>>>+cpuset_update_task_mems_allowed(task, new);    (this isn't implemented
>>>>now
>>
>>*new* is already guaranteed to be the subset of current mem_allowed.
>>Is this violate the permission ?
> 
> 
> Oh, I misunderstood your mail.
> I thought you wanted to automatically add extra nodes to the cpuset,
> but you actually want to do just the opposite, i.e restrict the nodemask 
> for this task to the one passed to sys_migrate_pages(). Is that right ?
> 
yes.
Anyway, we should modify task's mem_allowed before the first page fault.

-- Kame


