Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUB2QeH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 11:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUB2QeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 11:34:07 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44162
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262070AbUB2QeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 11:34:05 -0500
Date: Sun, 29 Feb 2004 17:34:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040229163442.GB7269@dualathlon.random>
References: <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <20040228045713.GA388@ca-server1.us.oracle.com> <20040228061838.GO8834@dualathlon.random> <p73eksf4big.fsf@verdi.suse.de> <20040229013923.GV8834@dualathlon.random> <20040229032947.2f97ed79.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229032947.2f97ed79.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 03:29:47AM +0100, Andi Kleen wrote:
> On Sun, 29 Feb 2004 02:39:24 +0100
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > you're wrong about s/vm_next/rb_next()/, walking the tree like in
> > get_unmapped_area would require recurisve algos w/o vm_next, or
> > significant heap allocations. that's the only thing vm_next is needed
> > for (i.e. to walk the tree in order efficiently). only if we drop all
> > tree walks than we can nuke vm_next.
> 
> Not sure what you mean here. rb_next() is not recursive.

if you don't allocate the memory with recursion-like algos, you'll trow
too much cpu in a loop like this with rb_next. so it worth to keep
vm_next for performance reasons or for memory allocation reasons.

	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
