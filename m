Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbTLIOJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265858AbTLIOJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:09:57 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13269
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265856AbTLIOJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:09:52 -0500
Date: Tue, 9 Dec 2003 15:11:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1 - scsi/pcmcia qlogic still does not build (m)
Message-ID: <20031209141113.GA12532@dualathlon.random>
References: <20031205022225.GA1565@dualathlon.random> <3FD07392.A47A0A6D@eyal.emu.id.au> <20031205230922.GF2121@dualathlon.random> <3FD13E30.54A1CAFF@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD13E30.54A1CAFF@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 01:25:52PM +1100, Eyal Lebedinsky wrote:
> Andrea Arcangeli wrote:
> > Also for the i2c troubles (you mentioned those last time), you can try
> > if this helps.
> 
> I applied fixes similar to your suggestion to i2c-2.7.0
> and lm_sensors-2.7.0 to get these to build, looks OK.
> 
> My final depmod has this problem though:
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.23aa1/kernel/drivers/video/sis/sisfb.o
> depmod:         __floatsidf
> depmod:         __divdf3
> depmod:         __fixunsdfsi
> depmod:         __muldf3
> depmod:         __adddf3
> 
> I do not have this problem with 2.4.23, and I see the -aa1 patch
> actually removing some FP ops. But therer are some left in other
> sources (e.g. sis_main.c) so maybe some link problem was exposed?

yes I've a 150k compressed updated driver from Thomas Winischhofer in my
inbox for Marcelo that should fix those bugs (that would obsolete the
non complete 00_sis-fpu-bugs-1), I thought it was merged in mainline but
obviously not as 00_sis-fpu-bugs-1 wouldn't apply anymore. I guess
Marcelo rejected it because it was very big and it wasn't fix the strict
fpu bugs revealed by the -msoft-float, just guessing.

> Reverting the sis/init.c hunk does not fix this. Can it be related
> to this in arch/i386/Makefile:
> 
> -CFLAGS += -pipe
> +CFLAGS += -pipe -msoft-float

yes it's related, reverting it would hide the bug, the module would
load again but userspace could be corrupted at runtime.
