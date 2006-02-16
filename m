Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWBPQdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWBPQdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWBPQdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:33:08 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:29938 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932323AbWBPQdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:33:07 -0500
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060216094130.GA29716@elte.hu>
References: <20060216094130.GA29716@elte.hu>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 08:33:04 -0800
Message-Id: <1140107585.21681.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another thing I noticed was that futex_offset on the surface looks like
a malicious users dream variable .. I didn't notice security addressed
at all in your initial write up . I was told it was a big topic at last
years OLS ..  In your write up you did say you corrupted the
robust_list , but did you corrupt the offset? Is this even a concern?

Daniel


On Thu, 2006-02-16 at 10:41 +0100, Ingo Molnar wrote:
> This is release -V3 of the "lightweight robust futexes" patchset. The 
> patchset can also be downloaded from:
> 
>   http://redhat.com/~mingo/lightweight-robust-futexes/
> 
> Changes since -V2:
> 
> Ulrich Drepper ran the code through more glibc testcases, which 
> unearthed a couple of bugs:
> 
>  - fixed bug in the i386 and x86_64 assembly code (Ulrich Drepper)
> 
>  - fixed bug in the list walking futex-wakeups (found by Ulrich Drepper)
> 
>  - race fix: do not bail out in the list walk when the list_op_pending 
>    pointer cannot be followed by the kernel - another userspace thread 
>    may have already destroyed the mutex (and unmapped it), before this 
>    thread had a chance to clear the field.
> 
>  - cleanup: renamed list_add_pending to list_op_pending. (the field is 
>    used for list removals too)
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

