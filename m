Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSKYCBR>; Sun, 24 Nov 2002 21:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSKYCBR>; Sun, 24 Nov 2002 21:01:17 -0500
Received: from almesberger.net ([63.105.73.239]:44550 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262324AbSKYCBQ>; Sun, 24 Nov 2002 21:01:16 -0500
Date: Sun, 24 Nov 2002 23:07:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ
Message-ID: <20021124230758.A1549@almesberger.net>
References: <20021118233047.P1407@almesberger.net> <20021125003005.15F762C095@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125003005.15F762C095@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Nov 25, 2002 at 09:50:46AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Q: But the modules' init routine calls my register() routine which
>    wants to call back into one of the function pointers immediately,
>    and so try_module_get() fails! (because the module is not finished
>    initializing yet)
> A: You're being called from the module, so someone already has a
>    reference (unless there's a bug), so you don't need a
>    try_module_get().

Hmm, I wouldn't call this the answer. How about:
 - Q: why does it fail ?
 - A: because you're initializing
 - solution: but since you're calling from a module, and the call
   goes back to the same module, you don't have to worry

This raises the question: why is this a special case ? The
registration function shouldn't have to know all these details.
(That's the whole point of try_module_get, isn't it ?)

Wouldn't it be possible to simply allow try_module_get also
while the module is initializing ?

> Well, if we continue to start modules unisolated, I need to rewrite
> the FAQ anyway...

Does "unisolated" mean that try_module_get would work ? If yes,
you've already solved the problem ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
