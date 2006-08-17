Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWHQR35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWHQR35 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWHQR35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:29:57 -0400
Received: from smtp-out.google.com ([216.239.45.12]:42919 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964800AbWHQR34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:29:56 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=XaUDx3GRQrr92AyKTThuevnGDZyQbh2jrZEU+mBucSoz2luGHBE6tvvdAV5gvtOQc
	qDDRDdlyVTh0Z/4/X50kw==
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory
	accounting	(core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Rik van Riel <riel@redhat.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E488EF.4090803@redhat.com>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <44E488EF.4090803@redhat.com>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 10:28:20 -0700
Message-Id: <1155835700.14617.55.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 11:19 -0400, Rik van Riel wrote:
> Dave Hansen wrote:
> 
> > My main thought is that _everybody_ is going to have to live with the
> > entry in the 'struct page'.  Distros ship one kernel for everybody, and
> > the cost will be paid by those not even using any kind of resource
> > control or containers.
> 
> Every userspace or page cache page will be in an object
> though.  Could we do the pointer on a per object (mapping,
> anon vma, ...) basis?
> 
> Kernel pages are not using all of their struct page entries,
> so we could overload a field.
> 

Bingo.  Even though it has the word "overload".

> It all depends on how much we really care about not growing
> struct page :)
> 

Besides, if we have the container pointer based on address_space (for
example) then it will also allow file based tracking...

I think page based container pointer makes more sense when you have
container as the central part of page lists (in place of nodes) deciding
which list the free page is going to come from, and when freed which
list it is going to go back to.

-rohit

