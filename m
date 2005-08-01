Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVHAUO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVHAUO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVHAUMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:12:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbVHAULN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:11:13 -0400
Date: Mon, 1 Aug 2005 13:12:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, holt@sgi.com, torvalds@osdl.org, mingo@elte.hu,
       roland@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-Id: <20050801131240.4e8b1873.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0508012045050.5373@goblin.wat.veritas.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
	<42EDDB82.1040900@yahoo.com.au>
	<Pine.LNX.4.61.0508012045050.5373@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> There are currently 21 architectures,
> but so far your patch only updates 14 of them?

We could just do:

static inline int handle_mm_fault(...)
{
	int ret = __handle_mm_fault(...);

	if (unlikely(ret == VM_FAULT_RACE))
		ret = VM_FAULT_MINOR;
	return ret;
}

because VM_FAULT_RACE is some internal private thing.

It does add another test-n-branch to the pagefault path though.
