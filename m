Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUA3Mmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 07:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUA3Mmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 07:42:43 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:29570 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S263762AbUA3Mmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 07:42:39 -0500
Date: Fri, 30 Jan 2004 14:42:36 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: process start times by procps
Message-ID: <20040130124236.GA8262@elektroni.ee.tut.fi>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20040123194714.GA22315@elektroni.ee.tut.fi> <20040125110847.GA10824@elektroni.ee.tut.fi> <20040127155254.GA1656@elektroni.ee.tut.fi> <1075342912.1592.72.camel@cog.beaverton.ibm.com> <20040129143847.GA4544@elektroni.ee.tut.fi> <1075405728.1592.100.camel@cog.beaverton.ibm.com> <20040129203340.GA1169@elektroni.ee.tut.fi> <20040129145148.47cae69a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129145148.47cae69a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 02:51:48PM -0800, Andrew Morton wrote:
> Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
> >
> > On Thu, Jan 29, 2004 at 11:48:49AM -0800, john stultz wrote:
> > > 
> > > Does George Anzinger's patch work as well?
> > 
> > I must have missed that... Any references?
> 
> This one.
> 
> diff -puN fs/proc/proc_misc.c~proc-stat-btime-fix-2 fs/proc/proc_misc.c

Yes, it works fine: btime stays at the correct value. Just the
ps-output-in-future-problem left.

Linux-2.6.1+patch without ntpd:
 passed time according to 'date':               11430.68524 s
 timer interrupts:                              11432383
 interrupts per second:                         1000.149
 error compared to 1000 interrupts per second:  +149 ppm
 ps times go towards future about 2.0 s:  about 170 ppm
 btime stays constant!
 clock too fast compared to ntp time by:        +0.260461 s
 so 'date' is too fast compared to UT by:       +22.8 ppm

Linux-2.6.1+patch with ntpd:
 passed time according to 'date':               14792.60765 s
 timer interrupts:                              14795154
 interrupts per second:                         1000.172
 error compared to 1000 interrupts per second:  +172 ppm
 ps times go towards future about 2.7 s:  about 180 ppm
 btime stays constant!
 (ntp.drift: -21.943)

-Petri
