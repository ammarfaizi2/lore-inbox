Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSKDEaG>; Sun, 3 Nov 2002 23:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbSKDEaG>; Sun, 3 Nov 2002 23:30:06 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:51355 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S263321AbSKDEaF>; Sun, 3 Nov 2002 23:30:05 -0500
Date: Sun, 03 Nov 2002 22:36:03 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>
Message-Id: <20021103222552.DAFE.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop016.verizon.net from [138.89.32.225] at Sun, 3 Nov 2002 22:36:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Nov 2002 20:04:32 -0800
Andrew Morton <akpm@digeo.com> mentioned:
> > From my patch, about the speed:
> > for PIII/4 CPU -> no change. using the same 2.5.45 copy.
> > for old i386 -> more optimal.
> > for Athlon -> 2.5.45 does not use unrolled copy for it either.
> 
> OK.  Please integrate you patch into the current kernel's usercopy.c.

I will make a revised patch, remove inline and putting inside usercopy.c

> The thing which requires some thought is "should the decision
> be made at compile time or runtime".  For Athlon vs Intel
> and i386 vs others, it should be performed at compile time.

I run faster_intel_copy on my Athlon and works OK and much much faster,
so how about grouping CPU type,

generic i386/i486
  use org REP MOVSL copy
generic i586
  keep as the current 5.45
  use revised REP MOVSL copy 
generic i686
  use revised REP MOVSL copy and unrolled MOVL
if SSE or 3DNOW comes out select them by MPENTIUMIII/4/K7



