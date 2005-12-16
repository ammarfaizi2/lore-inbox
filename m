Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVLPQC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVLPQC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVLPQC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:02:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932343AbVLPQC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:02:28 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <43A2BE49.4000102@yahoo.com.au> 
References: <43A2BE49.4000102@yahoo.com.au>  <43A08D50.30707@yahoo.com.au> <439FFF63.6020105@yahoo.com.au> <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> <15157.1134560767@warthog.cambridge.redhat.com> <12832.1134734438@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 16 Dec 2005 16:02:11 +0000
Message-ID: <20450.1134748931@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> So I don't know why you're so worried about sparc32 and parisc while
> preferring to introduce a worse default implementation that even your frv
> architecture wants to override...?

I now think the base default should be a wrapper around the counting
semaphores, because that is the easiest path (they already exist) and it's
also the fastest path on some platforms.

But I want to be able to override the implementation on such as FRV because I
can do a better mutex than a counting semaphore there as I only have SWAP
available as an atomic op.

However, I would like to make the unconditional-exchange mutex a template that
can be overridden so that other archs can use it with one Kconfig option and a
few #defines in asm/system.h.

David
