Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVJUHWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVJUHWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVJUHWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:22:10 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36553 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964892AbVJUHWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:22:09 -0400
Message-ID: <435896CA.1000101@jp.fujitsu.com>
Date: Fri, 21 Oct 2005 16:20:42 +0900
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
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com> <4358588D.1080307@jp.fujitsu.com> <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
In-Reply-To: <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Christoph Lameter wrote:
> 
>>> > +	/* Is the user allowed to access the target nodes? */
>>> > +	if (!nodes_subset(new, cpuset_mems_allowed(task)))
>>> > +		return -EPERM;
>>> > +
> 
>> How about this ?
>> +cpuset_update_task_mems_allowed(task, new);    (this isn't implemented now

*new* is already guaranteed to be the subset of current mem_allowed.
Is this violate the permission ?

Simon Derr wrote:
> Automatically updating the ->mems_allowed field as you suggest would 
> require that the kernel do the same checks in sys_migrage_pages(). Sounds 
> not as a very good idea to me.

Hmm, it means a user or admin should modify mem_allowed
before the first page fault after calling sys_migrate_pages().

-- Kame


