Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTIRTs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 15:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTIRTs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 15:48:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:58005 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262105AbTIRTs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 15:48:28 -0400
Date: Thu, 18 Sep 2003 20:48:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-ID: <20030918194800.GA8572@mail.jlokier.co.uk>
References: <20030917202100.GC4723@wotan.suse.de> <Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org> <20030917211200.GA5997@wotan.suse.de> <20030918153831.GA7548@mail.jlokier.co.uk> <20030918160456.GC7548@mail.jlokier.co.uk> <20030918170629.GC7917@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918170629.GC7917@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > My point is simply that non-zero base GDT segments are possible in
> > userspace, and whatever code you add later to add the base should
> > be aware of that.
> 
> I don't see how a non standard GDT is possible in user space. The GDT 
> is only managed by the kernel. 2.6 offers to change it for NPTL, but
> that only applies to data segments.

I don't see anything in set_thread_area() which restricts them to data
segments.  Btw, NPTL isn't the only userspace code which uses this
function.

Admittedly it would be quite odd to use set_thread_area() to create
and use a GDT code segment - but given that you can do it, it would be
_really_ odd if prefetch instructions gave spurious faults in these
segments yet were fixed up elsewhere.

> In vm86 mode the user can load a different base without LDT, but that
> should not matter here (although it may be better to check for VM86 mode
> too) 

Shouldn't spurious faults in prefetch instructions in vm86 mode be
fixed up too?

-- Jamie
