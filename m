Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282094AbRKWJqR>; Fri, 23 Nov 2001 04:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282095AbRKWJqB>; Fri, 23 Nov 2001 04:46:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50367 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282094AbRKWJok>; Fri, 23 Nov 2001 04:44:40 -0500
Message-Id: <200111230944.fAN9ib421870@eng4.beaverton.ibm.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove needless BKL from release functions 
In-Reply-To: Your message of "Thu, 22 Nov 2001 09:30:06 -0300."
             <200111221230.fAMCU6QJ007258@pincoya.inf.utfsm.cl> 
Date: Fri, 23 Nov 2001 01:44:36 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@ns.caldera.de> said:

    Nope, it's fine to remove it.  Input is racy all over the place and the list
    are modified somewhere else without any locking anyways.
    
Horst von Brand <vonbrand@inf.utfsm.cl> then said:

    "It is broken anyway, breaking it some more makes no difference"!?

No, it is more a matter of "it is not helping at all, so removing it
makes no difference in behavior."  Removing it does, however, help
clean up the code and remove unnecessary instances of the BKL from the
kernel code.

If you check the web page at
http://lse.sourceforge.net/lockhier/patches.html, you'll find
additional information on why this patch was produced.  The most common
"no-op" was that (BKL) locking was done during release but not during
open. In some cases, there truly are things to guard. In some cases,
there really isn't. In all cases, nothing was really being correctly
guarded.

Usage of the BKL exists, in many cases, as a legendary artifact. Nobody
is sure if it's really needed, so everybody is afraid to take it out,
"just in case".  These patches represent real research -- we believe it
really is safe to take it out in these cases.  If we could not be sure,
we didn't try to patch it.

Rick
