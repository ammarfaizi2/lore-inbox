Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTLEIQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 03:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTLEIQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 03:16:28 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:50838 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263298AbTLEIQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 03:16:25 -0500
Date: Fri, 5 Dec 2003 09:16:23 +0100
From: cheuche+lkml@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11) - IRQ flood related ?
Message-ID: <20031205081623.GA4043@localnet>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FCF25F2.6060008@netzentry.com> <1070551149.4063.8.camel@athlonxp.bradney.info> <20031204163243.GA10471@forming> <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org> <20031204175548.GB10471@forming> <20031204200208.GA4167@localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204200208.GA4167@localnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just seen something strange about IRQ7, during one test, the
interrupt counter on IRQ7 was in sync with the timer counter, and the
difference was about 21400. I rebooted to see what happens at 21.4
seconds after boot and it is more or less the time some modules get
loaded by auto-detecting hardware. But unfortunately I now cannot
reproduced it, I only get bursts of IRQ7 as initially reported.

I also noted in dmesg of 2.6.0-test that part about timer interrupt :

..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.

This is interesting because 2.4.22 and 2.4.23-pre9 shows :

..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.

and then the timer is not in XT-PIC mode but IO-APIC-edge mode, and I
also noticed there is no flood of IRQ7 with these 2.4 kernels. Is it 
Related or not with the IRQ flood or the lockups I don't know.

By the way 2.4.23 shows the same thing as 2.6.0-test, timer in XT-PIC
mode and some IRQ7, but way less than 2.6.0-test.

Mathieu
