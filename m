Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAMtr>; Fri, 1 Dec 2000 07:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbQLAMtg>; Fri, 1 Dec 2000 07:49:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13074 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129210AbQLAMtS>;
	Fri, 1 Dec 2000 07:49:18 -0500
Date: Fri, 1 Dec 2000 13:18:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <morton@nortelnetworks.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001201131814.C21309@suse.de>
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au> <3A26F77B.2800C58D@asiapacificm01.nt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A26F77B.2800C58D@asiapacificm01.nt.com>; from morton@nortelnetworks.com on Fri, Dec 01, 2000 at 12:57:31AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01 2000, Andrew Morton wrote:
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

Very interesting. IDE / SCSI?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
