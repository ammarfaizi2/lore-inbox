Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWIKSZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWIKSZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWIKSZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:25:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:16341 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932293AbWIKSZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:25:12 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added
	user	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1157751834.1214.112.camel@galaxy.corp.google.com>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 11 Sep 2006 11:25:07 -0700
Message-Id: <1157999107.6029.7.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 14:43 -0700, Rohit Seth wrote:
<snip>

> > > Guarantee may be one of
> > > 
> > >   1. container will be able to touch that number of pages
> > >   2. container will be able to sys_mmap() that number of pages
> > >   3. container will not be killed unless it touches that number of pages
> > >   4. anything else
> > 
> > I would say (1) with slight modification
> >    "container will be able to touch _at least_ that number of pages"
> > 
> 
> Does this scheme support running of tasks outside of containers on the
> same platform where you have tasks running inside containers.  If so
> then how will you ensure processes running out side any container will
> not leave less than the total guaranteed memory to different containers.
> 

There could be a default container which doesn't have any guarantee or
limit. When you create containers and assign guarantees to each of them
make sure that you leave some amount of resource unassigned. That
unassigned resources can be used by the default container or can be used
by containers that want more than their guarantee (and less than their
limit). This is how CKRM/RG handles this issue.

 
> 
> 
> -rohit
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


