Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbSLRCUS>; Tue, 17 Dec 2002 21:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSLRCUS>; Tue, 17 Dec 2002 21:20:18 -0500
Received: from dp.samba.org ([66.70.73.150]:3467 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267106AbSLRCUR>;
	Tue, 17 Dec 2002 21:20:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] : More module parameter compatibility for 2.5.52 
In-reply-to: Your message of "Tue, 17 Dec 2002 09:33:46 -0800."
             <20021217173346.GA22924@bougret.hpl.hp.com> 
Date: Wed, 18 Dec 2002 13:24:57 +1100
Message-Id: <20021218022816.E2EC52C2CE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021217173346.GA22924@bougret.hpl.hp.com> you write:
> On Tue, Dec 17, 2002 at 03:20:10PM +1100, Rusty Russell wrote:
> > I prefer the fix below.  Does it work for you?
> > 
> > Rusty.
> 
> 	With all due respect, your fix is quite ugly.

Yes.

> 	And think about it this way : your new param architecture is
> supposed to be flexible and supposed to allow modules to get
> parameters in any shape or form. But, on the other hand, it's
> impossible to implement something as simple as 'c' without ugly hacks.

'c' is trivial.  1-20c50, which is a the two dimensional array of
variable bounds, which is outside the scope of current param_array
implementation (which was designed to handle 1d arrays).

> 	Maybe we can deduct from this that the new param API is not
> flexible enough and that the simple addition of an opaque type (priv)
> can have some value.

They *do* have a mechanism to pass extra parameters (kp->arg), it's
just that the standard "param_array" code already uses it to hand the
address of the variable.  Your patch added a second one.

The new param code was not meant to do *everything*, it was meant to
add type safety and unification of boot and module parameters, and
allow extensibility.

I think you're confusing "param_array() doesn't handle 2d arrays" with
"infrastructure not powerful enough".  Since __module_param_call() is
functionally equivalent to __setup(), the second one seems unlikely.

Writing such an extension is a job for the next mail...

Does that clarify?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
