Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWHRRJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWHRRJK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWHRRJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:09:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:24286 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1160997AbWHRRJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:09:08 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=NchLslXMUVONdC0tw8kwgFkX08/6jZyZEgpg32FULD2P+GLBQS0tAEdigXZ7IvFc+
	gbQGqKt4bJLrR3aPwBizQ==
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory
	accounting	(core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E57A6D.4040608@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <44E488EF.4090803@redhat.com>  <44E57A6D.4040608@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 18 Aug 2006 10:06:16 -0700
Message-Id: <1155920776.22899.17.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 12:29 +0400, Kirill Korotaev wrote:
> Rik van Riel wrote:
> > Dave Hansen wrote:
> > 
> >> My main thought is that _everybody_ is going to have to live with the
> >> entry in the 'struct page'.  Distros ship one kernel for everybody, and
> >> the cost will be paid by those not even using any kind of resource
> >> control or containers.
> > 
> > 
> > Every userspace or page cache page will be in an object
> > though.  Could we do the pointer on a per object (mapping,
> > anon vma, ...) basis?
> in this case no memory fractions accounting is possible :/
> please, note, this field added by this patchset is in union
> and used by user pages accounting as well.
>  
> > Kernel pages are not using all of their struct page entries,
> > so we could overload a field.
> yeah, we can. probably mapping.
> but as I said we use the same pointer for user pages accounting as well.
> 
> > It all depends on how much we really care about not growing
> > struct page :)
> so what is your opinion?
> Kernel compiled w/o UBC do not introduce additional pointer.


As Andi pointed out earlier that slab and network codes are going to use
the mapping field (and you pointed out that some of this is allocated
out of context), so seems like for kernel accounting we will need
another field in page structure.

-rohit

