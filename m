Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWHRSyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWHRSyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWHRSyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:54:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:59271 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161067AbWHRSyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:54:01 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, vatsa@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E5982C.80304@sw.ru>
References: <44E33893.6020700@sw.ru> <20060817110237.GA19127@in.ibm.com>
	 <44E47547.8030702@sw.ru> <1155844543.26155.10.camel@linuxchandra>
	 <44E5982C.80304@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Aug 2006 11:53:49 -0700
Message-Id: <1155927229.26155.28.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 14:36 +0400, Kirill Korotaev wrote:
> Chandra Seetharaman wrote:
> > On Thu, 2006-08-17 at 17:55 +0400, Kirill Korotaev wrote:
> > 
> >>>On Wed, Aug 16, 2006 at 07:24:03PM +0400, Kirill Korotaev wrote:
> >>>
> >>>
> >>>>As the first step we want to propose for discussion
> >>>>the most complicated parts of resource management:
> >>>>kernel memory and virtual memory.
> >>>
> >>>Do you have any plans to post a CPU controller? Is that tied to UBC
> >>>interface as well?
> >>
> >>Not everything at once :) To tell the truth I think CPU controller
> >>is even more complicated than user memory accounting/limiting.
> >>
> >>No, fair CPU scheduler is not tied to UBC in any regard.
> > 
> > 
> > Not having the CPU controller on UBC doesn't sound good for the
> > infrastructure. IMHO, the infrastructure (for resource management) we
> > are going to have should be able to support different resource
> > controllers, without each controllers needing to have their own
> > infrastructure/interface etc.,
> 1. nothing prevents fair cpu scheduler from using UBC infrastructure.

ok.

>    but currently we didn't start discussing it.
> 
> 2. as was discussed with a number of people on summit we agreed that
>    it maybe more flexible to not merge all resource types into one set.
>    CPU scheduler is usefull by itself w/o memory management.
>    the same for disk I/O bandwidht which is controlled in CFQ by
>    a separate system call.
> 
>    it is also more logical to have them separate since they
>    operate in different terms. For example, for CPU it is
>    shares which are relative units, while for memory it is
>    absolute units in bytes.

We don't have to tie the units with the number. We can leave it to be
sorted out between the user and the controller writer.

Current implementation of resource groups does that.

> 
> >>As we discussed before, it is valuable to have an ability to limit
> >>different resources separately (CPU, disk I/O, memory, etc.).
> > 
> > Having ability to limit/control different resources separately not
> > necessarily mean we should have different infrastructure for each.
> I'm not advocating to have a different infrastructure.
> It is not the topic I raise with this patch set.
> 
> >>For example, it can be possible to place some mission critical
> >>kernel threads (like kjournald) in a separate contanier.
> > I don't understand the comment above (in this context).
> If you have a single container controlling all the resources, then
> placing kjournald into CPU container would require setting
> it's memory limits etc. And kjournald will start to be accounted separately,

Not necessarily. You could just set the CPU shares of the group and
leave the other resources as don't care.

> while my intention is kjournald to be accounted as the host system.
> I only want to _guarentee_ some CPU to it.

I do not see any _guarantee_ support, only barrier(soft limit) and
limit. May be I overlooked. Can you tell me how guarantee is achieved
with UBC.

> 
> Thanks,
> Kirill
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


