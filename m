Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUEFTYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUEFTYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUEFTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:24:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51629 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262538AbUEFTXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:23:41 -0400
Message-Id: <200405061923.i46JN97u006324@eeyore.valparaiso.cl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] get rid of "+m" constraint in i386 rwsems 
In-Reply-To: Your message of "Thu, 06 May 2004 14:24:54 +0100."
             <20040506142454.C29621@flint.arm.linux.org.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 06 May 2004 15:23:09 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> said:

[...]

> After reading Richard's post, I wonder if, in the case of:
> 
> 	"=m" (x) : "m" (x)
> 
> whether assembly should assume that %0 is the same as %1.  Do they
> just happen to be the same thing?  I'm thinking of the case where
> there may be two different ways GCC may reference the same memory
> location.

It also might be a "memory location" that isn't really in memory (a local
variable whose value resides in one register up to your asm() fragment, and
from then on in another one or in memory; it might also be useful to load a
value into a register from memory and restore it into memory after sundry
manipulations, and even from a different register, much later).

Today's compilers don't necessarily do things the way a naive understanding
of the source language would say they do. Ever wonder why nobody uses
"register" anymore (compilers are smarter than binding one value to a
register today), and why fiddling with pointers when accessing arrays is
not standard fare (compilers optimize the (bulky, slow) array accesses via
indices out as a matter of course)?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
