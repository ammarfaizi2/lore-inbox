Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbSLUIUP>; Sat, 21 Dec 2002 03:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbSLUIUO>; Sat, 21 Dec 2002 03:20:14 -0500
Received: from tornado.reub.net ([203.29.67.170]:45493 "HELO tornado.reub.net")
	by vger.kernel.org with SMTP id <S266797AbSLUIUO>;
	Sat, 21 Dec 2002 03:20:14 -0500
Message-Id: <5.2.0.9.2.20021221191530.02ade850@tornado.reub.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 21 Dec 2002 19:28:12 +1100
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
From: Reuben Farrelly <reuben-linux@reub.net>
Subject: Re: 2.4.20-aa and LARGE Squid process -> SIGSEGV
Cc: Robert Collins <robertc@squid-cache.org>
In-Reply-To: <20021221075205.GZ31070@charite.de>
References: <20021221001334.GA7996@werewolf.able.es>
 <20021220114837.GC13591@charite.de>
 <20021220223754.GA10139@werewolf.able.es>
 <20021220225733.GE31070@charite.de>
 <20021221001334.GA7996@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, squid is not br0ken in this fashion.  If squid cannot be allocated 
enough memory by the system, it logs a message and _dies_.  Relevant files 
to look at in your squid source are squid/lib/util.c for xcalloc() and 
xmalloc().

Aside from this, if squid ever does get to the point of swapping, it is 
misconfigured and your performance has just gone to hell anyway...  (see 
the FAQ at www.squid-cache.org)

Questions relating to squid performance and stability should really be 
discussed on the squid users mailing list, you can find details on this 
list at http://www.squid-cache.org/mailing-lists.html

Reuben


At 08:52 AM 21/12/2002 +0100, Ralf Hildebrandt wrote:
>* J.A. Magallon <jamagallon@able.es>:
>
> > For user space memory, there is no real OOM state. The system (glibc) just
> > does not give you the memory, returns NULL in the malloc, and it is your
> > responsibility to check malloc's return value. If you do not check it,
> > you try to access a null pointer and _bang_. So in your case, after enough
> > iterations on malloc() without free(), it returns NULL and you fall into
> > a null pointer dereference.
>
>Ergo: Squid is br0ken.
>
>--
>Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
>Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
>Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
>Windows is the answer, but only if the question was 'what is the
>intellectual equivalent of being a galley slave?'
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

