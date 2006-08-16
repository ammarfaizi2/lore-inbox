Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWHPGpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWHPGpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 02:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWHPGpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 02:45:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750830AbWHPGp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 02:45:29 -0400
Date: Tue, 15 Aug 2006 23:45:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       support@moxa.com.tw
Subject: Re: [PATCH 1/1 -resend] Char: mxser, upgrade to 1.9.1
Message-Id: <20060815234512.0d3bc1d7.akpm@osdl.org>
In-Reply-To: <200608160831.12848.arekm@pld-linux.org>
References: <mxser191resend3_ee43092305ba163fd5d4@wsc.cz>
	<20060815225346.cf7ca950.akpm@osdl.org>
	<200608160831.12848.arekm@pld-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 08:31:12 +0200
Arkadiusz Miskiewicz <arekm@pld-linux.org> wrote:

> On Wednesday 16 August 2006 07:53, Andrew Morton wrote:
> > On Tue, 15 Aug 2006 04:00:14 -0700
> >
> > Jiri Slaby <jirislaby@gmail.com> wrote:
> > > Change driver according to original 1.9.1 moxa driver. Some int->ulong
> > > conversions, outb ~UART_IER_THRI constant. Remove commented stuff.
> > >
> > > I also added printk line with info, if somebody wants to test it, he
> > > should contact me as I can potentially debug the driver with him or just
> > > to confirm it works properly.
> >
> > Ho hum, this is hard.  I guess breaking the driver is one way to find out
> > who is using it, but those who redistribute the kernel for a living might
> > not appreciate the technique.
> >
> > Perhaps we could create an mxser-new.c and offer that in config, plan to
> > remove mxser.c N months hence?
> 
> I can test the updated driver with  MOXA CP-168U series board if it will 
> compile on 2.6.12.6.

Thanks.

> Unfortunately I can't change kernel to latest one there. 
> Will testing on 2.6.12.6 be enough for you?

It might be tough.  Applying this patch to 2.6.12:

patching file drivers/char/mxser.c
Hunk #3 succeeded at 60 (offset 3 lines).
Hunk #5 succeeded at 118 (offset 2 lines).
Hunk #7 FAILED at 170.
Hunk #8 succeeded at 207 (offset 2 lines).
Hunk #9 FAILED at 268.
Hunk #10 FAILED at 307.
Hunk #11 FAILED at 359.
Hunk #12 succeeded at 503 (offset -2 lines).
Hunk #13 FAILED at 656.
Hunk #14 FAILED at 810.
Hunk #15 succeeded at 925 (offset -22 lines).
Hunk #16 succeeded at 991 with fuzz 1 (offset -5 lines).
Hunk #17 succeeded at 983 with fuzz 2 (offset -22 lines).
Hunk #18 FAILED at 1144.
Hunk #19 FAILED at 1175.
Hunk #20 succeeded at 1212 (offset -15 lines).
Hunk #21 FAILED at 1233.
Hunk #22 succeeded at 1272 with fuzz 2 (offset -23 lines).
Hunk #23 FAILED at 1575.
Hunk #24 FAILED at 1656.
Hunk #25 FAILED at 1711.
Hunk #26 succeeded at 1777 (offset -34 lines).
Hunk #27 succeeded at 1908 (offset -25 lines).
Hunk #28 FAILED at 1939.
Hunk #29 FAILED at 2039.
Hunk #30 FAILED at 2065.
Hunk #31 FAILED at 2074.
Hunk #32 succeeded at 2085 (offset -32 lines).
Hunk #33 FAILED at 2119.
Hunk #34 FAILED at 2153.
Hunk #35 FAILED at 2188.
Hunk #36 succeeded at 2204 (offset -28 lines).
Hunk #37 FAILED at 2235.
Hunk #38 FAILED at 2663.
21 out of 38 hunks FAILED -- saving rejects to file drivers/char/mxser.c.rej
patching file include/linux/pci_ids.h
Hunk #1 FAILED at 1777.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/pci_ids.h.rej

That's no fun.

Perhaps it'll work if you apply the patch to 2.6.18-rc4 then copy the
patched files over to 2.6.12..
