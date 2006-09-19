Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWISACe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWISACe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 20:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWISACd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 20:02:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:20161 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030312AbWISACc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 20:02:32 -0400
Subject: Re: [ckrm-tech] [Devel] Re: [PATCH] BC:	resource	beancounters	(v4)
	(added	user memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kir Kolyshkin <kir@openvz.org>
Cc: rohitseth@google.com, devel@openvz.org, Rik van Riel <riel@redhat.com>,
       vatsa@in.ibm.com, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       balbir@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <450B1958.3020309@openvz.org>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <20060912104410.GA28444@in.ibm.com>
	 <1158081752.20211.12.camel@galaxy.corp.google.com>
	 <1158105732.4800.26.camel@linuxchandra>
	 <1158108203.20211.52.camel@galaxy.corp.google.com>
	 <1158109991.4800.43.camel@linuxchandra>
	 <1158111218.20211.69.camel@galaxy.corp.google.com>
	 <1158186247.18927.11.camel@linuxchandra> <450A71B1.8020009@sw.ru>
	 <1158339160.12311.35.camel@galaxy.corp.google.com>
	 <450B1958.3020309@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 18 Sep 2006 17:02:27 -0700
Message-Id: <1158624147.6536.13.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 01:21 +0400, Kir Kolyshkin wrote:
> Rohit Seth wrote:
> > On Fri, 2006-09-15 at 13:26 +0400, Kirill Korotaev wrote:
> >   
> > <...skipped...>
> >   
> >> for VMware which can reserve required amount of RAM for VM.
> >>     
> >
> > It is much easier to provide guarantees in complete virtual
> > environments.  But then you pay the cost in terms of performance.
> >   
> "Complete virtual environments" vs. "contaners" is not [only] about
> performance! In the end, given a proper set of dirty and no-so-dirty
> hacks in software and hardware, their performance will be close to native.
> 
> Containers vs. other virtualization types is more about utilization,
> density, scalability, portability.
> 
> Speaking of guarantees, yes, guarantees is easy, you just reserve such
> amount of RAM for your VM and that is all. But the fact is usually some
> part of that RAM will not be utilized by this particular VM. But since
> it is reserved, it can not be utilized by other VMs -- and we end up
> just wasting some resources. Containers, given a proper resource
> management and configuration, can have some guarantees and still be able
> to utilize all the RAM available in the system. This difference can be
> metaphorically expressed as a house divided into rooms. Dividing walls
> can either be hard or flexible. With flexible walls, room (container)
> owner have a guarantee of minimal space in your room, but if a few
> guests come for a moment, the walls can move to make more space (up to
> the limit). So the flexibility is measured as the delta between a
> guarantee and a limit.
> 
> This flexibility leads to higher utilization, and this flexibility is
> one of the reasons for better density (a few times higher than that of a
> paravirtualization solution).
> 
> I will not touch scalability and portability topics here to make things
> simpler.
> > I think we should punt on hard guarantees and fractions for the first
> > draft.  Keep the implementation simple.
> >   
> Do I understand it right that with hard guarantees we loose the
> flexibility I have just described? If this is the case, I do not like it.
> 

If I understand your description correctly (describing flexibility to be
the ability to move the resource usage between guarantee and limit),
then NO, you will not loose that flexibility.

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


