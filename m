Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266392AbUFQHDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266392AbUFQHDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 03:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUFQHDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 03:03:07 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:18443 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266392AbUFQHDD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 03:03:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: root@chaos.analogic.com, eliot@cincom.com
Subject: Re: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across context switches
Date: Thu, 17 Jun 2004 09:43:23 +0300
X-Mailer: KMail [version 1.4]
Cc: Linux kernel <linux-kernel@vger.kernel.org>, tgriggs@key.net
References: <200406162032.NAA29397@central.parcplace.com> <Pine.LNX.4.53.0406161652120.541@chaos>
In-Reply-To: <Pine.LNX.4.53.0406161652120.541@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406170943.23622.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 June 2004 00:03, Richard B. Johnson wrote:
> On Wed, 16 Jun 2004 eliot@cincom.com wrote:
> > Hi,
> >
> > 	I am the team lead and chief VM developer for a Smaltalk implementation
> > based on a JIT execution engine.  Our customers have been seeing rare
> > incorrect floating-point results in intensive fp applications on 2.6
> > kernels using various x86 compatible processors.  These problems do not
> > occur on previous kernel versons.  We recently had occasion to
> > reimplement our fp primitives to avoid severe performance problems on
> > Xeon processors that were traced to Xeon's relatively slow implementation
> > of fnclex and fstsw.  The older implementaton would produce a result and
> > test for a valid (non NaN, non Inf) result by examining the FPU status
> > flags via fstsw.  The newer implementation produces a result and tests
> > its exponent for the NaN/Inf exponent.  The new implementation does not
> > show the rare incorrect floating-point results in intensive fp
> > applications on 2.6 kernels.  My conclusion is that context switches

wow. Perfect place to install debug code.
Check _both_ exponent and flags, if they disagree, yell.
That may give some useful info about cause of this.

BTW, I didn't pay attention, but some FPU-related patches
were floating around just recently. Check list archives.

> > between the production of the result and the execution of the fstsw are
> > the culprit, and that the context switch machinery fails to preserve the
> > FPU status flags.
> >
> > I don't know whether any action on your part is appropriate.  The use of
> > the FPU status flags is presumably rare on linux (I believe that neither
> > gcc nor glibc make use of them).  But "exotic" execution machinery such
> > as runtimes for dynamic or functional languages (language implementations
> > that may not use IEEE arithmetic and instead flag Infs and NaNs as an
> > error) may fall foul of this issue.  Since previous versions of the
> > kernel on x86 apparently do preserve the FPU status flags perhaps its
> > simple to preserve the old behaviour.  At the very least let me suggest
> > you document the limitation.
-- 
vda
