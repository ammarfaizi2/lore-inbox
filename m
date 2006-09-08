Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWIHTXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWIHTXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWIHTXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:23:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:55966 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751081AbWIHTXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:23:50 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <45011CAC.2040502@openvz.org>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra>  <45011CAC.2040502@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 08 Sep 2006 12:23:44 -0700
Message-Id: <1157743424.19884.65.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 11:33 +0400, Pavel Emelianov wrote:
> Chandra Seetharaman wrote:
> > On Thu, 2006-09-07 at 00:47 +0530, Balbir Singh wrote:
> >
> > <snip>
> >> Some not quite so urgent ones - like support for guarantees. I think
> >> this can
> >
> > IMO, guarantee support should be considered to be part of the
> > infrastructure. Controller functionalities/implementation will be
> > different with/without guarantee support. In other words, adding
> > guarantee feature later will cause re-implementations.
> I'm afraid we have different understandings of what a "guarantee" is.
> Don't we?

may be (I am not sure :), lets get it clarified.
 
> Guarantee may be one of
> 
>   1. container will be able to touch that number of pages
>   2. container will be able to sys_mmap() that number of pages
>   3. container will not be killed unless it touches that number of pages
>   4. anything else

I would say (1) with slight modification
   "container will be able to touch _at least_ that number of pages"

Note that it is not only in the context of memory alone, it is generic
across resources.

For CPU it will be, "container will get _at least_ X ticks in Y seconds"

For number of tasks it will be, "container will get _at least_ X active
tasks at any point of time" and so on.

And as Dave pointed, sum of guarantees of all containers _can not_
exceed the total amount of that resource available at the system level.

> 
> Let's decide what kind of a guarantee we want.
> >> be worked out as we make progress.
> >>
> >>> I agree with these requirements and lets move into this direction.
> >>> But moving so far can't be done without accepting:
> >>> 1. core functionality
> >>> 2. accounting
> >>>
> >> Some of the core functionality might be a limiting factor for the requirements.
> >> Lets agree on the requirements, I think its a great step forward and then
> >> build the core functionality with these requirements in mind.
> >>
> >>> Thanks,
> >>> Kirill
> >>>
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


