Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTLFCZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 21:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTLFCZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 21:25:58 -0500
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:3272 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S264929AbTLFCZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 21:25:57 -0500
Message-ID: <3FD13E30.54A1CAFF@eyal.emu.id.au>
Date: Sat, 06 Dec 2003 13:25:52 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1 - scsi/pcmcia qlogic still does not build (m)
References: <20031205022225.GA1565@dualathlon.random> <3FD07392.A47A0A6D@eyal.emu.id.au> <20031205230922.GF2121@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Also for the i2c troubles (you mentioned those last time), you can try
> if this helps.

I applied fixes similar to your suggestion to i2c-2.7.0
and lm_sensors-2.7.0 to get these to build, looks OK.

My final depmod has this problem though:

depmod: *** Unresolved symbols in
/lib/modules/2.4.23aa1/kernel/drivers/video/sis/sisfb.o
depmod:         __floatsidf
depmod:         __divdf3
depmod:         __fixunsdfsi
depmod:         __muldf3
depmod:         __adddf3

I do not have this problem with 2.4.23, and I see the -aa1 patch
actually removing some FP ops. But therer are some left in other
sources (e.g. sis_main.c) so maybe some link problem was exposed?

Reverting the sis/init.c hunk does not fix this. Can it be related
to this in arch/i386/Makefile:

-CFLAGS += -pipe
+CFLAGS += -pipe -msoft-float

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
