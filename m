Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUDCFff (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 00:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUDCFfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 00:35:34 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:47888 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261603AbUDCFfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 00:35:32 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1080970205@astro.swin.edu.au>
Subject: Re: solved (was Re: xterm scrolling speed - scheduling weirdness in 	2.6 ?!)
In-reply-to: <1080930132.1720.38.camel@localhost>
References: <1073227359.6075.284.camel@nosferatu.lan>  <20040104225827.39142.qmail@web40613.mail.yahoo.com>  <20040104233312.GA649@alpha.home.local>  <20040104234703.GY1882@matchmail.com>  <1073296227.8535.34.camel@tiger> <1080930132.1720.38.camel@localhost>
X-Face: +*%dmR:3=9i\[:8fga\UgZT#@`f=DU0(wQqI'AR2/r0sBMO}Ax\,V*cWaW-owRlUmuz&=v\KItx0:gRCBg1&z_"4x&-N#Di7))]~p2('`6|5.c3&:Z?VLU`Zt5Kb,~uC6<y}P'~7A+^'|'+iAd4t43:P;tPiT<q=9P$MO]u^@OHn1_4#qP7,XiSo21SkgI`:5=i$,t&uNN_\LfuLyH`)8!:Tb]Z
Message-ID: <slrn-0.9.7.4-9426-9838-200404031530-tc@hexane.ssi.swin.edu.au>
Date: Sat, 3 Apr 2004 15:35:29 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg <kernel@nn7.de> said on Fri, 02 Apr 2004 20:22:12 +0200:
> On Mon, 2004-01-05 at 10:50, Kenneth Johansson wrote:
> > On Mon, 2004-01-05 at 00:47, Mike Fedyk wrote:
> > > On Mon, Jan 05, 2004 at 12:33:12AM +0100, Willy Tarreau wrote:
> > > > at a time. I have yet to understand why 'ls|cat' behaves
> > > > differently, but fortunately it works and it has already saved
> > > > me some useful time.
> > > 
> > > cat probably does some buffering for you, and sends the output to xterm in
> > > larger blocks.
> > 
> > you can try with "ls |dd bs=1"
> > 
> > I also see this problem but it is not constant. I noticed that "ps ax"
> > sometimes takes like 10 times longer than usual. But I can only get this
> > in a gnome-terminal not in xterm. The problem is that it should really
> > not be that big difference when the load of the system is the same. 
> 
> Ok, there is indeed an issue in the *terminals. As above pointed out
> buffering the programs output helps. Also a usleep of 5ms in the read
> loop of the *terms would help.
> 
> I fixed this issue in multi-gnome-terminal by using a buffer of 32kb.
> It is filled as long as there is input comming in within 10ms.
> If the buffer is full or 10ms passed the buffer is written out to the
> screen. This makes it also 2-3 times faster on kernel 2.4.

A factor of 2 or 3 though?

In 2.4, to ls -lA my home directory with its 510 files, took less than
0.5 sec. Currently, buffering via cat in 2.6 takes 0.5 sec. Just
straight ls -lA takes 6 seconds or so.

Does your factor of 3 bring you up to what you were seeing in 2.4, or
do you still have a regression?

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Some witty text here,
can be any number of lines
long
