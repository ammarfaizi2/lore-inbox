Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265021AbUFANIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbUFANIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUFANIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:08:12 -0400
Received: from zero.aec.at ([193.170.194.10]:64518 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265021AbUFANIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:08:06 -0400
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: compat syscall args
References: <21hGW-h5-5@gated-at.bofh.it> <229Hi-B1-11@gated-at.bofh.it>
	<22drH-3Bc-47@gated-at.bofh.it> <22dL7-3O8-39@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 01 Jun 2004 15:07:57 +0200
In-Reply-To: <22dL7-3O8-39@gated-at.bofh.it> (David S. Miller's message of
 "Tue, 01 Jun 2004 11:30:21 +0200")
Message-ID: <m38yf7juj6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> Personally I think it makes more sense to do what sparc64 does
> which is:
>
> 1) The syscall32 entry code extends each arg in a fixed way.
>    Ie. arg0-3 are zero-extended, arg4-5 are sign-extended
>    or whatever.  I posted the choices we use on sparc64 just
>    the other day.

I don't see where you find that many arguments that need
sign extension? iirc they are quite rare.


> 2) For each syscall where this default set of extensions is
>    not correct, little assembler or C stubs are used to correct
>    the extensions made by the default code.
>
> It is the most optimal solution.  We only need 13 or so stubs
> on sparc64 with the defaults we've choosen.

It would be better to do this consistently over all architectures
and do the sign extension (which is much less common than zero
extension) always in C code. Then when someone adds a new compat
handler the chances are high that it will just work over multiple
architectures (ok minus s390) without much more changes. 

Actually if someone demonstrated that doing sign extension in assembly
helps a lot then I would not be opposed to doing it on x86-64 
too just for consistency.

I would be actually not against doing the s390 compat_uptr() changes
in C too, although it wouldn't help them with the "one handler
for everybody" goal, since it can be only tested on s390.

-Andi

