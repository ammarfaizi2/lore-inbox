Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289738AbSA2RzI>; Tue, 29 Jan 2002 12:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289793AbSA2Ryw>; Tue, 29 Jan 2002 12:54:52 -0500
Received: from relay1.pair.com ([209.68.1.20]:17939 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S289738AbSA2Ryd>;
	Tue, 29 Jan 2002 12:54:33 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C56E327.69F8B70F@kegel.com>
Date: Tue, 29 Jan 2002 10:00:07 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Sweeney <v.sweeney@barrysworld.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vincent Sweeney" <v.sweeney@barrysworld.com> wrote:
> > > >     CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
> > > >     CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle
> > >
> > > The important bit here is     ^^^^^^^^ that one. Something is causing
> > > horrendous lock contention it appears.
> ...
> Right then, here is the results from today so far (snapshot taken with 2000
> users per ircd). Kernel profiling enabled with the eepro100 driver compiled
> statically.
>    readprofile -r ; sleep 60; readprofile | sort -n | tail -30
> ...
>    170 sys_poll                                   0.1897
>    269 do_pollfd                                  1.4944
>    462 remove_wait_queue                         12.8333
>    474 add_wait_queue                             9.1154
>    782 fput                                       3.3707
>   1216 default_idle                              23.3846
>   1334 fget                                      16.6750
>   1347 sock_poll                                 33.6750
>   2408 tcp_poll                                   6.9195
>   9366 total                                      0.0094
> ...
> So with my little knowledge of what this means I would say this is purely
> down to poll(), but surely even with 4000 connections to the box that
> shouldn't stretch a dual P3-800 box as much as it does?

My oldish results,
http://www.kegel.com/dkftpbench/Poller_bench.html#results
show that yes, 4000 connections can really hurt a Linux program
that uses poll().  It is very tempting to port ircd to use 
the Poller library (http://www.kegel.com/dkftpbench/dkftpbench-0.38.tar.gz);
that would let us compare poll(), realtimesignals, and /dev/epoll
to see how well they do on your workload.
- Dan
