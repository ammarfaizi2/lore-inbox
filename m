Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271108AbRH3JEA>; Thu, 30 Aug 2001 05:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271841AbRH3JDu>; Thu, 30 Aug 2001 05:03:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37864 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271791AbRH3JDn>;
	Thu, 30 Aug 2001 05:03:43 -0400
Date: Thu, 30 Aug 2001 05:03:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kip Macy <kmacy@netapp.com>, Elan Feingold <efeingold@mn.rr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Multithreaded core dumps
In-Reply-To: <E15cN7L-0000gX-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0108300457270.9879-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Aug 2001, Alan Cox wrote:

> > I am inclined to believe that that is the case. Unfortunately, I have no
> > advice to give - but I am writing because I think that it would be neat if
> > you have the time and the inclination for you to document your findings as
> > you progress and put them on the web. 
> 
> The 2.4-ac tree supports dumping core.$pid for the threads that actually
> died

... and these dumps are not reliable.  Living thread may modify the
contents of dump as it's being written out.  I.e. you are getting
false alarms - inconsistent data that was never there.

Think of a linked list protected by a mutex.  Half of its entries are
already written out.  Surviving thread removes an element.  It updates
the in-core structures correctly.  The problem being, in the dump
we get part of memory from before that change and part - after.  If
you notice that when you are looking at the dump - welcome to a nice
chase after the bug that never existed.

