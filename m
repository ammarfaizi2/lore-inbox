Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWIOAC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWIOAC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWIOAC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:02:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:49024 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932156AbWIOAC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:02:26 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: balbir@in.ibm.com, Srivatsa <vatsa@in.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <450952F8.8080606@openvz.org>
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>
	 <1157730221.26324.52.camel@localhost.localdomain>
	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>
	 <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>
	 <1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>
	 <1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>
	 <1158186664.18927.17.camel@linuxchandra> <45090A6E.1040206@openvz.org>
	 <45090D9E.9000903@in.ibm.com>  <450952F8.8080606@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 14 Sep 2006 17:02:21 -0700
Message-Id: <1158278541.6357.49.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 17:02 +0400, Pavel Emelianov wrote:

<snip>
> >
> Reserving in advance means that sometimes you won't be able to start a
> new group without taking back some of reserved pages. This is ... strange.

I do not see it strange. At the time of creation, user sees the failure
(that there isn't enough resource to provide the required/requested
guarantee) and can act accordingly.

BTW, VMware does it this way.

> 
> I think that a satisfactory solution now would be:
>  - limit unreclaimable memory during mmap() against soft limit to prevent
>    potential rejects during page faults;

we can have guarantee and still handle it this way.
>  - reclaim memory in case of hitting hard limit;
>  - guarantees are done via setting soft and hard limits as I've shown
> before.

complexity is high in doing that.
> 
> The question still open is wether or not to account fractions.
> I propose to skip fractions for a while and try to charge the page to
> it's first user.

sounds fine

> 
> So final BC design is:
> 1. three resources:
>        - kernel memory
>        - user unreclaimable memory
>        - user reclaimable memory

should be able to get other controllers also under this framework.

> 2. unreclaimable memory is charged "in advance", reclaimable
>    is charged "on demand" with reclamation if needed
> 3. each object (kernel one or user page) is charged to the
>    first user
> 4. each resource controller declares it's own
>        - meaning of "limit" parameter (percent/size/bandwidth/etc)
>        - behaviour on changing limit (e.g. reclamation)
>        - behaviour on hitting the limit (e.g. reclamation)
> 5. BC can be assigned to any task by pid (not just current)
>    without recharging currently charged resources.

Please see the emails i sent earlier in this context:
http://marc.theaimsgroup.com/?l=ckrm-tech&m=115593001810616&w=2

We would need at least:
 - BC should be created/deleted explicitly by the user
 - cleaner interface for controller writers

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


