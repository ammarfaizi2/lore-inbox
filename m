Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLAPeh>; Fri, 1 Dec 2000 10:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLAPe1>; Fri, 1 Dec 2000 10:34:27 -0500
Received: from the-penguin.otak.com ([216.122.56.136]:46721 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S129410AbQLAPeL>; Fri, 1 Dec 2000 10:34:11 -0500
Date: Fri, 1 Dec 2000 07:04:44 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001201070444.A3755@the-penguin.otak.com>
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au> <3A26F77B.2800C58D@asiapacificm01.nt.com> <3A279841.20B82C23@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A279841.20B82C23@uow.edu.au>; from andrewm@uow.edu.au on Fri, Dec 01, 2000 at 11:23:29PM +1100
X-Operating-System: Linux 2.4.0-test12 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton [andrewm@uow.edu.au] wrote:
> Andrew Morton wrote:
> > 
> > Andrew Morton wrote:
> > >
> > > I bet this'll catch it:
> > >
> > > --- include/linux/list.h.orig   Fri Dec  1 08:33:36 2000
> > > +++ include/linux/list.h        Fri Dec  1 08:33:55 2000
> > > @@ -90,6 +90,7 @@
> > >  static __inline__ void list_del(struct list_head *entry)
> > >  {
> > >         __list_del(entry->prev, entry->next);
> > > +       entry->next = entry->prev = 0;
> > >  }
> > >
> > >  /**
> > >
> > > First person to send a ksymoops trace gets a cookie.
> > 
> > mmmm... choc-chip.
> > 
> > With the above patch applied the machine crashed after an hour. Crashed
> > a second time during the e2fsck.  gdb backtrace:
> > 
> 
> 
> This sync_buffers corruption is fixed by Jens' patch, which is present
> in test12-pre3.
> 
> However it is possible that the original list_head-based corruption which
> I reported will not be fixed by this patch. This is because none of the
> structure offsets match up with what I observed, and because Lawrence's
> system is "SCSI-only" - no SCSI drivers are headactive.
> 
> Lawrence, did you see this problem with test12-pre3?


Yes all of my current problems are with pre3;
Is there anything you would like me to test
specific?
The best way to cause  problems so far is 
compiling mozilla.
-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
