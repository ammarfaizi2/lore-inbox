Return-Path: <linux-kernel-owner+w=401wt.eu-S1762896AbWLKNOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762896AbWLKNOz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762901AbWLKNOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:14:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60230 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762896AbWLKNOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:14:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <457D559C.2030702@garzik.org> 
References: <457D559C.2030702@garzik.org>  <29447.1165840536@redhat.com> 
To: Jeff Garzik <jeff@garzik.org>
Cc: David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Mark bitrevX() functions as const 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 11 Dec 2006 13:14:42 +0000
Message-ID: <15033.1165842882@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:

> * overall, I agree with this type of change.  several Linux lib functions
> could use this sort of annotation.

Yes.  I just happened to notice bitrev.c at the end of my git pull and wondered
if it was what it sounded like...

> * I question its usefulness on static [inline] functions, because the compiler
> should be able to figure out side effects.  have you examined before-and-after
> asm to see if the code generation changes for the inlined area?

It doesn't actually make any difference, but I think such functions should be
so marked anyway: it gives both the code writer and the compiler more
information (though they're both free to ignore it if they like).

> * naked __attribute__ is ugly.  define something short and memorable in
> include/linux/compiler.h.

I'm not sure that's a good idea.  You have to be careful not to cause confusion
with ordinary "const".

> * another annotation to consider is C99 keyword 'restrict'.

Indeed, though I presume you don't mean in this particular case...

David
