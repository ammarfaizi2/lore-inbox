Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWHYSVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWHYSVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWHYSVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:21:54 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45710 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964810AbWHYSVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:21:53 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <FFE6D792-4D6C-4F19-A939-CBA5F0654FBA@mac.com>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra> <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
	 <1156417808.3007.78.camel@localhost.localdomain>
	 <1156463308.19702.40.camel@linuxchandra>
	 <FFE6D792-4D6C-4F19-A939-CBA5F0654FBA@mac.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 25 Aug 2006 11:21:48 -0700
Message-Id: <1156530108.1196.7.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 19:55 -0400, Kyle Moffett wrote:
> On Aug 24, 2006, at 19:48:28, Chandra Seetharaman wrote:
> > On Thu, 2006-08-24 at 12:10 +0100, Alan Cox wrote:
> >> All you need is
> >>
> >> struct wombat_controller
> >> {
> >> 	struct user_beancounter counter;
> >> 	void (*wombat_pest_control)(struct wombat *w);
> >> 	atomic_t wombat_population;
> >> 	int (*wombat_destructor)(struct wombat *w);
> >> };
> >
> > This may not solve the problem, as
> >  - we won't be able get the controller data structure given the  
> > beancounter data structure.
> 
> Of course you can!  This is what we do for linked lists too.  Here's  
> an example of how to get a pointer to your wombat_controller given  
> the user_beancounter pointer:
> struct wombat_controller *wombat = containerof 
> (ptr_to_user_beancounter, struct wombat_controller, counter);
> 
> The containerof(PTR, TYPE, MEMBER) returns a pointer to the parent  
> object of type "TYPE" whose member "MEMBER" has address "PTR".

Yes, it would work nicely. 

But, the problem is that the struct user_beancounter (part of
wombat_controller above) is a _copy_ of the original, not the original
itself. We cannot keep the original (in _each_ controller), as there may
be more than one controller in the system and user_beancounter structure
is created/owned/destroyed by the beancounter infrastructure and not the
controller.

> Cheers,
> Kyle Moffett
> 
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


