Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSGIDBz>; Mon, 8 Jul 2002 23:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSGIDBy>; Mon, 8 Jul 2002 23:01:54 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:38331 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S312590AbSGIDBy>;
	Mon, 8 Jul 2002 23:01:54 -0400
Date: Tue, 9 Jul 2002 00:09:04 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020709000904.S2295@almesberger.net>
References: <20020708210713.R2295@almesberger.net> <22226.1026174466@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22226.1026174466@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Tue, Jul 09, 2002 at 10:27:46AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> The only difference between module and non-module is whether the code
> and data areas are freed or left in the kernel for the next user.

Yes, that's exactly why the entry-after-removal problem worries me:
this is something that also means trouble if you're a non-module. 

Just remember the "timer pops after del_timer" problem a while back.
De-registration that leaves stuff behind is extremely dangerous, no
matter if you're a module or not.

I fully agree that return-after-removal is a different issue and
that there are several perfectly reasonable ways for dealing with
this.

> Ensuring that all code has either dropped stale references or bumped
> the use count means that all processes that were not sleeping when
> rmmod was started must proceed to a sync point.  It is (and always has
> been) illegal to sleep while using module code/data (note: using, not
> referencing).

That's the problem with entry-after-removal: you may simply not be
able to know when all references are gone.

Since basically all references to modules go through some sort of
registration function, why not fix the registration functions ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
