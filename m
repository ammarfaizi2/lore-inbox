Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVHaOcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVHaOcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVHaOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:32:04 -0400
Received: from dvhart.com ([64.146.134.43]:59782 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964823AbVHaOcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:32:02 -0400
Date: Wed, 31 Aug 2005 07:31:52 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Hugh Dickins <hugh@veritas.com>, Arjan van de Ven <arjan@infradead.org>
Cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] Implement shared page tables
Message-ID: <16640000.1125498711@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.61.0508311437070.16834@goblin.wat.veritas.com>
References: <7C49DFF721CB4E671DB260F9@[10.1.1.4]> <Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com><1125489077.3213.12.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0508311437070.16834@goblin.wat.veritas.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Hugh Dickins <hugh@veritas.com> wrote (on Wednesday, August 31, 2005 14:42:38 +0100):

> On Wed, 31 Aug 2005, Arjan van de Ven wrote:
>> On Wed, 2005-08-31 at 12:44 +0100, Hugh Dickins wrote:
>> > I was going to say, doesn't randomize_va_space take away the rest of
>> > the point?  But no, it appears "randomize_va_space", as it currently
>> > appears in mainline anyway, is somewhat an exaggeration: it just shifts
>> > the stack a little, with no effect on the rest of the va space.
>> 
>> it also randomizes mmaps
> 
> Ah, via PF_RANDOMIZE, yes, thanks: so long as certain conditions are
> fulfilled - and my RLIM_INFINITY RLIMIT_STACK has been preventing it.
> 
> And mmaps include shmats: so unless the process specifies non-NULL
> shmaddr to attach at, it'll choose a randomized address for that too
> (subject to those various conditions).
> 
> Which is indeed a further disincentive against shared page tables.

Or shared pagetables a disincentive to randomizing the mmap space ;-)
They're incompatible, but you could be left to choose one or the other
via config option.

3% on "a certain industry-standard database benchmark" (cough) is huge,
and we expect the benefit for PPC64 will be larger as we can share the
underlying hardware PTEs without TLB flushing as well.

M.

