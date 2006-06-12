Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752107AbWFLQFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbWFLQFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbWFLQFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:05:31 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:64458 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1752107AbWFLQFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:05:30 -0400
Date: Tue, 13 Jun 2006 01:06:28 +0900 (JST)
Message-Id: <20060613.010628.41632745.anemo@mba.ocn.ne.jp>
To: sebastien.dugue@bull.net
Cc: jakub@redhat.com, arjan@infradead.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org, pierre.peiffer@bull.net
Subject: Re: NPTL mutex and the scheduling priority
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1150125869.3835.12.camel@frecb000686>
References: <1150115008.3131.106.camel@laptopd505.fenrus.org>
	<20060612124406.GZ3115@devserv.devel.redhat.com>
	<1150125869.3835.12.camel@frecb000686>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 17:24:28 +0200, Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> > > you want to use the PI futexes that are in 2.6.17-rc5-mm tree
> > 
> > Even for normal mutices pthread_mutex_unlock and
> > pthread_cond_{signal,broadcast} is supposed to honor the RT priority and
> > scheduling policy when waking up:
> > http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_trylock.html
> > "If there are threads blocked on the mutex object referenced by mutex when
> > pthread_mutex_unlock() is called, resulting in the mutex becoming available,
> > the scheduling policy shall determine which thread shall acquire the mutex."
> > and similarly for condvars.
> > "Use PI" is not a valid answer for this.
> > Really FUTEX_WAKE/FUTEX_REQUEUE can't use a FIFO.  I think there was a patch
> > floating around to use a plist there instead, which is one possibility,
> > another one is to keep the queue sorted by priority (and adjust whenever
> > priority changes - one thread can be waiting on at most one futex at a
> > time).
> > 
> 
>   The patch you refer to is at
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114725326712391&w=2

Thank you all.  I'll look into PI futexes which seems the right
direction, but I still welcome short term (limited) solutions,
hopefully work with existing glibc.  I'll look at the plist patch.

---
Atsushi Nemoto
