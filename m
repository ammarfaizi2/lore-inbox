Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSGUBiu>; Sat, 20 Jul 2002 21:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSGUBiu>; Sat, 20 Jul 2002 21:38:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9110 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317180AbSGUBit>;
	Sat, 20 Jul 2002 21:38:49 -0400
Date: Sat, 20 Jul 2002 18:31:33 -0700 (PDT)
Message-Id: <20020720.183133.67807986.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: rml@tech9.net, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, riel@conectiva.com.br, wli@holomorphy.com
Subject: Re: [PATCH] generalized spin_lock_bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1027211185.17234.48.camel@irongate.swansea.linux.org.uk>
References: <1027196511.1555.767.camel@sinai>
	<20020720.152703.102669295.davem@redhat.com>
	<1027211185.17234.48.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 21 Jul 2002 01:26:25 +0100
   
   Secondly many platforms want to implement their locks in other ways.
   Atomic bitops are an x86 luxury so your proposal simply generates
   hideously inefficient code compared to arch specific sanity
   
For an asm-generic/bitlock.h implementation it is more than
fine.  That way we get asm-i386/bitlock.h that does whatever
it wants to do and the rest of asm-*/bitlock.h includes
the generic version until the arch maintainer sees fit to
do otherwise.

See the difference between what we have here now?  It means all ports
will at least sort-of work when the change gets installed.  A lot of
testing gets lost because ports break on a daily basis due to changes
when done like this.

Look at the asm/rmap.h stuff, that was done right and platforms kept
at least compiling when that change went in.

I don't mind architecture breakage when truly necessary to change
stuff, but when it can be avoided reasonably it should.
