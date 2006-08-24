Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWHXXsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWHXXsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWHXXsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:48:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:2733 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932243AbWHXXsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:48:32 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156417808.3007.78.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
	 <1156417808.3007.78.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Thu, 24 Aug 2006 16:48:28 -0700
Message-Id: <1156463308.19702.40.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 12:10 +0100, Alan Cox wrote:
> Ar Mer, 2006-08-23 am 19:04 -0700, ysgrifennodd Chandra Seetharaman:
> > > A single centralized structure that has fields that are mostly used by
> > > every one should be okay I think.
> > 
> > You mean to say definition like
> > 
> > struct user_beancounter {
> > 	fields;/* fields that exists now */
> > 	
> > 	int kmemsize_ctlr_info1;
> > 	char *kmemsize_ctlr_info2;
> > 
> > 	char *oomguar_ctlr_info1;
> > 	char *oomguar_ctlr_info2;
> > 
> > 	/* and so on */
> > }
> > 
> > is the right thing to do ? even though oomguar controller doesn't care
> > about kmemsize_ctlr_info* etc.,
> 
> 
> All you need is
> 
> struct wombat_controller
> {
> 	struct user_beancounter counter;
> 	void (*wombat_pest_control)(struct wombat *w);
> 	atomic_t wombat_population;
> 	int (*wombat_destructor)(struct wombat *w);
> };

This may not solve the problem, as 
 - we won't be able get the controller data structure given the
   beancounter data structure. 
 - we need to keep the data in sync (since there are multiple copies).
 - we will be copying the whole beancounter data structure needlessly
   (the controller might care only about _its_ parameters).

I agree with you that this can be added later when needed. The problem I
see is that this might need some change in the core data structure which
might face more resistance (than it does now :) once it is in mainline.

> 
> and just embed the counter in whatever you are controlling. The point of
> the beancounters themselves is to be *SIMPLE*. It's unfortunate that
> some folk seem obsessed with extending them for a million theoretical
> projects rather than getting them in and working and then extending them
> for real projects. Please lets not have another EVMS.
> 
> Alan
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


