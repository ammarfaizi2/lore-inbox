Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbTIHTVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263559AbTIHTVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:21:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:526 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263557AbTIHTVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:21:40 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Scaling noise
Date: 8 Sep 2003 19:12:43 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjikbb$94n$1@gatekeeper.tmr.com>
References: <20030903050859.GD10257@work.bitmover.com> <1062599136.1724.84.camel@spc9.esa.lanl.gov>
X-Trace: gatekeeper.tmr.com 1063048363 9367 192.168.12.62 (8 Sep 2003 19:12:43 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1062599136.1724.84.camel@spc9.esa.lanl.gov>,
Steven Cole  <elenstev@mesatop.com> wrote:
| On Tue, 2003-09-02 at 23:08, Larry McVoy wrote:
| > On Wed, Sep 03, 2003 at 02:33:56PM +1000, CaT wrote:
| > > I think Anton is referring to the fact that on a 4-way cpu machine with
| > > HT enabled you basically have an 8-way smp box (with special conditions)
| > > and so if 4-way machines are becoming more popular, making sure that 8-way
| > > smp works well is a good idea.
| > 
| > Maybe this is a better way to get my point across.  Think about more CPUs
| > on the same memory subsystem.  I've been trying to make this scaling point
| > ever since I discovered how much cache misses hurt.  That was about 1995
| > or so.  At that point, memory latency was about 200 ns and processor speeds
| > were at about 200Mhz or 5 ns.  Today, memory latency is about 130 ns and
| > processor speeds are about .3 ns.  Processor speeds are 15 times faster and
| > memory is less than 2 times faster.  SMP makes that ratio worse.
| > 
| > It's called asymptotic behavior.  After a while you can look at the graph
| > and see that more CPUs on the same memory doesn't make sense.  It hasn't
| > made sense for a decade, what makes anyone think that is changing?
| 
| You're right about the asymptotic behavior and you'll just get more
| right as time goes on, but other forces are at work.
| 
| What is changing is the number of cores per 'processor' is increasing. 
| The Intel Montecito will increase this to two, and rumor has it that the
| Intel Tanglewood may have as many as sixteen.  The IBM Power6 will
| likely be similarly capable.
| 
| The Tanglewood is not some far off flight of fancy; it may be available
| as soon as the 2.8.x stable series, so planning to accommodate it should
| be happening now.  
| 
| With companies like SGI building Altix systems with 64 and 128 CPUs
| using the current single-core Madison, just think of what will be
| possible using the future hardware. 
| 
| In four years, Michael Dell will still be saying the same thing, but
| he'll just fudge his answer by a factor of four. 

The mass market will still be in small machines, because the CPUs keep
on getting faster. And at least for most small servers running Linux,
like news, mail, DNS, and web, the disk, memory and network are more of
a problem than the CPU. Some database and CGI loads are CPU intensive,
but I don't see that the nature of loads will change; most aren't CPU
intensive.

| The question which will continue to be important in the next kernel
| series is: How to best accommodate the future many-CPU machines without
| sacrificing performance on the low-end?  The change is that the 'many'
| in the above may start to double every few years.

Since you can still get a decent research grant or graduate thesis out
of ways to use a lot of CPUs, there will not be a lack of thought on the
topic. I think Larry is just worried that some of these solutions may
really work poorly on smaller systems.

| Some candidate answers to this have been discussed before, such as
| cache-coherent clusters.  I just hope this gets worked out before the
| hardware ships.

Honestly, I would expect a good solution to scale better at the "more"
end of the range than the "less." A good 16-way approach will probably
not need major work for 256, while it may be pretty grim for the uni or
2-way counting HT machines.

With all the work people are doing on writing scheduler changes for
responsiveness, and the number of people trying them, I would assume a
need for improvement on small machines and response over throughput.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
