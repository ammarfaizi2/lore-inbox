Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbTFMGVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbTFMGVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:21:01 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44083 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S265167AbTFMGUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:20:55 -0400
Date: Thu, 12 Jun 2003 23:34:35 -0700
Message-Id: <200306130634.h5D6YZ523894@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: davidm@hpl.hp.com
X-Fcc: ~/Mail/linus
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: FIXMAP-related change to mm/memory.c
In-Reply-To: David Mosberger's message of  Thursday, 12 June 2003 19:16:37 -0700 <16105.13317.608868.581471@napali.hpl.hp.com>
X-Zippy-Says: Darling, my ELBOW is FLYING over FRANKFURT, Germany..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I considered a pte_user_read()/pte_user_write()-like approach, but
> rejected it.  First of all, it doesn't really help with execute-only
> pages.

The definition I gave was "should be readable by ptrace", and so it works
if that's how you categorize all execute-only pages.  But...

> [...], but I'm worried about someone adding other
> execute-only pages further down the road, not being aware that
> ptrace() would cause a potential security problem).

Given that concern, I'll agree with your assessment.

> For ia64, I think we really want to say: if it's accessing the gate
> page, allow reads.  There is just no way we can infer that from
> looking at the PTE itself.
> 
> Is there really a point in allowing other FIXMAP pages to be read via
> ptrace() on x86?

Currently, none are (because pte_user is only true of the vsyscall page).
For each individual arch, it seems reasonable enough to me to just have
special cases rather than testing the page tables.  Rather than the code
now in #ifdef FIXADDR_START it could just call an arch_get_user_pages
function to check for magic user addresses without vmas.

Linus's suggested change is obviously the minimal change from what we have
now.  But the arch_get_user_pages idea might be the more conservative
implementation compared to the status quo before my get_user_pages patch.


Thanks,
Roland
