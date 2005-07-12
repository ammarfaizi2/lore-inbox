Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVGLHRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVGLHRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVGLHRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:17:10 -0400
Received: from relay.felk.cvut.cz ([147.32.80.7]:37638 "EHLO
	relay.felk.cvut.cz") by vger.kernel.org with ESMTP id S261202AbVGLHRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:17:09 -0400
Date: Tue, 12 Jul 2005 09:16:52 +0200
From: Hamera Erik <HAMERAE@cs.felk.cvut.cz>
To: Pavel Machek <pavel@ucw.cz>
CC: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: arm: how to operate leds on zaurus?
In-Reply-To: <20050711195059.GA2219@elf.ucw.cz>
Message-ID: <Pine.VMS.3.91-2(vms).1050712090739.8264C-100000@cs.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9, required 5,
	autolearn=not spam, BAYES_00 -4.90)
X-FELK-MailScanner-From: hamerae@cs.felk.cvut.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 2.6.12-rc5 (and newer) does not boot on sharp zaurus sl-5500. It
> > > blinks with green led, fast; what does it mean? I'd like to verify if
> > > it at least reaches .c code in setup.c. I inserted this code at
> > > begining of setup.c:674...
> > > 
> > > #define locomo_writel(val,addr) ({ *(volatile u16 *)(addr) = (val); })
> > > #define LOCOMO_LPT_TOFH         0x80
> > > #define LOCOMO_LED              0xe8
> > > #define LOCOMO_LPT0             0x00
> > > 
> > >       locomo_writel(LOCOMO_LPT_TOFH, LOCOMO_LPT0 + LOCOMO_LED);
> > > 
> > > ...but that does not seem to do a trick -- it only breaks the boot :-(
> > 
> > Basically because you do not have access to IO during the early boot.
> > The easiest debugging solution is to enable CONFIG_DEBUG_LL and
> > throw a printascii(printk_buf) into printk.c, after vscnprintf.
> > That might get you some boot messages through the serial port (if
> > it's implemented it correctly.)
> 
> I'm afraid I do not have serial cable :-(. I'll try to get one [erik,
> do you have one you don't need?], but zaurus has "little" nonstandard
> connector.

I am sorry, I sold my SL-5500 before a few days. For build serial 
cable you need: connector, two negator gates (CMOS 4011, 74HCT00 ...), 
MAX232 (RS232 voltage level convertor) and DB9 serial connector. Circuit 
is a bit strange, because Zaurus have inverted TxD and RxD signals.
All parts I can buy in .cz without problems, only connector I can't.

Yokotashi

> 
> Would code above work if executed later?
> 								Pavel
> -- 
> teflon -- maybe it is a trademark, but it should not be.
> 
