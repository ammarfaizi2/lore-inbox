Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272155AbRH3KI5>; Thu, 30 Aug 2001 06:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272156AbRH3KIr>; Thu, 30 Aug 2001 06:08:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63433 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272155AbRH3KIg>;
	Thu, 30 Aug 2001 06:08:36 -0400
Date: Thu, 30 Aug 2001 06:08:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kip Macy <kmacy@netapp.com>, Elan Feingold <efeingold@mn.rr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Multithreaded core dumps
In-Reply-To: <E15cNsX-0000m7-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0108300603100.9879-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Aug 2001, Alan Cox wrote:

> > > The 2.4-ac tree supports dumping core.$pid for the threads that actually
> > > died
> > 
> > ... and these dumps are not reliable.  Living thread may modify the
> > contents of dump as it's being written out.  I.e. you are getting
> > false alarms - inconsistent data that was never there.
> 
> That is mathematically insoluble. Think about an SMP system, you cannot stop
> the other thread in instantaneously small time

That's a separate problem - we can't catch the exact state of process
at the moment of death, indeed, but in theory we could make sure that
no changes happen while we write the thing out.  As it is, coredump is not
only taken at some point after death, it doesn't correspond to state of
the thing at _any_ moment.

