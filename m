Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbUKQRjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbUKQRjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbUKQReR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:34:17 -0500
Received: from bender.bawue.de ([193.7.176.20]:12170 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S262424AbUKQRcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:32:12 -0500
Date: Wed, 17 Nov 2004 18:31:18 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: local-/io-apic nmi watchdog failing on S2466
Message-ID: <20041117173118.GA5211@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm still having problems with nmi watchdog on my S2466 board.  I tried lots
of different configurations with a large number of 2.6 kernels (vanilla,
-mm, -ac) all with the same result: no working nmi watchdog, neither with
local- nor with io-apic. I still wonder if anybody out there has ever
succeeded with a working nmi watchdog on Tyan Tiger MPX.

The symptoms are:

nmi_watchdog=1:
===============
dmesg:
	testing NMI watchdog ... CPU#0: NMI appears to be stuck!
/proc/interrupts:
	no NMI count

nmi_watchdog=2:
===============
dmesg:
	testing NMI watchdog ... OK.
/proc/interupts:
	NMI count increments
recovery from lockup:
	none

nmi_watchdog=2 clock=pit:
=========================
dmesg:
	testing NMI watchdog ... CPU#0: NMI appears to be stuck!
/proc/interrupts:
	NMI count increments, but rate is ~ 1/20s
recovery from lockup:
	none

The lockup-test is done with a little program that Ingo posted on this
list:

int
main(void) {
        iopl(3);
        while (1)
                asm("cli");
        return 0;
}

The only reaction I can see from this test: after some seconds (5+) the LEDs
on the keyboard start blinking when nmi_watchdog=2 and clock!=pit.
Always need to hit the reset button :-(

What else could I try?  Are there any BIOS-settings relevant to a
working nmi-watchdog? What information is needed to track down this
problem?

Maybe it's the board's failure, but as there *are* counted NMIs I still
hope there is a software solution to this problem.

Thanks,
-jo

-- 
-rw-r--r--  1 jo users 63 2004-11-17 17:45 /home/jo/.signature
