Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319426AbSILDtA>; Wed, 11 Sep 2002 23:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319427AbSILDtA>; Wed, 11 Sep 2002 23:49:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62390 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319426AbSILDtA>;
	Wed, 11 Sep 2002 23:49:00 -0400
Date: Wed, 11 Sep 2002 23:53:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Oliver Neukum <oliver@neukum.name>,
       Roman Zippel <zippel@linux-m68k.org>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17pKxR-0007by-00@starship>
Message-ID: <Pine.GSO.4.21.0209112351210.11628-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Sep 2002, Daniel Phillips wrote:

> On Thursday 12 September 2002 05:13, Rusty Russell wrote:
> > B) We do not handle the "half init problem" where a module fails to load, eg.
> > 	a = register_xxx();
> > 	b = register_yyy();
> > 	if (!b) {
> > 		unregister_xxx(a);
> > 		return -EBARF;
> > 	}
> >   Someone can start using "a", and we are in trouble when we remove
> >   the failed module.
> 
> No we are not.  The module remains in the 'stopped' state
> throughout the entire initialization process, as it should and
> does, in my model.

Bzzzert.  At the very least, for block devices we need to be able to open
disks during module initialization.

Al, fully expecting a stack of mind-boggling (and broken) kludges to be
posted...

