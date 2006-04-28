Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWD1R5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWD1R5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWD1R5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:57:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:17370 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751769AbWD1R5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:57:18 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <4451B122.1010206@sw.ru>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	 <1145630992.3373.6.camel@localhost.localdomain>
	 <1145638722.14804.0.camel@linuxchandra>
	 <20060421155727.4212c41c.akpm@osdl.org>
	 <1145670536.15389.132.camel@linuxchandra>
	 <20060421191340.0b218c81.akpm@osdl.org>
	 <1146189505.24650.221.camel@linuxchandra>  <4451B122.1010206@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Fri, 28 Apr 2006 10:57:14 -0700
Message-Id: <1146247034.7063.10.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 10:07 +0400, Kirill Korotaev wrote:
> >>Worried.
> > The object of this infrastructure is to get a unified interface for
> > resource management, irrespective of the resource that is being managed.
> > 
> > As I mentioned in my earlier email, subsystem experts are the ones who
> > will finally decide what type resource controller they will accept. With
> > VM experts' direction and advice, i am positive that we will get an
> > excellent memory controller (as well as other controllers).
> > 
> > As you might have noticed, we have gone through major changes to come to
> > community's acceptance levels. We are now making use of all possible
> > features (kref, process event connector, configfs, module parameter,
> > kzalloc) in this infrastructure.
> > 
> > Having a CPU controller, two memory controllers, an I/O controller and a
> > numtasks controller proves that the infrastructure does handle major
> > resources nicely and is also capable of managing virtual resources.
> > 
> > Hope i reduced your worries (at least some :).
> Not all :) Let me explain.
> 
> Until you provided something more complex then numtasks, this 
> infrastructure is pure theory. For example, in your infrastracture, when 
> you will add memory resource controller with data sharing, you will face 
> that changing CKRM class of the tasks is almost impossible in a suitable 

I do not see a problem here, there could be 2 solutions:
 - do not account shared pages against the resource group(put them in
   the default resource group (as some other OSs do)).
 - when you are moving the task to a different class, calculate the
   resource group's usage depending on how many users are using a 
   specific page.
> way. Another possible situation: hierarchical classes with shared memory 
> are even more complicated thing.

Hierarchy is not an issue. Resource controller can calculate the
absolute number of resources (say no. of pages in this case) when the
shares are assigned and then treat all resource groups as flat.

> 
> In both cases you can end up with a poor/complicated/slow solution or 
> dropping some of your infrastructre features (changing class on the fly, 
> hierarchy) or which is worse IMHO with incosistency between controllers 
> and interfaces.

I am not convinced (based on the above explanations).
> 
> Thanks,
> Kirill
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


