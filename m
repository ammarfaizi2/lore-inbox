Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWIMUSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWIMUSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWIMUSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:18:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26851 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751167AbWIMUSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:18:20 -0400
Date: Wed, 13 Sep 2006 17:18:05 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alex Williamson <alex.williamson@hp.com>, rmk+serial@arm.linux.org.uk,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 8250 UART backup timer
Message-ID: <20060913201805.GB4787@cathedrallabs.org>
References: <1151435054.11285.41.camel@lappy> <44A183C5.6050002@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A183C5.6050002@zytor.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alex Williamson wrote:
> >   The patch below works around a minor bug found in the UART of the
> >remote management card used in many HP ia64 and parisc servers (aka the
> >Diva UARTs).  The problem is that the UART does not reassert the THRE
> >interrupt if it has been previously cleared and the IIR THRI bit is
> >re-enabled.  This can produce a very annoying failure mode when used as
> >a serial console, allowing a boot/reboot to hang indefinitely until an
> >RX interrupt kicks it into working again (ie. an unattended reboot could
> >stall).
> >
> >   To solve this problem, a backup timer is introduced that runs
> >alongside the standard interrupt driven mechanism.  This timer wakes up
> >periodically, checks for a hang condition and gets characters moving
> >again.  This backup mechanism is only enabled if the UART is detected as
> >having this problem, so systems without these UARTs will have no
> >additional overhead.
> >
> >   This version of the patch incorporates previous comments from Pavel
> >and removes races in the bug detection code.  The test is now done
> >before the irq linking to prevent races with interrupt handler clearing
> >the THRE interrupt.  Short delays and syncs are also added to ensure the
> >device is able to update register state before the result is tested.
> >Comments?  Thanks,
> >
> 
> I have seen this same bug in soft UART IP from "a major vendor."
did you had chance to test this patch on these machines to see if it
solves the problem?

Thanks,

-- 
Aristeu

