Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWHQRfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWHQRfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWHQRfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:35:32 -0400
Received: from mail.suse.de ([195.135.220.2]:39612 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751168AbWHQRfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:35:31 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory =?utf-8?q?accounting=09?=(core)
Date: Thu, 17 Aug 2006 20:43:11 +0200
User-Agent: KMail/1.9.1
Cc: Rik van Riel <riel@redhat.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
References: <44E33893.6020700@sw.ru> <44E488EF.4090803@redhat.com> <1155835700.14617.55.camel@galaxy.corp.google.com>
In-Reply-To: <1155835700.14617.55.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608172043.12468.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 19:28, Rohit Seth wrote:
> On Thu, 2006-08-17 at 11:19 -0400, Rik van Riel wrote:
> > Dave Hansen wrote:
> > > My main thought is that _everybody_ is going to have to live with the
> > > entry in the 'struct page'.  Distros ship one kernel for everybody, and
> > > the cost will be paid by those not even using any kind of resource
> > > control or containers.
> >
> > Every userspace or page cache page will be in an object
> > though.  Could we do the pointer on a per object (mapping,
> > anon vma, ...) basis?
> >
> > Kernel pages are not using all of their struct page entries,
> > so we could overload a field.
>
> Bingo.  Even though it has the word "overload".

You would need to be careful. Both the rewritten slab and the new
tree network allocator use struct page fields already. There might 
be conflicts already.

-Andi (who still doesn't see what's so bad about a separate table)
