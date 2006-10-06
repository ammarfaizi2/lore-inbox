Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWJFO4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWJFO4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWJFO4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:56:00 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:50854
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1422694AbWJFOzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:55:44 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Fri, 6 Oct 2006 16:55:32 +0200
User-Agent: KMail/1.9.4
References: <200610052059.11714.mb@bu3sch.de>
In-Reply-To: <200610052059.11714.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061655.32249.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, some people have good points against special casing
address 0 here. That's fine.
But: I think, if we don't protect from remapping address 0,
we should _really_ take NULL pointer dereference bugs more serious.
Every NULL pointer dereference bug should be checked for the
possibility of unprivileged users controlling the kernel.
I think currently NULL pointer dereferece bugs are not seen as
a security vulnerability by most people. In future we
should look at the bugs more closely and check if this is a
security vulnerability or just a "crash my app" bug.


On Thursday 05 October 2006 20:59, Michael Buesch wrote:
> Hi,
> 
> This question has already been discussed here in the past, but
> we did not come to a good result. So I want to ask the question again:
> 
> Is is really a good idea to allow processes to remap something
> to address 0?
> I say no, because this can potentially be used to turn rather harmless
> kernel bugs into a security vulnerability.
> 
> Let's say we have some kernel NULL pointer dereference bug somewhere,
> that's rather harmless, if it happens in process context and
> does not leak any resources on segfaulting the triggering app.
> So the worst thing that happens is a crashing app. Yeah, this bug must
> be fixed. But my point is that this bug can probably be used to
> manipulate the way the kernel works or even to inject code into
> the kernel from userspace.
> 
> Attached to this mail is an example. The kernel module represents
> the actual "kernel-bug". Its whole purpose in this example is to
> introduce a user-triggerable NULL pointer dereference.
> Please stop typing now, if you are typing something like
> "If you can load a kernel module, you have access to the kernel anyway".
> This is different. We always _had_ and most likely _have_ NULL pointer
> dereference bugs in the kernel.
> 
> The example programm injects a magic value 0xB15B00B2 into the
> kernel, which is printk'ed on success.
> 
> In my opinion, this should be forbidden by disallowing mmapping
> to address 0. A NULL pointer dereference is such a common bug, that
> it is worth protecting against.
> Besides that, I currently don't see a valid reason to mmap address 0.
> 
> Comments?
> 

-- 
Greetings Michael.
