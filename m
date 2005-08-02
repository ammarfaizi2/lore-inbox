Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVHBPa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVHBPa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVHBPa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:30:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261543AbVHBPa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:30:57 -0400
Date: Tue, 2 Aug 2005 08:30:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
Message-ID: <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Aug 2005, Martin Schwidefsky wrote:
> 
> Why do we require the !pte_dirty(pte) check? I don't get it. If a writeable
> clean pte is just fine then why do we check the dirty bit at all? Doesn't
> pte_dirty() imply pte_write()?

A _non_writable and clean pty is _also_ fine sometimes. But only if we 
have broken COW and marked it dirty.

> With the additional !pte_write(pte) check (and if I haven't overlooked
> something which is not unlikely) s390 should work fine even without the
> software-dirty bit hack.

No it won't. It will just loop forever in a tight loop if somebody tries 
to put a breakpoint on a read-only location.

On the other hand, this being s390, maybe nobody cares?

		Linus
