Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267995AbSISNSj>; Thu, 19 Sep 2002 09:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268100AbSISNSj>; Thu, 19 Sep 2002 09:18:39 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:36358 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S267995AbSISNSi>;
	Thu, 19 Sep 2002 09:18:38 -0400
Date: Thu, 19 Sep 2002 22:15:13 +0900 (JST)
Message-Id: <20020919.221513.28808421.taka@valinux.co.jp>
To: akpm@digeo.com
Cc: alan@lxorguk.ukuu.org.uk, davem@redhat.com, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D89176B.40FFD09B@digeo.com>
References: <20020918.160057.17194839.davem@redhat.com>
	<1032393277.24895.8.camel@irongate.swansea.linux.org.uk>
	<3D89176B.40FFD09B@digeo.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > > details, but I do know that using copy_from_user() is not a real
> > > improvement at least on x86 architecture.
> > 
> > The same as bit is easy to explain. Its totally memory bandwidth limited
> > on current x86-32 processors. (Although I'd welcome demonstrations to
> > the contrary on newer toys)
> 
> Nope.  There are distinct alignment problems with movsl-based
> memcpy on PII and (at least) "Pentium III (Coppermine)", which is
> tested here:
...
> I have various scriptlets which generate the entire matrix.
> 
> I think I ended up deciding that we should use movsl _only_
> when both src and dsc are 8-byte-aligned.  And that when you
> multiply the gain from that by the frequency*size with which
> funny alignments are used by TCP the net gain was 2% or something.

Amazing! I beleived 4-byte-aligned was enough.
read/write systemcalls may also reduce their penalties.

> It needs redoing.  These differences are really big, and this
> is the kernel's most expensive function.
> 
> A little project for someone.

OK, if there is nobody who wants to do it I'll do it by myself.

> The tools are at http://www.zip.com.au/~/linux/cptimer.tar.gz

