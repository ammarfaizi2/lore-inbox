Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWHUUs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWHUUs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWHUUs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:48:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54234 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751055AbWHUUs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:48:26 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 3/7] UBC: ub context and inheritance
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E98BA5.8010605@sw.ru>
References: <44E33893.6020700@sw.ru> <44E33C04.50803@sw.ru>
	 <1155931423.26155.74.camel@linuxchandra>  <44E98BA5.8010605@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Mon, 21 Aug 2006 13:48:21 -0700
Message-Id: <1156193301.6479.14.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 14:32 +0400, Kirill Korotaev wrote:
> Chandra Seetharaman wrote:
> > On Wed, 2006-08-16 at 19:38 +0400, Kirill Korotaev wrote:
> > 
> >>Contains code responsible for setting UB on task,
> >>it's inheriting and setting host context in interrupts.
> >>
> >>Task references three beancounters:
> >>  1. exec_ub  current context. all resources are
> >>              charged to this beancounter.
> >>  2. task_ub  beancounter to which task_struct is
> >>              charged itself.
> > 
> > 
> > I do not see why task_ub is needed ? i do not see it being used
> > anywhere.
> it is used to charge task itself. will be heavily used in next patch set
> adding "numproc" UBC parameter.

Well, from your other responses it sounded like you are including
code/data structure/functionality only when they are used. So, I wasn't
clear if this is missed out on cleanup or really part of UBC.

Besides, if this is needed only for a specific controller, shouldn't the
controller worry about maintaining it ?

> 
> >>  3. fork_sub beancounter which is inherited by
> >>              task's children on fork
> > 
> > 
> >>From other emails it looks like renaming fork/exec to be real/effective
> > will be easier to understand.
> there is no "real". exec_ub is effective indeed,
> but fork_sub is the one to inherit on fork().

IMO, fork_cb/exec_cb doesn't convey the real meaning of the usage.
> 
> Kirill
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


