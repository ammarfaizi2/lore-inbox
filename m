Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318756AbSICMSl>; Tue, 3 Sep 2002 08:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318764AbSICMSl>; Tue, 3 Sep 2002 08:18:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16805 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318756AbSICMSj>;
	Tue, 3 Sep 2002 08:18:39 -0400
Date: Tue, 3 Sep 2002 17:34:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core in 2.5 - io_queue_wait and io_getevents
Message-ID: <20020903173400.A2857@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com> <20020816100334.GP14394@dualathlon.random> <20020816165306.A2055@in.ibm.com> <20020902184043.GN1210@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020902184043.GN1210@dualathlon.random>; from andrea@suse.de on Mon, Sep 02, 2002 at 08:40:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changed the title to reflect the latest discussion. Just wanted
to comment on the nwait bit.

On Mon, Sep 02, 2002 at 08:40:43PM +0200, Andrea Arcangeli wrote:
> 
> then about the 2.5 API we have such min_nr that allows the "at least
> min_nr", instead of the previous default of "at least 1", so that it
> allows implementing the aio_nwait of aix.

Partly, in the sense that the implementation still doesn't avoid 
extra wakeups when less than min_nr events are available at a time 
(if we are unlucky enough to have the min_nr events dripping in 
slowly one at a time, we'd still have all those context switches, 
won't we ?), though it saves on the extra user-kernel transitions 
on those wakeups compared to if this were implemented in user-space 
over an at-least-one primitive. 

It is possible to play around with the implementation later though.
The important bit is having "at least N" in the interface exported 
by the kernel, which is good.

Regards
Suparna

> Andrea
