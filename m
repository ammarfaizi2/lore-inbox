Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUBLSU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUBLSU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:20:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:5804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266495AbUBLSU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:20:27 -0500
Date: Thu, 12 Feb 2004 10:19:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave McCracken <dmccr@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
In-Reply-To: <362010000.1076607103@[10.1.1.5]>
Message-ID: <Pine.LNX.4.58.0402121014330.5816@home.osdl.org>
References: <1076384799.893.5.camel@gaston> <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
 <20040210173738.GA9894@mail.shareable.org> <20040213002358.1dd5c93a.ak@suse.de>
 <20040212100446.GA2862@elte.hu> <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
 <339500000.1076605352@[10.1.1.5]> <Pine.LNX.4.58.0402120912430.5816@home.osdl.org>
 <362010000.1076607103@[10.1.1.5]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Feb 2004, Dave McCracken wrote:
> 
> Hmm... would it work to just do something like 'if the previous vma is
> grow-up then allocate from the top of the hole'?  It'd eliminate the need
> for a hard limit and should pretty much stay out of the way of BSS.

Well, the _common_ case at least for the loader is that the "top of the 
hole" is actually the stack. So the above would _really_ suck, and crash 
pretty much immediately ;)

It would also cause the strange behaviour that we'd start allocating the 
virtual memory areas in "reverse order", ie we'd start at the top and grow 
down.

So I don't think that's a very good approach.

This is why special cases get complex: they end up feeding yet more 
special cases.

		Linus
