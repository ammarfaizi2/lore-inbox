Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUH2CfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUH2CfW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 22:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267604AbUH2CfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 22:35:22 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46039 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267602AbUH2CfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 22:35:13 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <1093737080.1385.2.camel@krustophenia.net>
References: <20040823221816.GA31671@yoda.timesys>
	 <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu>  <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1093746912.1312.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 22:35:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 19:51, Lee Revell wrote:
> On Sat, 2004-08-28 at 17:16, Lee Revell wrote:
> > On Sat, 2004-08-28 at 17:13, Ingo Molnar wrote:
> > > ok, will add this to -Q4.
> > > 
> > 
> > Hrm, Q3 broke my PS/2 keyboard.
> > 

Some more info:

This bug is 100% reproducible.  During boot, as soon as the i8042 driver
is loaded:

serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0

the keyboard freezes, with 'Num Lock' stuck on.

The problem only occurs when CONFIG_PREEMPT_HARDIRQS=y.  Works fine
otherwise.

/proc/interrupts:

           CPU0       
  0:     509819          XT-PIC  timer
  1:       1649          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
 10:          0          XT-PIC  uhci_hcd, EMU10K1
 11:      24394          XT-PIC  uhci_hcd, eth0
 12:          0          XT-PIC  uhci_hcd
 14:          1          XT-PIC  ide0
 15:      12864          XT-PIC  ide1
NMI:          0 
ERR:          0

Lee

