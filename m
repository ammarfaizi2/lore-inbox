Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290956AbSAaFtv>; Thu, 31 Jan 2002 00:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSAaFtl>; Thu, 31 Jan 2002 00:49:41 -0500
Received: from are.twiddle.net ([64.81.246.98]:34455 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S290956AbSAaFti>;
	Thu, 31 Jan 2002 00:49:38 -0500
Date: Wed, 30 Jan 2002 21:49:35 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
Message-ID: <20020130214935.A7479@are.twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Richard Henderson <rth@twiddle.net>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
In-Reply-To: <20020130002204.A4480@are.twiddle.net> <E16W3U9-0004Pd-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16W3U9-0004Pd-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Thu, Jan 31, 2002 at 09:45:45AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 09:45:45AM +1100, Rusty Russell wrote:
> "better".  Believe me, I was fully aware, but I refuse to write such
> crap unless *proven* to be required.

You're going to wait until the compiler generates incorrect
code for you after knowing that it *probably* will?  Nice.

> I agree that this is much better.  But do not understand what small
> relocs have to do with simple address arithmetic?  You've always been
> right before: what am I missing?

"Small" variables may be positioned by the compiler such that
they are addressable via a 16-bit relocation from some GP register.
If that variable isn't actually located in the small data area,
then the 16-bit relocation may overflow, resulting in link errors.

So it isn't a matter of the arithmetic itself, but loading the
addresses with which to do the arithmetic.

By declaring the variable to be an array of unspecified size,
you're giving the compiler no information as to the size of the
variable, and so it cannot assume the variable is located in the
small data area.


r~
