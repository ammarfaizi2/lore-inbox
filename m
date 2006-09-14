Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWINXmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWINXmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWINXmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:42:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:38560 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932134AbWINXmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:42:49 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: balbir@in.ibm.com, Srivatsa <vatsa@in.ibm.com>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <45090A6E.1040206@openvz.org>
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>
	 <1157730221.26324.52.camel@localhost.localdomain>
	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>
	 <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>
	 <1158000590.6029.33.camel@linuxchandra> <45069072.4010007@openvz.org>
	 <1158105488.4800.23.camel@linuxchandra> <4507BC11.6080203@openvz.org>
	 <1158186664.18927.17.camel@linuxchandra>  <45090A6E.1040206@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 14 Sep 2006 16:42:44 -0700
Message-Id: <1158277364.6357.33.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 11:53 +0400, Pavel Emelianov wrote:

<snip>

> > What if I have 40 containers each with 2% guarantee ? what do we do
> > then ? and many other different combinations (what I gave was not the
> > _only_ scenario).
> >   
> Then you need to solve a set of 40 equations. This sounds weird, but
> don't afraid - sets like these are solved lightly.

extrapolate that to a varying # of permutations and real time changes in
the system workload. Won't it be complex ?

Wouldn't it be a lot simpler if we have the guarantee support instead ?
Why you do not like guarantee ? :)

<snip>

> >> Then how do you make sure that memory WILL be available when the group needs
> >> it without limiting the others in a proper way?
> >>     
> >
> > You could limit others only if you _know_ somebody is not getting what
> > they are supposed to get (based on guarantee).
> >   
> I don't understand your idea. Limit does _not_ imply anything - it's
> just a limit.

I didn't mean "limit" as defined in BC. I meant it in the generic sense.
IOW, if we have to provide guarantees then it would limit other RGs from
getting that (amount of guaranteed) resource.
 
> You may limit anything to anyone w/o bothering the consequences.
> Guarantee implies that the resource you guarantee will be available and
> this "will be" is something not that easy.
> 
> So I repeat my question - how can you be sure that these X megabytes you
> guarantee to some group won't be used by others so that you won't be able
> to reclaim them?

It depends on how the memory controller is implemented. It could be
implemented in different ways:
 - reclamation path will _not_ free pages belonging to a RG that is 
   below its guarantee.
 - allocation from a "over guarantee" RG can succeed iff there is
   memory after satisfying all guarantees (or will free pages from the
   requesting RG before it will succeed).
 - ...

BTW, my point is to have guarantees for _all_ resources not just memory.

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


