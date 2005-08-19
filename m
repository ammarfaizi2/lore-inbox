Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVHSINx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVHSINx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 04:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVHSINx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 04:13:53 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:36272 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932258AbVHSINx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 04:13:53 -0400
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200508190813.j7J8Dml28378@inv.it.uc3m.es>
Subject: sleep under spinlock, sequencer.c, 2.6.12.5
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Fri, 19 Aug 2005 10:13:48 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following "sleep under spinlock" is still present as of linux
2.6.12.5 in sound/oss/sequencer.c in midi_outc:


        n = 3 * HZ;             /* Timeout */

        spin_lock_irqsave(&lock,flags);
        while (n && !midi_devs[dev]->outputc(dev, data)) {
                interruptible_sleep_on_timeout(&seq_sleeper, HZ/25);
                n--;
        }
        spin_unlock_irqrestore(&lock,flags);


I haven't thought about it, just noted it. It's been there forever
(some others in the sound architecture have been gradually disappearing
as newer kernels come out).


This code found during an analysis of about 1.5 million lines of kernel
code by the static kernel code analyser at

   ftp://oboe.it.uc3m.es/pub/Programs/c-1.2.*.tgz

(and yes, I am the author - if anyone wants to help please contact me).

Peter
