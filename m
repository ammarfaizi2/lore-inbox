Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVLVJSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVLVJSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 04:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVLVJSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 04:18:13 -0500
Received: from mverd138.asia.info.net ([61.14.31.138]:20574 "EHLO
	kao2.melbourne.sgi.com") by vger.kernel.org with ESMTP
	id S965116AbVLVJSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 04:18:13 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Nicolas Pitre <nico@cam.org>
cc: Daniel Jacobowitz <dan@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386 
In-reply-to: Your message of "Wed, 21 Dec 2005 15:54:13 CDT."
             <Pine.LNX.4.64.0512211552080.26663@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Dec 2005 20:18:07 +1100
Message-ID: <19454.1135243087@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005 15:54:13 -0500 (EST), 
Nicolas Pitre <nico@cam.org> wrote:
>On Wed, 21 Dec 2005, Daniel Jacobowitz wrote:
>
>> This new macro is only going to be used in x86-specific files, right? 
>> There's no practical way to implement this on lots of other
>> architectures.
>
>The default implementation does the call in C.
>
>> Embedding a call in asm("") can break other things too - for instance,
>> unwind tables could become inaccurate.
>
>I doubt unwind tables are used at all for the kernel, are they?

Yes they are.  ia64 absolutely requires accurate unwind tables, it is
part of the ABI.  x86_64 is tending towards requiring accurate CFI
data.

Without valid unwind tables, backtraces are flakey at best.  The lack
of decent kernel unwind for i386 is one of the reasons that kdb
backtrace for i386 is so horrible.

