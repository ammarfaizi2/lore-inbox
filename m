Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSKSCYA>; Mon, 18 Nov 2002 21:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKSCYA>; Mon, 18 Nov 2002 21:24:00 -0500
Received: from almesberger.net ([63.105.73.239]:46597 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265008AbSKSCX7>; Mon, 18 Nov 2002 21:23:59 -0500
Date: Mon, 18 Nov 2002 23:30:47 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ
Message-ID: <20021118233047.P1407@almesberger.net>
References: <20021118230821.8F3822C241@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118230821.8F3822C241@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Nov 19, 2002 at 09:58:56AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Q: When does try_module_get(owner) fail?
> A: When the module is not ready to be entered (ie. still in
>    init_module) or it is being removed.  It fails to prevent you
>    entering the module as it is being discarded (init might fail, or
>    it's being removed).

I'd suggest "It fails in order to [...]" to avoid the "does work
exactly NOT as advertised" ambiguity ;-)

> Q: But modules call my register() routine which wants to call back
>    into one of the function pointers immediately, and so
>    try_module_get() fails!
> A: You're being called from the module, so someone already has a
>    reference (unless there's a bug), so you don't need a
>    try_module_get().

Hmm, I haven't really looked at your new code, but this sounds as
if try_module_get gets an exclusive lock. Is this true ? Doesn't
seem to make sense to me.

> Hope that helps?

Don't you want to repeat the golden rule at the end, just as a
polite reminder ? :-) (Just kidding.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
