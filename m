Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132138AbQL2UAE>; Fri, 29 Dec 2000 15:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132168AbQL2T7y>; Fri, 29 Dec 2000 14:59:54 -0500
Received: from [64.242.80.3] ([64.242.80.3]:16655 "EHLO TTGCS.teamtoolz.net")
	by vger.kernel.org with ESMTP id <S132138AbQL2T7q>;
	Fri, 29 Dec 2000 14:59:46 -0500
Message-ID: <85F1402515F13F498EE9FBBC5E07594220ABD2@TTGCS.teamtoolz.net>
From: Matt Liotta <mliotta@teamtoolz.com>
To: "'Andi Kleen'" <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Petru Paler <ppetru@ppetru.net>,
        Jure Pecar <pegasus@telemach.net>, linux-kernel@vger.kernel.org,
        thttpd@bomb.acme.com
Subject: RE: linux 2.2.19pre and thttpd (VM-global problem?)
Date: Fri, 29 Dec 2000 11:29:12 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wouldn't use cheap single CPU/NIC machines in the real world.  Certainly a
cluster of smaller machines does better then one big machine, but that
doesn't mean you should use too small of a machine.  Remember that as the
number of cluster nodes goes up the cluster becomes a management problem.  I
would use a cluster of dual CPU/NIC machines instead.  This gives you the
benefits of SMP machines along with the benefits of clusters.  It should
also allow your cluster to handle more load with less nodes then single
CPU/NIC machines.

With that being said Linux is proving me wrong in the real world.  Our
application server is dependant on pthreads (really just cloned process) and
as such doesn't scale well with Linux 2.2 on a dual CPU machine.  Our
benchmarks show that we can handle more load on a single CPU machine then a
dual CPU one with Linux 2.2.  However, it is encouraging to see that the
situation is reversed when using Linux 2.4.

-Matt

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de]
> Sent: Friday, December 29, 2000 11:14 AM
> To: Andrea Arcangeli
> Cc: Alan Cox; Petru Paler; Jure Pecar; linux-kernel@vger.kernel.org;
> thttpd@bomb.acme.com
> Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
> 
> 
> On Fri, Dec 29, 2000 at 08:06:57PM +0100, Andrea Arcangeli wrote:
> > On Fri, Dec 29, 2000 at 06:50:18PM +0000, Alan Cox wrote:
> > > Your cgi will keep the other CPU occupied, or run two of 
> them. thttpd has
> > > superb scaling properties compared to say apache.
> > 
> > I think with 8 CPUs and 8 NICs (usual benchmark setup) you 
> want more than 1 cpu
> 
> That's a good benchmark setup when the benchmark requires a 
> single machine.
> 
> In the real world it often makes a lot of sense though to use 
> a cluster
> of cheap single CPU machines behind a load balancer (gives 
> you better fault 
> tolerance and is likely cheaper) 
> 
> For these thttpd is a nice web server.
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
