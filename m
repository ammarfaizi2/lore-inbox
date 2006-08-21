Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWHUUzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWHUUzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWHUUzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:55:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:6377 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751079AbWHUUzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:55:49 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory
	accounting	(core)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E9901F.1030605@sw.ru>
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>
	 <1155932779.26155.87.camel@linuxchandra>  <44E9901F.1030605@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Mon, 21 Aug 2006 13:55:44 -0700
Message-Id: <1156193744.6479.23.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 14:51 +0400, Kirill Korotaev wrote:
> Chandra Seetharaman wrote:
> > Kirill,
> > 
> > IMO, a UBC with resource constraint(limit in this case) should behave no
> > different than a kernel with limited memory. i.e it should do
> > reclamation before it starts failing allocation requests. It could even
> > do it preemptively.
> first, please notice, that this thread is not about user memory.
> we can discuss it later when about to control user memory. And
> I still need to notice, that different models of user memory control
> can exist. With and without reclamation.
> 
we can talk about it then :)

> > There is no guarantee support which is required for providing QoS.
> where? in UBC? in UBC _there_ are guarentees, even in regard to OOM killer.

I do not see it in the patches you have submitted. May be I overlooked.
Can you please point me the code where guarantee is handled.

> 
> > Each controller modifying the infrastructure code doesn't look good. We
> > can have proper interfaces to add a new resource controller.
> controllers do not modify interfaces nor core. They just add
> themself to the list of resources and setup default limits.
> do you think it is worth creating infrastructure for these
> 2 one-line-changes?

Yes, IMO, it is cleaner. 

Think of the documentation that explains how to write a controller for
UBC.

With a proper interface it will read something like: One have to call
register_controller(char *name) and on success it returns a unique id
which is the id for the controller.

			Vs

With changing lines in the core code: One have to edit the file
filename.c and add a macro to this of macros with an incremented value
for their controller and add the name of their controller to the array
named controller_names[].

I think the first one is cleaner, what do you think ?
 
<snip>

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


