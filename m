Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVHMBSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVHMBSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 21:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVHMBSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 21:18:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932080AbVHMBSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 21:18:47 -0400
Date: Fri, 12 Aug 2005 18:18:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: George Anzinger <george@mvista.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] eliminte NMI entry/ exit code
In-Reply-To: <42FD42C1.6040009@mvista.com>
Message-ID: <Pine.LNX.4.58.0508121816380.3295@g5.osdl.org>
References: <42FD42C1.6040009@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Aug 2005, George Anzinger wrote:
>
> The NMI entry and exit code fiddles with bits in the preempt count.  If 
> an NMI happens while some other code is doing the same, bits will be 
> lost.

Why?

Even if an NMI happens in the middle of a read-modify-write sequence that 
is critical, the NMI exit is supposed to undo whatever it was that the NMI 
entry did, so the preempt counters are "safe" wrt NMI: they may change, 
but they always change back by the time anybody cares.

This, btw, is something we depend on wrt _normal_ interrupts too. It's why 
people can read/modify/write preempt count without having to disable 
interrupts.

			Linus
