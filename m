Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWARQsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWARQsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWARQsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:48:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030383AbWARQsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:48:06 -0500
Date: Wed, 18 Jan 2006 08:48:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <npiggin@suse.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] atomic_add_unless sadness
In-Reply-To: <20060118063636.GA14608@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0601180842440.3240@g5.osdl.org>
References: <20060118063636.GA14608@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jan 2006, Nick Piggin wrote:
>
> For some reason gcc 4 on at least i386 and ppc64 (that I have tested with)
> emit two cmpxchges for atomic_add_unless unless we put branch hints in.
> (it is unlikely for the "unless" case to trigger, and it is unlikely for
> cmpxchg to fail).

Irrelevant. If "atomic_add_unless()" is in a hot path and inlined, we're 
doing something else wrong anyway. It's not a good op to use. Just think 
of it as being very expensive.

The _only_ user of "atomic_add_unless()" is "dec_and_lock()", which isn't 
even inlined. The fact that gcc ends up "unrolling" the loop once is just 
fine.

Please keep it that way. 

		Linus
