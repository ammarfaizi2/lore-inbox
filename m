Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWJ1AAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWJ1AAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 20:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWJ1AAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 20:00:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:40303 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWJ1AAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 20:00:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I86eqnVB+zLD+CYQIvqXv6Lv6n2BqW2Fo9nWjKhQWTz2Wk4B7wPtYmA+24b0BVxp0pMLwcfKr0F2E2qihmsqYKL6LIAur7oKHQg8dxWKE2ZU6UKfGyjvh06OptSQAy6iVnnTlGsvEN7h7GOVgkDGF9Qh4llwtUUbozvDfj9ioiU=
Message-ID: <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com>
Date: Sat, 28 Oct 2006 02:00:11 +0200
From: "Luca Tettamanti" <kronos.it@gmail.com>
To: "thockin@hockin.org" <thockin@hockin.org>
Subject: Re: AMD X2 unsynced TSC fix?
Cc: "Lee Revell" <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       "Andi Kleen" <ak@suse.de>, "john stultz" <johnstul@us.ibm.com>
In-Reply-To: <20061027230458.GA27976@hockin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161969308.27225.120.camel@mindpipe>
	 <20061027201820.GA8394@dreamland.darkstar.lan>
	 <20061027230458.GA27976@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/06, thockin@hockin.org <thockin@hockin.org> wrote:
> On Fri, Oct 27, 2006 at 10:18:20PM +0200, Luca Tettamanti wrote:
> > There's always a window where the TSCs are not in sync (and userspace may
> > see a non-monotonic counter); furthermore when C'n'Q is active TSCs
> > aren't updated at a fixed frequency, userspace cannot use TSC for timing
> > anyway.
>
> Wrong, too.  We have a patch that will be coming SOON (trust me, I am
> pushing hard for the author to publish it).  With this patch applied you
> should never see the TSC go backwards.  Period.  It should be monotonic
> (to userspace, kernel rdtsc calls can still be wrong).  CPUs should stay
> very nearly in sync (again, to userspace).  The overhead of this patch is
> pretty minimal and costs nothing unless you actually read the TSC.

I know that's it's possible to resync the TSCs, but:

> The catch is that, while it is monotonic, it is not guaranteed to be
> perfectly linear.  For many applications, this will be good enough.  Time
> will always move forward, and you won't be subject to the weird HZ
> granularity gettimeofday that unsynced TSCs can show.

As you say you cannot use it to do timing unless you disable any power
management on the CPU. Otherwise you can count the elapsed ticks but
you cannot convert the number to anything meaningful.
You may be able to emulate rdtsc for userspace but then again the
whole point of using rdtsc is that it should be uber-fast... if rdtsc
is emulated then you can just use gettimeofday (which is also
optimized to be *very* fast). No?

Luca
