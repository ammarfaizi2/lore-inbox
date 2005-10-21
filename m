Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVJUC4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVJUC4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 22:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVJUC4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 22:56:30 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:60035 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964846AbVJUC43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 22:56:29 -0400
Message-ID: <4358588D.1080307@jp.fujitsu.com>
Date: Fri, 21 Oct 2005 11:55:09 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Lameter wrote:
> +	/* Is the user allowed to access the target nodes? */
> +	if (!nodes_subset(new, cpuset_mems_allowed(task)))
> +		return -EPERM;
> +
How about this ?
+cpuset_update_task_mems_allowed(task, new);    (this isn't implemented now)

> +	err = do_migrate_pages(mm, &old, &new, MPOL_MF_MOVE);
> +

or it's user's responsibility  to updates his mempolicy before
calling sys_migrage_pages() ?

-- Kame


