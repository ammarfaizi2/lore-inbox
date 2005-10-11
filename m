Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbVJKIGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVJKIGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVJKIGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:06:43 -0400
Received: from mx1.suse.de ([195.135.220.2]:1413 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751414AbVJKIGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:06:42 -0400
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, discuss@x86-64.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
	<20051007122624.GA23606@tentacle.sectorb.msk.ru>
	<200510071431.47245.ak@suse.de>
	<20051008101153.GA1541@tentacle.sectorb.msk.ru>
	<1128967404.8195.419.camel@cog.beaverton.ibm.com>
	<20051010181216.GA21548@tentacle.sectorb.msk.ru>
	<434AB0BE.3080206@mysql.com>
	<20051011073532.GA29254@tentacle.sectorb.msk.ru>
From: Andi Kleen <ak@suse.de>
Date: 11 Oct 2005 10:06:33 +0200
In-Reply-To: <20051011073532.GA29254@tentacle.sectorb.msk.ru>
Message-ID: <p73ll10v5o6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vladimir B. Savkin" <master@sectorb.msk.ru> writes:

> On Mon, Oct 10, 2005 at 08:19:42PM +0200, Jonas Oreland wrote:
> > Hi,
> > 
> > check http://bugzilla.kernel.org/show_bug.cgi?id=5283
> 
> Excuse me for possibly dumb question, but is it safe to leave TSCs
> unsynchronized when using other time source?
> How will other subsystems e.g. traffic queueing disciplines react?

They might see hickups, but normally they all have relatively 
benign failure modes so I wouldn't worry too much.

If you use it on a Opteron with frequency scaling and multiple sockets
it would be safer to patch them to use do_gettimeofday() or better
monotonic_clock(), because the differences can be very large there
(CPUs running with completely different frequencies). Drawback would
be that it would be slower. On systems without frequency scaling
you would likely only see problems if at all after a long uptime.

For some subsystems it is ok, e.g. the scheduler which also uses
TSCs especially deals with unsynchronized clocks.

-Andi

