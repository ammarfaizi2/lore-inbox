Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWDZUoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWDZUoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWDZUoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:44:22 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:18959 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932121AbWDZUoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:44:21 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <torvalds@osdl.org>, "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: C++ pushback
Date: Wed, 26 Apr 2006 13:43:57 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEOELIAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 26 Apr 2006 13:39:57 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 26 Apr 2006 13:39:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus wrote:

> On Wed, 26 Apr 2006, Jan-Benedict Glaw wrote:

> > There's one _practical_ thing you need to keep in mind: you'll either
> > need 'C++'-clean kernel headers (to interface low-level kernel
> > functions) or a separate set of headers.

> I suspect it would be easier to just do
>
> 	extern "C" {
> 	#include <linux/xyz.h>
> 	...
> 	}

> instead of having anything really C++'aware in the headers.

	I agree. This could include things like:

#define class class_

	You'd need two includes, one that goes first and one that goes last (to
undefine these things). Yeah, it's ugly, but it imposes the minimum cost on
those who don't care.

> If by "clean" you meant that the above works, then yeah, there might be
> _some_ cases where we use C++ keywords etc in the headers, but
> they should
> be pretty unusual and easy to fix.

	They can be fixed ugly ways or nice ways, depending on a cost/benefit
analysis.

> The real problem with C++ for kernel modules is:
>
>  - the language just sucks. Sorry, but it does.
>  - some of the C features we use may or may not be usable from C++
>    (statement expressions?)
>  - the compilers are slower, and less reliable. This is _less_ of
> an issue
>    these days than it used to be (at least the reliability part),
> but it's
>    still true.
>  - a lot of the C++ features just won't be supported sanely (ie
> the kernel
>    infrastructure just doesn't do exceptions for C++, nor will it run any
>    static constructors etc).

	I would phrase the argument as such: any project that can really benefit
from what C++ adds to C is probably too big and complex to belong in the
kernel. Better to do what you need to get it out of the kernel.

	A better project might be some compromise between kernel space and user
space that doesn't abuse the kernel stack and where things like exceptions
can be supported.

> Anyway, it should all be doable. Not necessarily even very hard. But I
> doubt it's worth it.

	If FUSE made it so that you could just as well put a filesystem in user
space as kernel space, I'd agree with you. File systems are the only kernel
drivers I can think of that can justify sufficient complexity to get much
benefit from C++. This may change though, and this could just be a lack of
imagination on my part.

	By the way, I am not a proponent of C++ in the kernel or of making changes
to the kernel to support C++. I'm just someone who labels bullshit as such
when he sees it.

	DS


