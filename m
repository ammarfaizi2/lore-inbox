Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316803AbSFLW05>; Wed, 12 Jun 2002 18:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317337AbSFLW04>; Wed, 12 Jun 2002 18:26:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27326 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316803AbSFLW04>;
	Wed, 12 Jun 2002 18:26:56 -0400
Date: Wed, 12 Jun 2002 18:26:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <20020612175127.A4081@redhat.com>
Message-ID: <Pine.GSO.4.21.0206121824140.16357-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Benjamin LaHaise wrote:

> On Sun, Jun 09, 2002 at 08:56:30PM -0700, Dawson Engler wrote:
> > Here are 37 errors where variables >= 1024 bytes are allocated on a function's
> > stack.
> 
> Is it possible to get checker to determine the stack depth of a worst 
> case call chain (excluding interrupts)?  I've found that deep call chains 
> are far more likely to cause stack overflows than short and bounded paths.

Not realistic - we have a recursion through the ->follow_link(), and
a lot of stuff can be called from ->follow_link().  We _do_ have a
limit on depth of recursion here, but it won't be fun to deal with.

