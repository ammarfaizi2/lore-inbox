Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbSJNNMe>; Mon, 14 Oct 2002 09:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJNNMe>; Mon, 14 Oct 2002 09:12:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43722 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261301AbSJNNMe>;
	Mon, 14 Oct 2002 09:12:34 -0400
Date: Mon, 14 Oct 2002 15:30:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support,
 2.5.42-F8
In-Reply-To: <20021014.054500.89132620.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210141525250.21947-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Oct 2002, David S. Miller wrote:

> We created the range tlb flushes so that architectures have a chance of
> optimizing such operations when possible.

yeah, agreed, we can change it to do the mmu_gather_t thing, and to
optimize that on x86 as well. Nevertheless the fact remains that cache
users were pretty much forced to use a multipage cache unit, which caused
all userspace TLBs to be flushed on x86. Where to draw the line between a
loop of INVLPG and a CR3 flush on x86 is up in the air - i'd say it's at
roughly 8 pages currently, while the x86 TLB flush code only optimizes the
single-page flushes. So you are right that this issue should be separated
from nonlinear mappings.

	Ingo

