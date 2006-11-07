Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWKGMJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWKGMJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWKGMJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:09:27 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20958 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932429AbWKGMJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:09:26 -0500
Date: Tue, 7 Nov 2006 15:09:21 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: zhou drangon <drangon.mail@gmail.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061107120921.GA4742@2ka.mipt.ru>
References: <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com> <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com> <4549A261.9010007@cosmosbay.com> <20061102080122.GA1302@2ka.mipt.ru> <454FA671.7000204@cosmosbay.com> <20061107091842.GA4608@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061107091842.GA4608@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 07 Nov 2006 15:09:21 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 12:18:43PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> On Mon, Nov 06, 2006 at 10:17:37PM +0100, Eric Dumazet (dada1@cosmosbay.com) wrote:
> > Evgeniy Polyakov a écrit :
> > >
> > >If there would exist sockets support, then I could patch it to work with
> > >kevents.
> > >
> > 
> > OK I post here my last version of epoll_bench.
> 
> My results with AF_INET are inlined.
> Hardware 2.4 Ghz Xeon w(1 CPU, HT enabled) with 1 GB of RAM.
> 
> [root@pcix event]# ./epoll_bench -n 2000 -i
> 2000 handles setup
> 49758 evts/sec 1.56177 samples per call
> 38999 evts/sec 95 ctxt/sec 2.77247 samples per call
> 54042 evts/sec 130 ctxt/sec 4.19909 samples per call
> 60155 evts/sec 188 ctxt/sec 5.38024 samples per call
> 59588 evts/sec 178 ctxt/sec 6.38112 samples per call
> 60023 evts/sec 188 ctxt/sec 7.19564 samples per call
> 59694 evts/sec 186 ctxt/sec 7.93067 samples per call
> 60182 evts/sec 190 ctxt/sec 8.52397 samples per call
> 59750 evts/sec 182 ctxt/sec 9.08015 samples per call
> 60158 evts/sec 192 ctxt/sec 9.53548 samples per call
> 59739 evts/sec 188 ctxt/sec 9.97013 samples per call
> 60054 evts/sec 216 ctxt/sec 10.32 samples per call
> 59820 evts/sec 206 ctxt/sec 10.6641 samples per call
> 60095 evts/sec 218 ctxt/sec 10.9289 samples per call
> 59376 evts/sec 158 ctxt/sec 11.3231 samples per call
> Avg: 57428 evts/sec
> [root@pcix event]# ./kevent_bench -n2000 -i
> 2000 handles setup
> 57960 evts/sec 0.276702 samples per call
> 59802 evts/sec 75 ctxt/sec 0.462737 samples per call
> 59864 evts/sec 71 ctxt/sec 0.623457 samples per call
> 59651 evts/sec 72 ctxt/sec 0.721579 samples per call
> 59504 evts/sec 84 ctxt/sec 0.804311 samples per call
> 61019 evts/sec 72 ctxt/sec 0.904817 samples per call
> 59846 evts/sec 72 ctxt/sec 0.949439 samples per call
> 60550 evts/sec 74 ctxt/sec 1.00416 samples per call
> 59421 evts/sec 66 ctxt/sec 1.04133 samples per call
> 60334 evts/sec 75 ctxt/sec 1.06845 samples per call
> 60000 evts/sec 67 ctxt/sec 1.09594 samples per call
> 59429 evts/sec 74 ctxt/sec 1.11404 samples per call
> 60508 evts/sec 77 ctxt/sec 1.14482 samples per call
> 59530 evts/sec 66 ctxt/sec 1.15454 samples per call
> 59506 evts/sec 73 ctxt/sec 1.17937 samples per call
> Avg: 59794 evts/sec
> [root@pcix event]# ./kevent_bench -n2000 -i -f
> 2000 handles setup
> 82893 evts/sec
> 88624 evts/sec 390 ctxt/sec
> 88751 evts/sec 475 ctxt/sec
> 88784 evts/sec 488 ctxt/sec
> 88918 evts/sec 458 ctxt/sec
> 88866 evts/sec 504 ctxt/sec
> 88950 evts/sec 458 ctxt/sec
> 88883 evts/sec 472 ctxt/sec
> 88915 evts/sec 404 ctxt/sec
> 88836 evts/sec 368 ctxt/sec
> 89065 evts/sec 442 ctxt/sec
> 88859 evts/sec 398 ctxt/sec
> 89070 evts/sec 446 ctxt/sec
> 88809 evts/sec 428 ctxt/sec
> 89012 evts/sec 542 ctxt/sec
> Avg: 88482 evts/sec
> 
> epoll: 57428
> kevent: 59794
> max: 88482
> 
> BUT!
> Kevent does not support analogue for EPOLLET, i.e. the case when the
> same event is used, instead kevent must modify existing one (i.e. behave
> exactly like epoll without EPOLLET), so modified epoll_bench to work
> without EPOLLET like kevent.
> epoll with EPOLLET shows upto 71k events/sec.
> 
> Lack of such feature is a minus for kevent indeed.
> I will add it into todo list behind (implemented) new ring buffer
> implementation and (implemented) wake-up-one-thread flag implementation.
> Hopefully I will include it into next kevent release soon, but do not 
> expect it today/tomorrow, there some unrelated to hacking problems.

Here is edge-triggered behavior of kevent:
[root@pcix event]# ./kevent_bench -n2000 -i
2000 handles setup
67057 evts/sec 1.18746 samples per call
79239 evts/sec 68 ctxt/sec 1.30531 samples per call
78877 evts/sec 140 ctxt/sec 1.34172 samples per call
79017 evts/sec 82 ctxt/sec 1.35835 samples per call
78957 evts/sec 115 ctxt/sec 1.36885 samples per call
79084 evts/sec 70 ctxt/sec 1.37419 samples per call
79083 evts/sec 98 ctxt/sec 1.38 samples per call
79083 evts/sec 72 ctxt/sec 1.38194 samples per call
79025 evts/sec 111 ctxt/sec 1.38426 samples per call
79139 evts/sec 78 ctxt/sec 1.38554 samples per call
79055 evts/sec 112 ctxt/sec 1.38701 samples per call
79118 evts/sec 72 ctxt/sec 1.39 samples per call
79040 evts/sec 94 ctxt/sec 1.39108 samples per call
79098 evts/sec 81 ctxt/sec 1.39136 samples per call
79104 evts/sec 90 ctxt/sec 1.39269 samples per call
Avg: 78265 evts/sec

So, kevent is faster than epoll.
It was proven using three independent benchmarks (mine
evserver_kevent.c, Johann Borck's own web server and Eric's epoll_bench).

I plan to release new version with all additional goodies today.

-- 
	Evgeniy Polyakov
