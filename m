Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbULPBYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbULPBYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbULPBWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:22:20 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:12510 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262539AbULPBOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:14:22 -0500
To: Pavel Machek <pavel@suse.cz>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andi Kleen <ak@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea 
In-reply-to: Your message of "Wed, 15 Dec 2004 12:49:16 +0100."
             <20041215114916.GB1232@elf.ucw.cz> 
Date: Thu, 16 Dec 2004 01:14:09 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CekDZ-0005ZY-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You merge xen hooks in mainline, but keep maintaining arch/xen
> out-of-tree? You have to maintain it yourself, anyway, and having
> hooks merged should make it easy.

Having the hooks merged would certainly help. 

However, I think the main benefit of being in the mainline tree
would be that it would make it easy for other developers to see
how arch xen works and thus begin to take us into account when
considering changes. If there's going to be a big effort to merge
i386, x86_64 and xen going forward, it will certainly help if
more people have looked through our code. We'll only get that
kind of exposure to developers if we're in the mainstream tree. 

The other key area is that our top priority is to decrease the
number of files we need to modified from standard i386. For this
to happen, we need to submit patches into i386 that abstract a
few things behind macros/constants. For example, we'd like to
abstract the test to see whether the CPU is in the kernel or not
(we run the kernel in ring 1 rather than 0).  If arch xen is in
the tree, this kind of patch will make rather more sense to
people.

> BTW if you merge xen as separate architecture, it will be *very* hard
> to merge it back to i386. That patch would be huge, and would need to
> go in "atomically".

I don't see it like that. While continuing to track changes in
i386/x86_64, we'd restructure the code under arch xen such that
it could build (or even boot) time switch between running native
and over Xen. At some point the arch directory could then be
renamed.  This would be a big project, and one that would involve
a lot more people than just the Xen team. Because the x86
architecture is so critical to Linux, I just can't see this
happening unless the development takes place in the mainstream
tree. 

Of course, another reason for inclusion in mainstream is that
there's a lot of momentum behind Xen in both the user and
developer communities. My guess is that virtualization is going
to be pretty pervasive in the data centre, and its one of the key
technologies that Linux can win on. The paravirtualized approach
used by Xen is going to offer better performance than full x86
virtualization, even if there's extra support in the processor.

Cheers,
Ian


