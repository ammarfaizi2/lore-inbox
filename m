Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264407AbRFNGrn>; Thu, 14 Jun 2001 02:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264408AbRFNGrd>; Thu, 14 Jun 2001 02:47:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:3083 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264407AbRFNGr2>; Thu, 14 Jun 2001 02:47:28 -0400
Message-ID: <3B285D9A.A25828B8@idb.hist.no>
Date: Thu, 14 Jun 2001 08:45:46 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: threading question
In-Reply-To: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca> <Pine.GSO.4.10.10106121200330.20809-100000@orbit-fe.eng.netapp.com> <20010613193139.A10072@home.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> > from Larry McVoy's home page attributed to Alan Cox illustrates this
> > reasonably well: "A computer is a state machine. Threads are for people
> > who can't program state machines." Sorry for not being more helpful.
> 
> I got that response too. When I pressed kernel people for details it turns
> out that they think having hundreds of runnable threads/processes (mostly
> the same thing under Linux) is wasteful. The scheduler is just not optimised
> for that.

The scheduler can be optimized for that, so far at the cost of
pessimizing
the common case with few threads.  The bigger problem here is that
your cpu (particularly TLB's and caches) aren't optimized for switching
between a lot of threads either.  This will always be a problem as long
as cpu's have level 1 caches much smaller than the combined working
set of your threads.  So run one thread per cpu, perhaps two if you
expect
io stalls.  The task at hand may easily be divided into many more parts,
but serializing those extra parts will be better for performance.

Helge Hafting
