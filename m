Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbUBYWNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUBYWKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:10:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5832 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261646AbUBYWJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:09:30 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Distributed mmap API
Date: Wed, 25 Feb 2004 17:07:05 -0500
User-Agent: KMail/1.5.4
Cc: paulmck@us.ibm.com, sct@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040216190927.GA2969@us.ibm.com> <200402251604.19040.phillips@arcor.de> <20040225140727.0cde826e.akpm@osdl.org>
In-Reply-To: <20040225140727.0cde826e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402251707.05932.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 February 2004 17:07, Andrew Morton wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> > -			pte = ptep_get_and_clear(ptep);
> > +			if (unlikely(!all) && is_anon(pfn_to_page(pfn)))
> > +				continue;
> > +			pte = ptep_get_and_clear(ptep); /* get dirty bit atomically */
> >  			tlb_remove_tlb_entry(tlb, ptep, address+offset);
> >  			if (pfn_valid(pfn)) {
>
> I think you need to check pfn_valid() before running is_anon(pfn_to_page())

Easy enough:

	if (unlikely(!all) && pfn_valid(pfn) && is_anon(pfn_to_page(pfn)))

but how can we legitimately get !pfn_valid there?

Regards,

Daniel

