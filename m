Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262461AbSJKO0k>; Fri, 11 Oct 2002 10:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262467AbSJKO0k>; Fri, 11 Oct 2002 10:26:40 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:7697 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S262461AbSJKO0j> convert rfc822-to-8bit; Fri, 11 Oct 2002 10:26:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.5.41, cciss (3 of 3)
Date: Fri, 11 Oct 2002 09:32:15 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E1064012814E0@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.41, cciss (3 of 3)
Thread-Index: AcJxMYI7zdRUG4pnQnu/uRICdowo7AAARWKA
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
X-OriginalArrivalTime: 11 Oct 2002 14:32:16.0632 (UTC) FILETIME=[FF5C0780:01C27132]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Arjan van de Ven wrote:
> On Fri, 2002-10-11 at 16:10, Stephen Cameron wrote:
> > 
> > Wait up to 20 seconds for polled commands to complete.  A 
> certain multiport
> > storage box needs this.
> > 
> > diff -urN linux-2.5.41-p/drivers/block/cciss.c 
> linux-2.5.41-q/drivers/block/cciss.c
> > --- linux-2.5.41-p/drivers/block/cciss.c	Wed Oct  9 15:22:14 2002
> > +++ linux-2.5.41-q/drivers/block/cciss.c	Wed Oct  9 15:54:35 2002
> > @@ -1318,9 +1318,9 @@
> >          unsigned long done;
> >          int i;
> >  
> > -        /* Wait (up to 2 seconds) for a command to complete */
> > +        /* Wait (up to 20 seconds) for a command to complete */
> >  
> > -        for (i = 200000; i > 0; i--) {
> > +        for (i = 2000000; i > 0; i--) {
> >                  done = 
> hba[ctlr]->access.command_completed(hba[ctlr]);
> >                  if (done == FIFO_EMPTY) {
> >                          udelay(10);     /* a short fixed delay */
> 
> ugh 20 seconds udelay....
> 
> why can't you sleep here ?
> (and yes 20 seconds WILL trigger watchdogs!)

Ok.  Nevermind that patch then.  We'll have to rethink it.
-- steve

