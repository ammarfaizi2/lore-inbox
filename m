Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSJZGVI>; Sat, 26 Oct 2002 02:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbSJZGVI>; Sat, 26 Oct 2002 02:21:08 -0400
Received: from ns.suse.de ([213.95.15.193]:31245 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261874AbSJZGVI>;
	Sat, 26 Oct 2002 02:21:08 -0400
Date: Sat, 26 Oct 2002 08:27:23 +0200
From: Andi Kleen <ak@suse.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler (lmben ch data)
Message-ID: <20021026082723.C23915@wotan.suse.de>
References: <F2DBA543B89AD51184B600508B68D4000ECE70F1@fmsmsx103.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000ECE70F1@fmsmsx103.fm.intel.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 07:16:49PM -0700, Nakajima, Jun wrote:
> pgoipo -- P70 + PGO (profile-guided optimization) + IPO (interprocedural
> optimization)

That is interesting. I assume you built a custom profiling driver for this.

One problem I see is that profile feedback will make the kernel images much less
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
