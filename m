Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUKJTCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUKJTCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKJTCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:02:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:51107 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262031AbUKJTCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:02:21 -0500
Date: Wed, 10 Nov 2004 11:01:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: hch@infradead.org, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH] VM routine fixes
Message-Id: <20041110110145.3751ae17.akpm@osdl.org>
In-Reply-To: <4530.1100093877@redhat.com>
References: <20041109140122.GA5388@infradead.org>
	<20041109125539.GA4867@infradead.org>
	<200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
	<15068.1100008386@redhat.com>
	<4530.1100093877@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Compound pages seem to be in some way tied to the TLB entry coverage sizes
>  available (for hugetlb), so it's not obvious that it's permitted to have
>  compound pages not of these sizes, and as I need to allocate arbitrary
>  sizes...

We've considered enabling compound pages permanently.  We thought sparc64
might want that, and it simplifies coverage testing.  But the
conditionality has been left in for now as a microoptimisation.

>  If I am correct about this, then the !MMU problem would still exist - just
>  with adjacent sets of compound pages rather than adjacent sets of pages.

Why _does_ !CONFIG_MMU futz around with page counts in such weird ways
anyway?  Why does it have requirements for higher-order pages which differ
from !CONFIG_MMU?

If someone could explain the reasoning behind the current code, and the FRV
enhancements then perhaps we could work something out.

>  Compound pages might be nice, but they're overkill.

I don't expect they have significant performance overhead, because they'll
only add cycles for higher-order pages.  They're rare, and are already
rather inefficient.
