Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261995AbSI3KCf>; Mon, 30 Sep 2002 06:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261999AbSI3KCf>; Mon, 30 Sep 2002 06:02:35 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:52496 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261995AbSI3KCe>; Mon, 30 Sep 2002 06:02:34 -0400
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <20020930094012.GC20605@redhat.com>
To: Tim Waugh <twaugh@redhat.com>
Date: Mon, 30 Sep 2002 12:07:51 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, serial24@macrolink.com,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17vxSx-0004cg-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What was wrong with the original, much smaller patch that you sent me
> previously (below)?

It was a hack (more a proof of concept where the problem was), and
Pavel Janik had some trouble with it (it hung before detecting the PCI
serial ports, while changing the link order worked fine - not sure why,
could this be a kernel stack overflow resulting from calling rs_init()
from within parport code instead of directly from the top level?).

My most recent patch simply moves parport_serial.c to a different
directory - that's why the patch is so big, but it doesn't otherwise
change a single line in that moved file (I split NetMos support to
the next patch, after this one is accepted and possible NetMos bugs
are resolved - works fine here with parport in polling mode, IRQ
sharing with serial ports not tested).

After the parport_serial.c move, the init order would be:
 - parport
 - serial
 - parport_serial (needs both of the above initialized first)
 - other char/block/net drivers (some of them might need the parallel
   ports, including the PCI ones: lp, paride, plip - so moving all of
   parport after char/block/net would be wrong)

> I'm happy to accept whichever patch is the better.

I'd suggest the more recent (larger, but not really...) one.

Thanks,
Marek

