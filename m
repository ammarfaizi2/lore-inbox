Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTKZBAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 20:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTKZBAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 20:00:40 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:42946 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263883AbTKZBAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 20:00:37 -0500
Subject: Re: -test10/PPC still broken on PowerMac 8500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1AOnxb-0001nF-00@penngrove.fdns.net>
References: <E1AOnxb-0001nF-00@penngrove.fdns.net>
Content-Type: text/plain
Message-Id: <1069808393.671.87.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 26 Nov 2003 11:59:54 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-26 at 11:55, John Mock wrote:
> Most of these are SCSI issues and the last one makes -test10 hard to debug.
> 
> * MESH gets SLAB errors during startup, CDROM eject

Those are still the same good old issues, you have to disable SLAB
debugging unfortunately, at least until there is a better fix, but
so far there isn't.

> * "mac53c94: module license 'unspecified' taints kernel."

Ok.

> * "53C94 did not call scsi_unregister" [sorry, should have filed bug report]

Ok.

> * 'swim3.c' doesn't compile properly

Yup, known. My 8500 is sitll on the boat from france and I had my
time lately taken 200% by the G5 port.

> * Switching from X to text console ('controlfb' frame buffer) loses video 
>   sync.

Known.

> The 53C94 problems probably aren't hard to fix.  For the floppy code (that 
> is, 'swim3.c'), 'benh' has a version of 'swim3' which may only need further
> testing.  The MESH issue looks like a buffer alignment problem, and worked 
> without complaint in the 2.4 kernels.  

It's a problem. The SCSI stack is passing us unaligned buffers when slab
debugging is enabled, thus triggering a HW issue with those unaligned
buffers (the chip writes before the beginning of the buffer)

> The video mode problem is a real nuisance and is the biggest reason i'm not
> doing more than intermittent testing of 2.6.0/PPC.

I'd appreciate if you could track it down as I won't have access to the
8500 for a few weeks still.

> 			         -- JM
> 
> 
> P.S.  I came across a large pile of floppies during a massive cleanup (why
> i've been so busy) and i can run some more tests of the 'swim3' code after 
> the Thanksgiving break

Ok.

Ben.


