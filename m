Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSHKSdj>; Sun, 11 Aug 2002 14:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSHKSdj>; Sun, 11 Aug 2002 14:33:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55310 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318008AbSHKSdj>;
	Sun, 11 Aug 2002 14:33:39 -0400
Message-ID: <3D56B13A.D3F741D1@zip.com.au>
Date: Sun, 11 Aug 2002 11:47:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
References: <3D56147E.15E7A98@zip.com.au> <1029095396.16216.18.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Sun, 2002-08-11 at 08:38, Andrew Morton wrote:
> > This information loss is unfortunate.  Examples:
> >
> >       for (i = 0; i < N; i++)
> >               prefetch(foo[i]);
> >
> >    Problem is, if `prefetch' is a no-op, the compiler will still
> >    generate an empty busy-wait loop.  Which it must do.
> 
> Why - nothing there is volatile

Because the compiler sees:

	for (i = 0; i < N; i++)
		;

and it says "ah ha.  A busy wait delay loop" and leaves it alone.

It's actually a special-case inside the compiler to not optimise
away such constructs.
