Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310460AbSCGTLm>; Thu, 7 Mar 2002 14:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310462AbSCGTLd>; Thu, 7 Mar 2002 14:11:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24285 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310460AbSCGTLW>;
	Thu, 7 Mar 2002 14:11:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Date: Thu, 7 Mar 2002 14:11:47 -0500
X-Mailer: KMail [version 1.3.1]
Cc: arjanv@redhat.com, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au> <20020307153228.3A6773FE06@smtp.linux.ibm.com> <20020307104241.D24040@devserv.devel.redhat.com>
In-Reply-To: <20020307104241.D24040@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020307191043.9C5F33FE15@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 March 2002 10:42 am, Arjan van de Ven wrote:
> On Thu, Mar 07, 2002 at 10:33:32AM -0500, Hubertus Franke wrote:
> > On Thursday 07 March 2002 07:50 am, Arjan van de Ven wrote:
> > > Rusty Russell wrote:
> > > > This is a userspace implementation of rwlocks on top of futexes.
> > >
> > > question: if rwlocks aren't actually slower in the fast path than
> > > futexes,
> > > would it make sense to only do the rw variant and in some userspace
> > > layer
> > > map "traditional" semaphores to write locks ?
> > > Saves half the implementation and testing....
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > I m not in favor of that. The dominant lock will be mutexes.
>
> if there's no extra cost I don't care which is dominant; having one well
> tested path is worth it then. If there is extra cost then yes a split is
> better.

Take a look at Rusty's futex-1.2, the code is not that different, however
if its all inlined it creates additional code on the critical path 
and why do it if not necessary.

In this case the futexes are the well tested path, the rest is a cludge on
top of it.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
