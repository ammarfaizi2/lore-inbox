Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWHYXA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWHYXA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWHYXA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:00:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:31108 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964775AbWHYXA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:00:58 -0400
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
In-Reply-To: <1156547572.3007.279.camel@localhost.localdomain>
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
	 <1156544604.1196.62.camel@linuxchandra>
	 <1156547572.3007.279.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Fri, 25 Aug 2006 16:00:54 -0700
Message-Id: <1156546854.1196.67.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-26 at 00:12 +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-25 am 15:23 -0700, ysgrifennodd Chandra Seetharaman:
> > > Bean counters can exist with no tasks, and the CKRM people have been
> > > corrected repeatedly on this point.
> > 
> > Hmm... from what I understand from the code, when the last resource in
> > the beancounter is dropped, the beancounter is destroyed. Which to me
> > means that when there are no tasks in a beancounter it will be
> > destroyed. (I just tested the code and verified that the beancounter is
> > destroyed when the task dies).
> 
> If a task created resource remains then the beancounter remains until
> the resources are destroyed, so it may exit well after the last task (eg
> an object handed to another process with a different luid is stil
> charged to us)
> 

It is the _implicit destruction_ that is a problem.
 
> > Let me reword the requirement: beancounter/resource group should _not_
> > be destroyed implicitly. It should be destroyed only when requested by
> > the user/sysadmin. In other words, we need a create_luid() and
> > destroy_luid().
> 
> So that you can preserve the limits on the resource group ? That also
> makes sense if you are trying to do long term resource management.

Yup.

> 
> Alan
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


