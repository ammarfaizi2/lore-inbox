Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRDKREl>; Wed, 11 Apr 2001 13:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132660AbRDKREP>; Wed, 11 Apr 2001 13:04:15 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:10660 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132673AbRDKRD2>; Wed, 11 Apr 2001 13:03:28 -0400
Message-ID: <3AD48D81.6E7B23B1@mvista.com>
Date: Wed, 11 Apr 2001 09:59:45 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Mark Salisbury <gonar@mediaone.net>, mark salisbury <mbs@mc.com>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3AD366DC.478E4AF@mc.com> <3AD38464.A1F97AC8@mvista.com> <002a01c0c221$32703e60$6501a8c0@gonar.com> <20010411181101.B23974@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Locker wrote:
> 
> Mark Salisbury wrote:
> > > The complexity comes in when you want to maintain indexes into the list
> > > for quick insertion of new timers.  To get the current insert
> > > performance, for example, you would need pointers to (at least) each of
> > > the next 256 centasecond boundaries in the list.  But the list ages, so
> > > these pointers need to be continually updated.  The thought I had was to
> > > update needed pointers (and only those needed) each time an insert was
> > > done and a needed pointer was found to be missing or stale.  Still it
> > > adds complexity that the static structure used now doesn't have.
> >
> > actually, I think a head and tail pointer would be sufficient for most
> > cases. (most new timers are either going to be a new head of list or a new
> > tail, i.e. long duration timeouts that will never be serviced or short
> > duration timers that are going to go off "real soon now (tm)")  the oddball
> > cases would be mostly coming from user-space, i.e. nanosleep which a longerr
> > list insertion disapears in the block/wakeup/context switch overhead
> 
> A pointer-based priority queue is really not a very complex thing, and
> there are ways to optimise them for typical cases like the above.
> 
Please do enlighten me.  The big problem in my mind is that the
pointers, pointing at points in time, are perishable.

George
