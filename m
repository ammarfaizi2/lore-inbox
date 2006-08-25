Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWHYWX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWHYWX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWHYWX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:23:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:4496 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751520AbWHYWX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:23:28 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, rohitseth@google.com, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156539168.3007.264.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra> <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
	 <1156440461.14648.26.camel@galaxy.corp.google.com>
	 <1156463572.19702.46.camel@linuxchandra>  <44EEDB23.9050006@sw.ru>
	 <1156531644.1196.26.camel@linuxchandra>
	 <1156539168.3007.264.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Fri, 25 Aug 2006 15:23:24 -0700
Message-Id: <1156544604.1196.62.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 21:52 +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-25 am 11:47 -0700, ysgrifennodd Chandra Seetharaman:
> > I think my original point is getting lost in the discussion, which is,
> > there should be way (for the sysadmin) to get a list of tasks belonging
> > to a resource group (in a non-container environment).
> 
> Ok that much is easy to deal with. You print the luid in /proc.
> 
> > - ability for the sysadmin to move a task to a resource group.
> 
> So you want a setpluid(pid, luid) ? Trivial to add although you might
> want to refuse it in many secure environments but thats an SELinux rule
> again.

yes.
> 
> > - assignment of task to a resource group should be transparent to the 
> >   app.
> 
> In those cases its akin to and matches security domain transitions which
> says to me SELinux (or AppArmour) should do it.

If setpluid(pid, luid) exists, then this is more easy to handle.
> 
> > - a resource group could exist with no tasks associated.
> 
> Bean counters can exist with no tasks, and the CKRM people have been
> corrected repeatedly on this point.

Hmm... from what I understand from the code, when the last resource in
the beancounter is dropped, the beancounter is destroyed. Which to me
means that when there are no tasks in a beancounter it will be
destroyed. (I just tested the code and verified that the beancounter is
destroyed when the task dies).

Please correct me if my understanding is incorrect.

Let me reword the requirement: beancounter/resource group should _not_
be destroyed implicitly. It should be destroyed only when requested by
the user/sysadmin. In other words, we need a create_luid() and
destroy_luid().
> 
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


