Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264243AbTEGVs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbTEGVs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:48:59 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:63732 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264243AbTEGVs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:48:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Date: Wed, 7 May 2003 17:01:11 -0500
X-Mailer: KMail [version 1.2]
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <03050716305002.07468@tabby> <3EB980AA.9060207@techsource.com>
In-Reply-To: <3EB980AA.9060207@techsource.com>
MIME-Version: 1.0
Message-Id: <03050717011103.07468@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 16:54, Timothy Miller wrote:
> Jesse Pollard wrote:
> > On Wednesday 07 May 2003 12:13, Jonathan Lundell wrote:
> > [snip]
> >
> >>One thing that would help (aside from separate interrupt stacks)
> >>would be a guard page below the stack. That wouldn't require any
> >>physical memory to be reserved, and would provide positive indication
> >>of stack overflow without significant runtime overhead.
> >
> > It does take up a page table entry, which may also be in short supply
>
> Now, I'm sure this has GOT to be a terribly ignorant question, but I'll
> try anyhow:
>
> What happens if you simply neglect to provide a mapping for that page?
> I'm sure that will cause some sort of page fault.  Why would you have to
> do something different?

I believe it shifts the entire virtual range up(/down depending on your point
of view). Each page in the virtual address range (whether it physically
exists or not) has a descriptor. To reserve one requires that the descriptor
be set to "does not exist, no read, no write". Then any access to that page
can/will generate a trap.
