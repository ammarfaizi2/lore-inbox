Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318344AbSHKUFO>; Sun, 11 Aug 2002 16:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318345AbSHKUFO>; Sun, 11 Aug 2002 16:05:14 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:42956 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318344AbSHKUFO>; Sun, 11 Aug 2002 16:05:14 -0400
Date: Sun, 11 Aug 2002 21:07:18 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: gcc@gcc.gnu.org, Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: GCC still keeps empty loops?  (was: [patch 4/21] fix ARCH_HAS_PREFETCH)
Message-ID: <20020811210718.B3206@kushida.apsleyroad.org>
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.LNX.4.44.0208111203520.9930-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208111203520.9930-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Aug 11, 2002 at 12:06:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I thought that special case was removed long ago, because it is untenable 
> in C++ etc (where such empty loops happen due to various abstraction 
> issues, and not optimizing them away is just silly).
> 
> But testing shows that you're right at least for 2.95 and 2.96. Argh

Unbelievably, 3.1 doesn't remove empty loops either.
I think there's a case for a compiler flag, `-fremove-empty-loops'.

Empty loop delays aren't portable acrosss compilers in general.  If you
_really_ want an empty loop that must always work with GCC, it's easy
enough to write:

	for (i = 0; i < 100000; i++)
		__asm__ __volatile__ ("");

-- Jamie
