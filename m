Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVC3MiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVC3MiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 07:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVC3MiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 07:38:10 -0500
Received: from calsoftinc.com ([64.62.215.98]:35976 "HELO calsoftinc.com")
	by vger.kernel.org with SMTP id S261823AbVC3MiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 07:38:02 -0500
Subject: Re: Fwd: [PATCH] Pageset Localization V2
From: shobhit dayal <shobhit@calsoftinc.com>
To: hch@infradead.org
Cc: christoph@lameter.com, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, Shai Fultheim <shai@scalex86.org>
In-Reply-To: <bab4333005033003295f487e3d@mail.gmail.com>
References: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net>
	 <20050330111439.GA13110@infradead.org>
	 <bab4333005033003295f487e3d@mail.gmail.com>
Content-Type: text/plain
Organization: calsoft
Message-Id: <1112187977.9773.15.camel@kuber>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Mar 2005 18:36:18 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The goal here is to replace the head of a existing list pointed to by
'list' with a new head pointed to by 'nlist'. 
First there is a memcpy that copies the contents of list to nlist then
this macro is called.
The macro makes sure that if the old head was empty then INIT_LIST_HEAD
the 'nlist', if not then make sure that the nodes before and after the
head now correclty point to nlist instead of list.

regards
shobhit


> ---------- Forwarded message ----------
> From: Christoph Hellwig <hch@infradead.org>
> Date: Wed, 30 Mar 2005 12:14:39 +0100
> Subject: Re: [PATCH] Pageset Localization V2
> To: Christoph Lameter <christoph@lameter.com>
> Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton
> <akpm@osdl.org>, linux-kernel@vger.kernel.org,
> linux-ia64@vger.kernel.org, linux-mm@kvack.org, shai@scalex86.org
> 
> 
> > +#define MAKE_LIST(list, nlist)  \
> > +     do {    \
> > +             if(list_empty(&list))      \
> > +                     INIT_LIST_HEAD(nlist);          \
> > +             else {  nlist->next->prev = nlist;      \
> > +                     nlist->prev->next = nlist;      \
> > +             }                                       \
> > +     }while(0)
> 
> This is horrible.  Where are the nlist pointers supposed to point to?
> What's so magic you need the INIT_LIST_HEAD only conditionally?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

