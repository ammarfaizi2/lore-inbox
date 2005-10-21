Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVJUHHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVJUHHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVJUHHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:07:34 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:41883 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964889AbVJUHHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:07:34 -0400
Date: Fri, 21 Oct 2005 09:07:04 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
In-Reply-To: <4358588D.1080307@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
 <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
 <4358588D.1080307@jp.fujitsu.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/10/2005 09:21:07,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/10/2005 09:21:19,
	Serialize complete at 21/10/2005 09:21:19
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2005, KAMEZAWA Hiroyuki wrote:

> 
> Christoph Lameter wrote:
> > +	/* Is the user allowed to access the target nodes? */
> > +	if (!nodes_subset(new, cpuset_mems_allowed(task)))
> > +		return -EPERM;
> > +
> How about this ?
> +cpuset_update_task_mems_allowed(task, new);    (this isn't implemented now)
> 
> > +	err = do_migrate_pages(mm, &old, &new, MPOL_MF_MOVE);
> > +
> 
> or it's user's responsibility  to updates his mempolicy before
> calling sys_migrage_pages() ?
> 

The user cannot always add a memory node to a cpuset, for example if this 
cpuset is inside another cpuset that is owned by another user. (i.e the 
case where the administrator wants to dedicate a part of the machine to a 
user).

The kernel checks for these permission issues, conflicts with other 
mem_exclusive cpusets, etc... when you write in the 'mems' file.

Automatically updating the ->mems_allowed field as you suggest would 
require that the kernel do the same checks in sys_migrage_pages(). Sounds 
not as a very good idea to me.

	Simon.

