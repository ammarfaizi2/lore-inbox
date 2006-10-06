Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWJFOlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWJFOlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWJFOlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:41:19 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:6048
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1161004AbWJFOlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:41:18 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Fri, 6 Oct 2006 16:40:59 +0200
User-Agent: KMail/1.9.4
References: <200610052059.11714.mb@bu3sch.de> <Pine.LNX.4.61.0610051535420.29755@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0610051535420.29755@chaos.analogic.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061640.59421.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 21:50, linux-os (Dick Johnson) wrote:
> Of course you must be able to remap the physical address 0 (offset
> zero in the whole machine), and if your 'hint' to mmap() in
> user code is a 0, it can (it's allowed) to return a pointer
> initialized to zero --and it's your fault if it's incompatible
> with some 'C' runtime libraries.
> 
> It is a perfectly good address and the fact that malloc() returns
> (void *)0 upon failure, does not qualify it as king or some other
> ruler. In fact, mmap() returns (void *)-1 upon failure.

You are explainint something that is _completely_ unrelated to the
issue I am describing.

> > I say no, because this can potentially be used to turn rather harmless
> > kernel bugs into a security vulnerability.
> >
> 
> Can't. The kernel doesn't check for NULL for user access, it
> simply traps if the address is bad. That's why we have copy/to/from_user()
> for user-mode access.

See my example.

> > Let's say we have some kernel NULL pointer dereference bug somewhere,
> > that's rather harmless, if it happens in process context and
> > does not leak any resources on segfaulting the triggering app.
> > So the worst thing that happens is a crashing app. Yeah, this bug must
> > be fixed. But my point is that this bug can probably be used to
> > manipulate the way the kernel works or even to inject code into
> > the kernel from userspace.
> >
> 
> Can't.

See my example. It _does_ inject a userspace controlled value into
the kernel.

> > Attached to this mail is an example. The kernel module represents
> > the actual "kernel-bug". Its whole purpose in this example is to
> > introduce a user-triggerable NULL pointer dereference.
> > Please stop typing now, if you are typing something like
> > "If you can load a kernel module, you have access to the kernel anyway".
> > This is different. We always _had_ and most likely _have_ NULL pointer
> > dereference bugs in the kernel.
> >
> > The example programm injects a magic value 0xB15B00B2 into the
> > kernel, which is printk'ed on success.
> 
> Well this shows nothing interesting.

It _does_. What if the pointer was a function pointer and the
kernel executed it? Eh? It would continue to execute userspace
controlled code.

> >
> > In my opinion, this should be forbidden by disallowing mmapping
> > to address 0. A NULL pointer dereference is such a common bug, that
> > it is worth protecting against.
> > Besides that, I currently don't see a valid reason to mmap address 0.
> >
> 
> That's where the real-mode BIOS table is. Who says that I can't
> look at any piece of physical memory I want. It's my machine.

Doing it in the kernel and not from unprivileged user processes
would be a good idea for this anyway...

> The whole concept of a NULL pointer is simply an artifact of
> incorrect engineering.

I do _NOT_ complain about the NULL pointer. You simply did not get
my point.

-- 
Greetings Michael.
