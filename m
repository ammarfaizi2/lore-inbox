Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317635AbSGOUwP>; Mon, 15 Jul 2002 16:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSGOUwO>; Mon, 15 Jul 2002 16:52:14 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:13317 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317635AbSGOUwM>; Mon, 15 Jul 2002 16:52:12 -0400
Date: Mon, 15 Jul 2002 22:55:05 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020715205505.GC30630@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020712162306$aa7d@traf.lcs.mit.edu> <s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu> <s5gsn2kst2j.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gsn2kst2j.fsf@egghead.curl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Patrick J. LoPresti wrote:

> In a correctly-written application, neither of these things can
> happen.  (See my earlier message today on fsync() and MTAs.)  To get a
> file onto disk reliably, the application must 1) flush the data, and
> then 2) flush a "validity" indicator.  This could be a sequence like:
> 
>   create temp file
>   flush data to temp file
>   rename temp file
>   flush rename operation
> 
> In this sequence, the file's existence under a particular name is the
> indicator of its validity.

Assume that most applications are broken then.

I assume that most will just call close() or fclose() and exit() right
away. Does fclose() imply fsync()? 

Some applications will not even check the [f]close() return value...

> It is possible to make an application which relies on data=ordered
> semantics; for example, skipping the "flush data to temp file" step
> above.  But such an application would be broken for every version of
> Unix *except* Linux in data=ordered mode.  I would call that an
> incorrect application.

Or very specific, at least.

> > Nope, battery backed caches don't make data=writeback more or less safe
> > (with respect to the data anyway).  They do make data=ordered and
> > data=journal more safe.
> 
> A theorist would say that "more safe" is a sloppy concept.  Either an
> operation is safe or it is not.  As I said in my last message,
> data=ordered (and data=journal) can reduce the risk for poorly written
> apps.  But they cannot eliminate that risk, and for a correctly
> written app, data=writeback is 100% as safe.

IF that application uses a marker to mark completion. If it does not,
data=ordered will be the safe bet, regardless of fsync() or not. The
machine can crash BEFORE the fsync() is called.

-- 
Matthias Andree
