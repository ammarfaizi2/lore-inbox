Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWDZUJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWDZUJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWDZUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:09:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964858AbWDZUJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:09:45 -0400
Date: Wed, 26 Apr 2006 13:09:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Subject: Re: C++ pushback
In-Reply-To: <20060426200134.GS25520@lug-owl.de>
Message-ID: <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com>
 <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Apr 2006, Jan-Benedict Glaw wrote:
> 
> There's one _practical_ thing you need to keep in mind: you'll either
> need 'C++'-clean kernel headers (to interface low-level kernel
> functions) or a separate set of headers.

I suspect it would be easier to just do

	extern "C" {
	#include <linux/xyz.h>
	...
	}

instead of having anything really C++'aware in the headers.

If by "clean" you meant that the above works, then yeah, there might be 
_some_ cases where we use C++ keywords etc in the headers, but they should 
be pretty unusual and easy to fix.

The real problem with C++ for kernel modules is:

 - the language just sucks. Sorry, but it does.
 - some of the C features we use may or may not be usable from C++ 
   (statement expressions?)
 - the compilers are slower, and less reliable. This is _less_ of an issue 
   these days than it used to be (at least the reliability part), but it's 
   still true.
 - a lot of the C++ features just won't be supported sanely (ie the kernel 
   infrastructure just doesn't do exceptions for C++, nor will it run any 
   static constructors etc).

Anyway, it should all be doable. Not necessarily even very hard. But I 
doubt it's worth it.

		Linus
