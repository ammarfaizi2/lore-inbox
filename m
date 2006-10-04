Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWJDU6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWJDU6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWJDU6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:58:44 -0400
Received: from mail.impinj.com ([206.169.229.170]:16279 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S1751118AbWJDU6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:58:43 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Must check what?
Date: Wed, 4 Oct 2006 13:58:36 -0700
User-Agent: KMail/1.9.1
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
References: <20061004183752.GG28596@parisc-linux.org> <20061004192537.GH28596@parisc-linux.org> <20061004124310.10c9939b.akpm@osdl.org>
In-Reply-To: <20061004124310.10c9939b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041358.36515.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 12:43, Andrew Morton wrote:
> > > It should have a slot for documenting caller-provided locking
> > > requirements too.  And for permissible calling-contexts.  They're all
> > > part of the caller-provided environment, and these two tend to be a
> > > heck of a lot more subtle than the function's formal arguments.
> >
> > Indeed.  And reference count assumptions.  It's almost like we want a
> > pre-condition assertion ...
>
> We have might_sleep(), assert_spin_locked(), BUG_ON(!irqs_disabled()), etc.
>
> I like assertions personally.  If we had something like:
>
> void foo(args)
> {
> 	locals;
>
> 	assert_irqs_enabled();
> 	assert_spin_locked(some_lock);
> 	assert_in_atomic();
> 	assert_mutex_locked(some_mutex);
>
> then we get documentation which is (optionally) checked at runtime - best
> of both worlds.  Better than doing it in kernel-doc.  Automatically
> self-updating (otherwise kernels go BUG).

Uhoh! How much is that going to hurt runtime? :) It actually seems to me like 
this should be doable by static code analysis tools without terribly much 
pain (in the relative sense of the term). Or am I wrong on this thought?

> And we still need to document those return values in English.

Definitely.

-- Vadim Lobanov
