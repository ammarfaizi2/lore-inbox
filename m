Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWILAaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWILAaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWILAaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:30:12 -0400
Received: from smtp-out.google.com ([216.239.45.12]:59669 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965205AbWILAaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:30:10 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=WqU6TOGNpUREajwbMUFmC8u3SmPxKu7SDuGt1Wko7k9qn/6Lwp5ikUamyEuzwgZCQ
	AYk5DzkqxZ9ahNHR4IjsQ==
Subject: Re: [Devel] Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4)
	(added user	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kir Kolyshkin <kir@openvz.org>
Cc: devel@openvz.org, sekharan@us.ibm.com, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <4505BD89.8040400@openvz.org>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <4505BD89.8040400@openvz.org>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 11 Sep 2006 17:28:58 -0700
Message-Id: <1158020939.12947.129.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 23:48 +0400, Kir Kolyshkin wrote:
> Rohit Seth wrote:
> > On Mon, 2006-09-11 at 11:25 -0700, Chandra Seetharaman wrote:
> >   
> >> On Fri, 2006-09-08 at 14:43 -0700, Rohit Seth wrote:
> >> <snip>
> >>
> >>     
> >>>>> Guarantee may be one of
> >>>>>
> >>>>>   1. container will be able to touch that number of pages
> >>>>>   2. container will be able to sys_mmap() that number of pages
> >>>>>   3. container will not be killed unless it touches that number of pages
> >>>>>   4. anything else
> >>>>>           
> >>>> I would say (1) with slight modification
> >>>>    "container will be able to touch _at least_ that number of pages"
> >>>>
> >>>>         
> >>> Does this scheme support running of tasks outside of containers on the
> >>> same platform where you have tasks running inside containers.  If so
> >>> then how will you ensure processes running out side any container will
> >>> not leave less than the total guaranteed memory to different containers.
> >>>
> >>>       
> >> There could be a default container which doesn't have any guarantee or
> >> limit. 
> >>     
> >
> > First, I think it is critical that we allow processes to run outside of
> > any container (unless we know for sure that the penalty of running a
> > process inside a container is very very minimal).
> >   
> (1) there is a set of processes running outside of any container. In
> OpenVZ we call that "VE0" or "host system", probably Chandra meant that
> by "default container".
> (2) The host system is used to manage the containers (start/stop/set
> parameters/create/destroy).
> (3) the penalty of running a process inside a container is indeed very low.
> 
> > And anything running outside a container should be limited by default
> > Linux settings.
> >   
> (4) due to (2), it is not recommended to run anything but the tasks used
> to manage the containers -- otherwise your gonna have security problems

Just like you want to run those special threads outside of any
container, some sysadmin might be interested in running different
processes that they don't want to bind to any container limits.

I think it is critical that you provide the capability to have tasks
running outside any container. Whether sysadmin wants to do it or not
for a system is a different thing.

-rohit

