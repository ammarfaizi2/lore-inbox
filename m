Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQJ3Jh3>; Mon, 30 Oct 2000 04:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQJ3JhT>; Mon, 30 Oct 2000 04:37:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:18694 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129044AbQJ3JhF>; Mon, 30 Oct 2000 04:37:05 -0500
Date: Mon, 30 Oct 2000 02:33:39 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030023339.A20102@vger.timpanogas.org>
In-Reply-To: <20001030021111.A19975@vger.timpanogas.org> <Pine.LNX.4.21.0010301127200.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301127200.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 11:41:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 11:41:35AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > [...] you've got the web server covered.  What about file and print.
> 
> a web server, as you probably know, is a read-mostly fileserver that
> serves files via the HTTP protocol. The rest is only protocol fluff.
> 
> > I think this is great, but most web servers are connected to a T1 or
> > T3 line, and all the fancy optimization means absolutely squat since
> > about 99.999999% of the planet has a max baandwidth of a T1, ADSL, or
> > T3 Line, this is a far cry from Gigabit ethernet, or even 100Mbit
> > ethernet.
> 
> Your argument is curious - first you cry for performance, then you say
> 'nobody wants that much bandwidth'. Of course, if the network is bandwidth
> limited then we cannot scale above that bandwidth. But thats not the
> point. The point is to put 10 cards into a server and still being able to
> saturate them. The point is also to spend less cycles on saturating
> available bandwidth. The point is also to not flush the L1 just because
> someone requested a 10K webpage.

It's not curious, it's not about bandwidth, it's about latency, and getting
packets in and out of the server as fast as possible, and ahead of everything
else.  Cache affinity and all the Tux stuff is a great piece of work.  Let's
talk about file and print, that's the present problem, not how to 
pump out read-only data from a web server.


> 
> > How many users can you put on the web server? [...]
> 
> tens of thousands, on a single CPU. Can probably handle over 100 thousand
> users as well, with IP aliasing so the socket space is spread out.
> 
> > Web servers are also read only data, the easiest of all LAN cases to
> > deal with. It's incoming writes that present all the tough problems,
> 
> reads dominate writes in almost all workloads, thats common wisdom. Why
> write if nobody reads the data? And while web servers are mostly read only
> data, they can write data as well, see POST and PUT. The fact that
> incoming writes are hard should not let you distract from the fact that
> reads are also extremely important.
> 
> 	Ingo


Web servers don't do writes, unless a CGI script is running somewhere
or some Java or Perl or something, then this stuff goes through a 
wrapper, which is slow, or did I miss something.  

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
