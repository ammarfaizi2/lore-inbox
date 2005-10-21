Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbVJUHjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbVJUHjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVJUHjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:39:37 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:12446 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964896AbVJUHjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:39:36 -0400
Date: Fri, 21 Oct 2005 09:39:17 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
In-Reply-To: <435896CA.1000101@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.61.0510210927140.17098@openx3.frec.bull.fr>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
 <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
 <4358588D.1080307@jp.fujitsu.com> <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
 <435896CA.1000101@jp.fujitsu.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/10/2005 09:53:17,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/10/2005 09:53:19,
	Serialize complete at 21/10/2005 09:53:19
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2005, KAMEZAWA Hiroyuki wrote:

> 
> 
> > Christoph Lameter wrote:
> > 
> > > > > +	/* Is the user allowed to access the target nodes? */
> > > > > +	if (!nodes_subset(new, cpuset_mems_allowed(task)))
> > > > > +		return -EPERM;
> > > > > +
> > 
> > > How about this ?
> > > +cpuset_update_task_mems_allowed(task, new);    (this isn't implemented
> > > now
> 
> *new* is already guaranteed to be the subset of current mem_allowed.
> Is this violate the permission ?

Oh, I misunderstood your mail.
I thought you wanted to automatically add extra nodes to the cpuset,
but you actually want to do just the opposite, i.e restrict the nodemask 
for this task to the one passed to sys_migrate_pages(). Is that right ?

(If not, ignore the rest of this message)

Maybe sometimes the user would be interested in migrating all the 
existing pages of a process, but not change the policy for the future ?

	Simon.

