Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTLIX1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTLIX1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:27:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:57731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262280AbTLIX1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:27:02 -0500
Date: Tue, 9 Dec 2003 15:26:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rafal Skoczylas <nils@secprog.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.test11 bug
In-Reply-To: <20031209223122.GA16808@secprog.org>
Message-ID: <Pine.LNX.4.58.0312091520060.29676@home.osdl.org>
References: <20031208034631.GA14081@secprog.org> <Pine.LNX.4.58.0312072100250.13236@home.osdl.org>
 <20031208161742.GB9087@secprog.org> <Pine.LNX.4.58.0312080848560.13236@home.osdl.org>
 <Pine.LNX.4.58.0312080911470.13236@home.osdl.org> <20031209194827.GA22265@secprog.org>
 <Pine.LNX.4.58.0312091221440.21456@home.osdl.org> <20031209223122.GA16808@secprog.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Dec 2003, Rafal Skoczylas wrote:
>
> Anyway, while compiling with frame pointers I got another oops ;/
> This one is different those we have seen so far:

Actually, it's very similar to the ones you had earlier - the backtrace is
different, but it's the same thing again:

	ecx: 5944f160   edx: d944f160

that's a doubly-linked list, and the two values _should_ be the same, I
bet.

Except one of them has the high bit clear, and when following the bogus
pointer, you get a page fault.

I think the second one (the "kernel bug in mmap.c" one) is just a result
of the first oops one leaving the mm lists in a bad state and map_count
being off as a result, or something like that.

			Linus
