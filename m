Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSJ1OlP>; Mon, 28 Oct 2002 09:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbSJ1OlO>; Mon, 28 Oct 2002 09:41:14 -0500
Received: from fmr02.intel.com ([192.55.52.25]:13249 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261242AbSJ1OlN>; Mon, 28 Oct 2002 09:41:13 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE730A@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel using Intel compiler (lmben
	 ch data)
Date: Mon, 28 Oct 2002 06:47:27 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think people need to use PGO for day-to-day development or
debugging. Rather, it would be used only for systems deployed for actual
use. For example, various kernel binaries optimized for particular use, such
as database, web server, file server, embedded systems, etc, can be
distributed as RPM (with profile feedback data). 

For development we should such profile feedback data to optimize the kernel
in source code level (i.e by hand). I don't know the data in gcc has any
clue for that.

Jun
-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Friday, October 25, 2002 11:27 PM
To: Nakajima, Jun
Cc: Andi Kleen; David S. Miller; torvalds@transmeta.com;
linux-kernel@vger.kernel.org; Mallick, Asit K; Saxena, Sunil
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
(lmben ch data)


On Fri, Oct 25, 2002 at 07:16:49PM -0700, Nakajima, Jun wrote:
> pgoipo -- P70 + PGO (profile-guided optimization) + IPO (interprocedural
> optimization)

That is interesting. I assume you built a custom profiling driver for this.

One problem I see is that profile feedback will make the kernel images much
less
predictible. Currently we need a vmlinux that matches the built kernel
to analyze any oopses etc. When there are small changes (bugfixes etc.)
the functions are still near enough that an oops can be meaningfully
looked at. But with profile based feedback this could completely change -
at least in gcc the profile feedback data has to exactly match the compiled
program. Now when I would change a single line I would need to reprofile
and then the resulting kernel could be totally different with every single
instruction changed, making it impossible to make any sense out of a 
ksymoops. This could be a major problem for bug processing on linux-kernel
because the chances are small that I look at a vmlinux that is in any 
way related to what the user has.

One way around would be to switch to lkcd crash images which include all
kernel code, but it could be a major problem to send them to a mailing list 
because they're so big.

-Andi
