Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbSJ2UlV>; Tue, 29 Oct 2002 15:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJ2UlV>; Tue, 29 Oct 2002 15:41:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26241 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S262290AbSJ2UlU>; Tue, 29 Oct 2002 15:41:20 -0500
Subject: Re: [BENCHMARK] AIM Independent Resource Benchmark  results for
	kernel-2.5.44
From: "Timothy D. Witham" <wookie@osdl.org>
To: John Hawkes <hawkes@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <015e01c27f86$a42d4290$9865fea9@PCJohn>
References: <fa.e2emdkv.j1ksaf@ifi.uio.no> <fa.f6uq3iv.232305@ifi.uio.no>
	 <015e01c27f86$a42d4290$9865fea9@PCJohn>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1035924383.1427.79.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 29 Oct 2002 12:46:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  But then I fixed the code with the compile option.  But
I agree I don't like floating point code that looks for
equality with zero to end a loop.  I would much rather
have the code to for a fixed <= number as that prevents
the issue with "how close to zero" on your system.  

  History lesson.  In the very old days this benchmark
caused many a math library to be changed because different
architectures had different ideas as to how close to
zero you had to be before a floating point number was
considered zero and some people ran a lot more iterations
than other folks for the same test.  The response was
"Well that is an implementation detail and it does
matter to folks as they write code to test for convergence."
I guess they went to a cheaper school than I did. :-)

  Of course that was when it took a 20 processor system
to get over 100 users. :-)

  But if we are looking at this test overall maybe we 
should be considering how to update it for systems
that have changed so much over the years. For
example the fakeh.tar file is only 192 KB.  Heck
that is the size of some single documents these days.

Tim

On Tue, 2002-10-29 at 12:06, John Hawkes wrote:
> From: "Jakob Oestergaard" <jakob@unthought.net>
> ...[snip]...
> > The correct way to terminate that loop is, like was already suggested,
> > doing a comparison to see if the residual is "numerically zero" or
> > "sufficiently zero-ish for the given purpose". Eg.  "delta < 1E-12" or
> > eventually "fabs(delta) < 1E-12".
> 
> Tim Witham at the OSDL told me that he ran some experiments with
> different convergent deltas:
> 
>   zero Rate (ops/sec) Iteration Rate
>  10-6    331,300    1656.5
>  10-8    315,049    1575.0
>  10-10    302,000    1510.0
>  10-12    292,300    1461.5
>  10-14    285,400    1427.0
> 
> Anything smaller than 10-14 didn't converge.
> 
> 
> --
> John Hawkes
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

