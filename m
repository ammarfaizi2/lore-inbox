Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWIKSon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWIKSon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWIKSom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:44:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:14250 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964911AbWIKSol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:44:41 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: balbir@in.ibm.com, Dave Hansen <haveblue@us.ibm.com>,
       Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org
In-Reply-To: <450508BB.7020609@openvz.org>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157730221.26324.52.camel@localhost.localdomain>
	 <4501B5F0.9050802@in.ibm.com>  <450508BB.7020609@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 11 Sep 2006 11:44:22 -0700
Message-Id: <1158000262.6029.26.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 10:56 +0400, Pavel Emelianov wrote:

<snip>

> >> I think of it as: "I will be allowed to use this many total pages, and
> >> they are guaranteed not to fail."  (1), I think.  The sum of all of the
> >> system's guarantees must be less than or equal to the amount of free
> >> memory on the machine. 
> >
> > Yes, totally agree.
> 
> Such a guarantee is really a limit and this limit is even harder than
> BC's one :)
> 
> E.g. I have a node with 1Gb of ram and 10 containers with 100Mb
> guarantee each.

In the first place system administrator should not be configuring it
that way, Then they are using it as a strict hard limit than guarantee
(as the resources guaranteed to one container is _not_ available to
others).

Besides, the above configuration is clearly _not_ work conservative.

They should use both guarantee and limit to associate resources to a
container/RG.

> I want to start one more. What shall I do not to break guarantees?

CKRM/RG handles it this way:

Amount of a resource a child RG gets is the ratio of its share value to
the parent's total # of shares. Children's resource allocation can be
changed just by changing the parent's total # of shares.

If you case about initial situation would be:
  Total memory in the system 100MB 
  parent's total # of shares: 100 (1 share == 1MB)
  10 children with # of shares: 10 (i.e each children has 10MB)

When I want to add another child, just change parent's total # of shares
to be say 125:
  Total memory in the system 100MB
  parent's total # of shares: 125 (1 share == 0.8MB)
  10 children with # of shares: 10 (i.e each children has 8MB)
Now you are left with 25 shares (or 20MB) that you can assign to new
child(ren) as you please.

<snip>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


