Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290574AbSA3Ujh>; Wed, 30 Jan 2002 15:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290575AbSA3Uj1>; Wed, 30 Jan 2002 15:39:27 -0500
Received: from zarjazz.demon.co.uk ([194.222.135.25]:8320 "EHLO
	zarjazz.demon.co.uk") by vger.kernel.org with ESMTP
	id <S290574AbSA3UjK>; Wed, 30 Jan 2002 15:39:10 -0500
Message-ID: <001901c1a900$e2bc7420$0201010a@frodo>
From: "Vincent Sweeney" <v.sweeney@barrysworld.com>
To: "Dan Kegel" <dank@kegel.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3C56E327.69F8B70F@kegel.com>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
Date: Tue, 29 Jan 2002 20:09:40 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Dan Kegel" <dank@kegel.com>
To: "Vincent Sweeney" <v.sweeney@barrysworld.com>;
<linux-kernel@vger.kernel.org>
Sent: Tuesday, January 29, 2002 6:00 PM
Subject: Re: PROBLEM: high system usage / poor SMP network performance


> "Vincent Sweeney" <v.sweeney@barrysworld.com> wrote:
> > > > >     CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
> > > > >     CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle
> > > >
> > > > The important bit here is     ^^^^^^^^ that one. Something is
causing
> > > > horrendous lock contention it appears.
> > ...
> > Right then, here is the results from today so far (snapshot taken with
2000
> > users per ircd). Kernel profiling enabled with the eepro100 driver
compiled
> > statically.
> >    readprofile -r ; sleep 60; readprofile | sort -n | tail -30
> > ...
> >    170 sys_poll                                   0.1897
> >    269 do_pollfd                                  1.4944
> >    462 remove_wait_queue                         12.8333
> >    474 add_wait_queue                             9.1154
> >    782 fput                                       3.3707
> >   1216 default_idle                              23.3846
> >   1334 fget                                      16.6750
> >   1347 sock_poll                                 33.6750
> >   2408 tcp_poll                                   6.9195
> >   9366 total                                      0.0094
> > ...
> > So with my little knowledge of what this means I would say this is
purely
> > down to poll(), but surely even with 4000 connections to the box that
> > shouldn't stretch a dual P3-800 box as much as it does?
>
> My oldish results,
> http://www.kegel.com/dkftpbench/Poller_bench.html#results
> show that yes, 4000 connections can really hurt a Linux program
> that uses poll().  It is very tempting to port ircd to use
> the Poller library
(http://www.kegel.com/dkftpbench/dkftpbench-0.38.tar.gz);
> that would let us compare poll(), realtimesignals, and /dev/epoll
> to see how well they do on your workload.
> - Dan
>

So basically you are telling me these are my options:

    1) Someone is going to have to recode the ircd source we use and
possibly a modified kernel in the *hope* that performance improves.
    2) Convert the box to FreeBSD which seems to have a better poll()
implementation, and where I could support 8K clients easily as other admins
on my chat network do already.
    3) Move the ircd processes to some 400Mhz Ultra 5's running Solaris-8
which run 3-4K users at 60% cpu!

Now I want to run Linux but unless I get this issue resolved I'm essentialy
not utilizing my hardware to the best of its ability.

Vince.


