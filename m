Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbTGRTXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270295AbTGRTXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:23:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:32985 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270283AbTGRTXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:23:41 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Jul 2003 12:31:21 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Valdis.Kletnieks@vt.edu
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O6int for interactivity 
In-Reply-To: <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.55.0307181038450.5608@bigblue.dev.mcafeelabs.com>
References: <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org> <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net> <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
 <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.com>           
 <Pine.LNX.4.55.0307181004200.5608@bigblue.dev.mcafeelabs.com>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 18 Jul 2003 10:05:05 PDT, Davide Libenzi said:
> > On Fri, 18 Jul 2003, Davide Libenzi wrote:
> >
> > > control them. It is right to apply uncontrolled unfairness to userspace
> > > tasks though.
> >
> > s/It is right/It is not right/
>
> OK.. but is it right to apply *controlled* unfairness to userspace?

I'm sorry to say that guys, but I'm afraid it's what we have to do. We did
not think about it when this scheduler was dropped inside 2.5 sadly. The
interactivity concept is based on the fact that a particular class of
tasks characterized by certain sleep->burn patterns are never expired and
eventually, only oscillate between two (pretty high) priorities. Without
applying a global CPU throttle for interactive tasks, you can create a
small set of processes (like irman does) that hit the coded sleep->burn
pattern and that make everything is running with priority lower than the
lower of the two of the oscillation range, to almost completely starve.
Controlled unfairness would mean throttling the CPU time we reserve to
interactive tasks so that we always reserve a minimum time to non
interactive processes.



- Davide

