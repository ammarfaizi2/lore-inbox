Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284701AbRLDAVI>; Mon, 3 Dec 2001 19:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284669AbRLDAO6>; Mon, 3 Dec 2001 19:14:58 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55283 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S285173AbRLCVQE>; Mon, 3 Dec 2001 16:16:04 -0500
Message-ID: <3C0BEB90.16DC3749@mvista.com>
Date: Mon, 03 Dec 2001 13:16:00 -0800
From: Jeremy Siegel <jsiegel@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linuxsh-dev@lists.sourceforge.net
CC: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [linuxsh-dev] [PATCH] Preemptible kernel for SH
In-Reply-To: <1007261428.820.4.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI... the preemptible kernel depends on non-preemptible critical regions
denoted by spinlock calls (see Robert Love's excellent summary in
Documentation/preempt-locking.txt).  Many common drivers are assumed to have
correct locking for SMP operation, but non-SMP drivers may not. I've only run
the PreK SH kernel on the Solution Engine w/Ethernet and serial, but I did not
yet check to see if additional locks might be required in drivers/char/sh-sci.c
or drivers/net/stnic.c, which are specific to SH platforms and thus not SMP-safe
otherwise.

--Jeremy

Robert Love wrote:

> The attached is the fully preemptible linux kernel patch, for the SH
> arch.  This work is thanks to Jeremy Siegel of MontaVista.
>
> You will need an SH-patched kernel tree, available from
> http://sf.net/projects/linuxsh -- the CVS module "linux" has a drop-in
> replacement for 2.4.16.
>
> You will need the base preempt-kernel patch, available from
> ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel
>
> Feedback is desired.
>
>         Robert Love

