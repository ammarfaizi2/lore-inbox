Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWITTf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWITTf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWITTf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:35:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:48592 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932308AbWITTf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:35:26 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Menage <menage@google.com>
Cc: npiggin@suse.de, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       Rohit Seth <rohitseth@google.com>, devel@openvz.org,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 12:35:23 -0700
Message-Id: <1158780923.6536.110.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 12:25 -0700, Paul Menage wrote:
> On 9/20/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > We had this discussion more than 18 months back and concluded that it is
> > not the right thing to do. Here is the link to the thread:
> 
> Even if the resource control portions aren't totally compatible,
> having two separate process container abstractions in the kernel is
> sub-optimal, both in terms of efficiency and userspace management. How
> about splitting out the container portions of cpuset from the actual
> resource control, so that CKRM/RG can hang off of it too? Creation of
> a cpuset or a resource group would be driven by creation of a
> container; at fork time, a task inherits its parent's container, and
> hence its cpuset and/or resource groups.
> 
> At its most crude, this could be something like:
> 
> struct container {
> #ifdef CONFIG_CPUSETS
>   struct cpuset cs;
> #endif
> #ifdef CONFIG_RES_GROUPS
>   struct resource_group rg;
> #endif
> };

Won't it restrict the user to choose one of these, and not both.

It will also prevent the possibility of having resource groups within a
cpuset.

> 
> but at least it would be sharing some of the abstractions.
> 
> Paul
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


