Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSHCFa0>; Sat, 3 Aug 2002 01:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSHCFa0>; Sat, 3 Aug 2002 01:30:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37035 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317345AbSHCFaY>;
	Sat, 3 Aug 2002 01:30:24 -0400
Date: Fri, 02 Aug 2002 22:20:24 -0700 (PDT)
Message-Id: <20020802.222024.21061449.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: torvalds@transmeta.com, gh@us.ibm.com, frankeh@watson.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15691.24200.512998.875390@napali.hpl.hp.com>
References: <15691.22889.22452.194180@napali.hpl.hp.com>
	<Pine.LNX.4.44.0208022125040.2694-100000@home.transmeta.com>
	<15691.24200.512998.875390@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Fri, 2 Aug 2002 21:39:36 -0700

   >>>>> On Fri, 2 Aug 2002 21:26:52 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> said:
   
     >> I wasn't disagreeing with your case for separate large page
     >> syscalls.  Those syscalls certainly simplify implementation and,
     >> as you point out, it well may be the case that a transparent
     >> superpage scheme never will be able to replace the former.
   
     Linus> Somebody already had patches for the transparent superpage
     Linus> thing for alpha, which supports it. I remember seeing numbers
     Linus> implying that helped noticeably.
   
   Yes, I saw those.  I still like the Rice work a _lot_ better.

Now here's the thing.  To me, we should be adding these superpage
syscalls to things like the implementation of malloc() :-) If you
allocate enough anonymous pages together, you should get a superpage
in the TLB if that is easy to do.  Once any hint of memory pressure
occurs, you just break up the large page clusters as you hit such
ptes.  This is what one of the Linux large-page implementations did
and I personally find it the most elegant way to handle the so called
"paging complexity" of transparent superpages.

At that point it's like "why the system call".  If it would rather be
more of a large-page reservation system than a "optimization hint"
then these syscalls would sit better with me.  Currently I think they
are superfluous.  To me the hint to use large-pages is a given :-)

Stated another way, if these syscalls said "gimme large pages for this
area and lock them into memory", this would be fine.  If the syscalls
say "use large pages if you can", that's crap.  And in fact we could
use mmap() attribute flags if we really thought that stating this was
necessary.
