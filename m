Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289117AbSAJBr0>; Wed, 9 Jan 2002 20:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289118AbSAJBrQ>; Wed, 9 Jan 2002 20:47:16 -0500
Received: from mulga.cs.mu.OZ.AU ([128.250.1.22]:56049 "EHLO mulga.cs.mu.OZ.AU")
	by vger.kernel.org with ESMTP id <S289117AbSAJBrH>;
	Wed, 9 Jan 2002 20:47:07 -0500
Date: Thu, 10 Jan 2002 12:47:02 +1100
From: Fergus Henderson <fjh@cs.mu.OZ.AU>
To: Peter Barada <pbarada@mail.wm.sps.mot.com>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020110124702.B30669@hg.cs.mu.oz.au>
In-Reply-To: <20020108012734.E23665@werewolf.able.es> <20020109204043.T1027-100000@gerard> <20020110004952.A11641@werewolf.able.es> <200201100019.g0A0JOM32110@hyper.wm.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201100019.g0A0JOM32110@hyper.wm.sps.mot.com>; from pbarada@mail.wm.sps.mot.com on Wed, Jan 09, 2002 at 07:19:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-Jan-2002, Peter Barada <pbarada@mail.wm.sps.mot.com> wrote:
> 
> If the code is:
> 
> int b;
> void stuff()
> {
>   volatile const a=5;
> 
>   b = a - a;
> }
> 
> Then the code can be optimized to 'b = 0;'

No, you're wrong here.  That would violate the following provisions of
the C99 standard, because the two accesses to `a' would not have occurred.
(It would also violate similar provisions of the C89 and C++ standards.)
The "as if" rule -- which is stated in 5.1.2.3 [#3] in C99 -- is explicitly
defined to NOT allow optimizing away accesses to volatile objects.

 |        5.1.2.3  Program execution
 ...
 |        [#2]  Accessing  a  volatile  object,  modifying  an object,
 |        modifying a file, or calling a function  that  does  any  of
 |        those  operations are all side effects
 ...
 |        [#3] In the abstract machine, all expressions are  evaluated
 |        as  specified  by  the  semantics.  An actual implementation
 |        need not evaluate part of an expression  if  it  can  deduce
 |        that  its  value is not used and that no needed side effects
 |        are produced (including any caused by calling a function  or
 |        accessing a volatile object).
 ...
 |        [#5] The least requirements on a  conforming  implementation
 |        are:
 | 
 |          -- At  sequence points, volatile objects are stable in the
 |             sense  that  previous   accesses   are   complete   and
 |             subsequent accesses have not yet occurred.

-- 
Fergus Henderson <fjh@cs.mu.oz.au>  |  "I have always known that the pursuit
The University of Melbourne         |  of excellence is a lethal habit"
WWW: <http://www.cs.mu.oz.au/~fjh>  |     -- the last words of T. S. Garp.
