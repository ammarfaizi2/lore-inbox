Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWITQpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWITQpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWITQpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:45:01 -0400
Received: from smtp-out.google.com ([216.239.45.12]:39080 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751557AbWITQpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:45:00 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=Jd17zWxDN+TK9g8Wahvzpp9k7S6ElmyK2fMmVs60QwxD9mTgGDkdbqAjELhvCpvCF
	84jYsglUvZQa7TdQUD+HA==
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <p7364fikcbe.fsf@verdi.suse.de>
References: <1158718722.29000.50.camel@galaxy.corp.google.com>
	 <p7364fikcbe.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 09:44:29 -0700
Message-Id: <1158770670.8574.26.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 13:27 +0200, Andi Kleen wrote:
> Rohit Seth <rohitseth@google.com> writes:
> >  					 */
> > +#ifdef CONFIG_CONTAINERS
> > +	struct container_struct *ctn; /* Pointer to container, may be NULL */
> > +#endif
> 
> I still don't think it's a good idea to add a pointer to struct page for this.

I thought last time you supported adding a pointer to struct page (when
you mentioned next gen slab will also consume page->mapping).  May be I
missed your point.

> This means any kernel that enables the config would need to carry this significant
> overhead, no matter if containers are used to not.
> 
Sure this is non-zero overhead but I think this is the logical place to
track the memory.

> Better would be to store them in some other data structure that is only
> allocated on demand or figure out a way to store them in the sometimes
> not all used fields in struct page.
> 

which one...I think the fields in page structure are already getting
doubly used. 

> BTW your patchkit seems to be also in wrong order in that when 02 is applied
> it won't compile.

Not sure if I understood that.  I've myself tested these patches on
2.6.18-rc6-mm2 kernel and they apply just fine.  Are you just trying to
apply 02....if so then that wouldn't suffice.

-rohit

