Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTEJDOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 23:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTEJDOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 23:14:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27911 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263633AbTEJDOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 23:14:07 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Date: 9 May 2003 20:26:40 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9hrhg$5v7$1@cesium.transmeta.com>
References: <20030509124042.GB25569@mail.jlokier.co.uk> <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> It actually does have some cost in that form, namely the fact that the
> kernel 1:1 mapping needs to be 4MB-aligned in order to take advantage of
> large-pte support. So we'd have to move the kernel to something like
> 0xc0400000 (and preferably higher, to make sure there is a nice hole in
> between - say 0xc1000000), which in turn has a cost of verifying that 
> nothing assumes the current lay-out (we've had the 1/2/3GB TASK_SIZE 
> patches floating around, but they've never had "odd sizes").
> 
> There's another cost, which is that right now we share the pgd with the 
> kernel fixmaps, and this would mean that we'd have a new one. That's just 
> a single page, though.
> 
> But it might "just work", and it would be interesting to see what the
> patch would look like. Hint hint.
> 

Another option would be to put it in the "user" part of the address
space at 0xbffff000 (and move the %esp base value.)  That would have
the nice side benefit that stuff like UML or whatever who wanted to
map something over the vsyscall could do so.  Downside: each process
needs a PTE for this.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
