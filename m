Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSHCVaV>; Sat, 3 Aug 2002 17:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317879AbSHCVaV>; Sat, 3 Aug 2002 17:30:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50960 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317874AbSHCVaU>;
	Sat, 3 Aug 2002 17:30:20 -0400
Message-ID: <3D4C4E7A.C6707A4C@zip.com.au>
Date: Sat, 03 Aug 2002 14:43:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <3D4B692B.46817AD0@zip.com.au> <Pine.LNX.4.44L.0208031803050.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 2 Aug 2002, Andrew Morton wrote:
> 
> > No joy, I'm afraid.
> 
> > Guess we should instrument it up and make sure that the hashing
> > and index thing is getting the right locality.
> 
> Could it be that your quad needs to go to RAM to grab a cacheline
> that's exclusive on the other CPU while Daniel's machine can just
> shove cachelines from CPU to CPU ?

Could be, Rik.  I don't know.  It's a bit worrisome that we might
be dependent on subtleties like that.

> What I'm referring to is the fact that the pte_chain_locks in
> Daniel's patch are all packed into a few cachelines, instead of
> having each lock on its own cache line...
> 
> This could explain the fact that the locking overhead plummeted
> on Daniel's box while it didn't change at all on your machine.

Oh it helped a bit.   More in 2.4 than 2.5.  Possibly I broke 
Daniel's patch somehow.    But even the improvement in 2.4
from Daniel's patch is disappointing.
