Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQLAMuq>; Fri, 1 Dec 2000 07:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbQLAMug>; Fri, 1 Dec 2000 07:50:36 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:35738 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129465AbQLAMu1>; Fri, 1 Dec 2000 07:50:27 -0500
Message-ID: <3A279841.20B82C23@uow.edu.au>
Date: Fri, 01 Dec 2000 23:23:29 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Lawrence Walton <lawrence@the-penguin.otak.com>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au> <3A26F77B.2800C58D@asiapacificm01.nt.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Andrew Morton wrote:
> >
> > I bet this'll catch it:
> >
> > --- include/linux/list.h.orig   Fri Dec  1 08:33:36 2000
> > +++ include/linux/list.h        Fri Dec  1 08:33:55 2000
> > @@ -90,6 +90,7 @@
> >  static __inline__ void list_del(struct list_head *entry)
> >  {
> >         __list_del(entry->prev, entry->next);
> > +       entry->next = entry->prev = 0;
> >  }
> >
> >  /**
> >
> > First person to send a ksymoops trace gets a cookie.
> 
> mmmm... choc-chip.
> 
> With the above patch applied the machine crashed after an hour. Crashed
> a second time during the e2fsck.  gdb backtrace:
> 


This sync_buffers corruption is fixed by Jens' patch, which is present
in test12-pre3.

However it is possible that the original list_head-based corruption which
I reported will not be fixed by this patch. This is because none of the
structure offsets match up with what I observed, and because Lawrence's
sytem is "SCSI-only" - no SCSI drivers are headactive.

Lawrence, did you see this problem with test12-pre3?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
