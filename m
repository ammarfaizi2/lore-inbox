Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWJGRuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWJGRuA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWJGRt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:49:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932458AbWJGRtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:49:55 -0400
Date: Sat, 7 Oct 2006 10:49:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minimal alpha pt_regs fixes
In-Reply-To: <4527C2F7.2010102@garzik.org>
Message-ID: <Pine.LNX.4.64.0610071042220.3952@g5.osdl.org>
References: <20061007131731.GC29920@ftp.linux.org.uk> <4527C2F7.2010102@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Oct 2006, Jeff Garzik wrote:
> 
> ACK, of course, but I wonder if we can do something about these 1-line header
> files.
> 
> Would it be reasonable to encourage developers to do something like
> 
> 	#ifdef ARCH_HAVE_FEATURE_FOO
> 	#include <asm/foo.h>
> 	#else
> 	#include <asm-generic/foo.h>
> 	#endif
> 
> to avoid these 1-line headers?

I actually think that _unconditional_ simple code is much nicer than 
conditional one.

With the current setup, we have a number of one-line trivial headers 
(which actually could be symlinks - the only downside of that is that 
regular "patch" doesn't really know about them, even if git does, and can 
handle them, including the "extended git patch" format). They are 
unconditional, so following them never implies having to grep for 
different architectures doing different things.

I personally absolutely detest the "ARCH_HAVE_FEATURE_FOO" kind of thing 
that makes different architectures behave differently. I'd much rather 
have a few small and simple files that all look the same and are totally 
obvious, except for the odd architecture that actually caused the 
arch-split in the first place.

(Also, if the files really _are_ entirely identical, at least it won't add 
any overhead at all to git - they'll all use the same backing store)

		Linus
