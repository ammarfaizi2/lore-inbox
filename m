Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUCaNHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 08:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUCaNHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 08:07:51 -0500
Received: from mail.tmr.com ([216.238.38.203]:4103 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261947AbUCaNHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 08:07:50 -0500
Date: Wed, 31 Mar 2004 08:04:10 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Len Brown <len.brown@intel.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
In-Reply-To: <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.3.96.1040331075620.11879A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Maciej W. Rozycki wrote:

> On Tue, 30 Mar 2004, Bill Davidsen wrote:
> 
> > Is there no reasonable way to avoid using it in ACPI? It's not as if 
> > performance was critical there, or the code gets run often. Too bad it 
> > can't just be emulated like floating point, but I don't think it can on SMP.
> 
>  Well, "cmpxchg", "xadd", etc. can be easily emulated with an aid of a
> spinlock.  With SMP operation included.

Clearly they can be replaced with inline code, as for catching the ill-op
fault and emulating inline, I want to think about that a bit on SMP, in
the case where multiple CPUs are accessing different locations, one is in
kernel and one in user mode, etc.

If it can be emulated safely in all cases, then that provides an out for
the 386 case. To be useful it would have to be correct for all
combinations of SMP, preempt and an interrupt and any point.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

