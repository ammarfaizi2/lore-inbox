Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316044AbSEJP75>; Fri, 10 May 2002 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316037AbSEJP7z>; Fri, 10 May 2002 11:59:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59840 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316047AbSEJP7v>;
	Fri, 10 May 2002 11:59:51 -0400
Date: Fri, 10 May 2002 08:47:22 -0700 (PDT)
Message-Id: <20020510.084722.124055793.davem@redhat.com>
To: macro@ds2.pg.gda.pl
Cc: dizzy@roedu.net, linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.3.96.1020510174846.12571A-100000@delta.ds2.pg.gda.pl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
   Date: Fri, 10 May 2002 17:53:21 +0200 (MET DST)

   On Fri, 10 May 2002, David S. Miller wrote:
   
   > How would you like the kernel to "ignore" a page fault that cannot be
   > serviced?
   
    I would expect it to return from the handler with no action, possibly
   re-executing the faulting instruction (if the reason was synchronous) and
   causing an infinite loop.  For consistency, whether it makes sense, or not
   (ditto for SIGSEGV, etc.). 

If we reexecute the instruction it will take the signal endlessly,
forever.  That makes no sense.

Next, if we skip the instruation, what should be in the destination
register of the load?  There is no reasonable answer.  If you put
zero there the program will likely segfault on a NULL pointer
dereference.

So my original point I was trying to make, which still stands, is that
what is being requested is totally rediculious behavior, trying to
ignore a page fault that can't be serviced.
