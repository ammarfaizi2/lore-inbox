Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWHPTUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWHPTUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWHPTUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:20:49 -0400
Received: from smtp-out.google.com ([216.239.45.12]:12374 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750925AbWHPTUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:20:48 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=ZwIIqlwGTDoG6GnCi/x70DtyBQ8ijggZsG+chvYXQORvSbEcVV6Va0EF8QwwWbINN
	lJ+ADZjfpbOr923WMF0dw==
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <1155754029.9274.21.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 16 Aug 2006 12:15:29 -0700
Message-Id: <1155755729.22595.101.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 11:47 -0700, Dave Hansen wrote:
> On Wed, 2006-08-16 at 19:40 +0400, Kirill Korotaev wrote:
> > --- ./include/linux/mm.h.kmemcore       2006-08-16 19:10:38.000000000
> > +0400
> > +++ ./include/linux/mm.h        2006-08-16 19:10:51.000000000 +0400
> > @@ -274,8 +274,14 @@ struct page {
> >         unsigned int gfp_mask;
> >         unsigned long trace[8];
> >  #endif
> > +#ifdef CONFIG_USER_RESOURCE
> > +       union {
> > +               struct user_beancounter *page_ub;
> > +       } bc;
> > +#endif
> >  };
> 
> Is everybody OK with adding this accounting to the 'struct page'?  

My preference would be to have container (I keep on saying container,
but resource beancounter) pointer embeded in task, mm(not sure),
address_space and anon_vma structures.  This should allow us to track
user land pages optimally.  But for tracking kernel usage on behalf of
user, we will have to use an additional field (unless we can re-use
mapping).  Please correct me if I'm wrong, though all the kernel
resources will be allocated/freed in context of a user process.  And at
that time we know if a allocation should succeed or not.  So we may
actually not need to track kernel pages that closely.  We are not going
to run reclaim on any of them anyways.  

-rohit


