Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUF3OjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUF3OjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUF3OjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:39:00 -0400
Received: from mail.shareable.org ([81.29.64.88]:15533 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266684AbUF3Oiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:38:54 -0400
Date: Wed, 30 Jun 2004 15:38:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040630143850.GF29285@mail.shareable.org>
References: <20040630013824.GA24665@mail.shareable.org> <20040630055041.GA16320@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630055041.GA16320@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 and x86-64 with NX, is a fault due to non-exec permission
distinguishable from a fault due to lack of read/write permissions?

I.e. does the flags word have a different bit set?

If so, the solution is simple: don't just return if it's a non-exec fault.

(It's possible that won't work if the CPU is very speculative and
generates data faults from prefetches despite them being in non-exec
area -- i.e. if the buggy data fault gets precedence over the non-exec
fault or segment.  But I'd hope that's not the case).

-- Jamie

