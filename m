Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbTDGMAI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbTDGMAI (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:00:08 -0400
Received: from tomts12.bellnexxia.net ([209.226.175.56]:3763 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263390AbTDGMAE (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:00:04 -0400
Date: Mon, 7 Apr 2003 08:07:26 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66-bk12 causes "rpm" errors
In-Reply-To: <1049679689.753.170.camel@localhost>
Message-ID: <Pine.LNX.4.44.0304070800170.1241-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Apr 2003, Robert Love wrote:

> On Sun, 2003-04-06 at 21:32, Andrew Morton wrote:
> 
> > Does it work OK with earlier 2.5 kernels?
> > 
> > The only change which comes to mind is the below one.  Could you do a
> > patch -R of this and retest?
> 
> This has been happening since 2.5.60-ish.
> 
> It is NPTL-related.  Mr. Day, doing this:
> 
> 	LD_ASSUME_KERNEL=2.2.5 rpm <...>
> 
> should "fix" the problem.

ok, based on messing around this morning with this, here's what
i've found.

(first, apologies to andrew morton; when i said his patch applied
on top of bk12, i was just confused.  it's a "battle tactic". :-)

all of this is based on my RH 9 (shrike) box, running on a dell
inspiron 8100.

first, the rpm flaw exists using all three variations of the
kernel i tested:

  2.5.66
  2.5.66-bk12
  2.5.66-bk12-mm (bk12 minus andrew's filemap patch)

the interesting part is that doing something simple like "rpm -q rpm"
works for a non-root user; it fails only when root tries it, even
though the operation is only a query.  go figure.

next, backing out from rpm-4.2-0.69 to rpm-4.2-0.66 didn't seem to
fix the problem (at least, not for me -- a previous poster claimed
that it fixed it for him, but it didn't solve the problem here).

finally, using:

  LD_ASSUME_KERNEL=2.2.5 rpm -q rpm

solves the problem (at least under the 2.5.66-bk12-mm kernel i'm
running at the moment -- i'll assume it does the same under the
others).

take whatever you can get from this.

rday

p.s.  more 2.5.66-bk12 oddities coming up shortly


