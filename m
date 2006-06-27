Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWF0TPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWF0TPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWF0TPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:15:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:40131 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932541AbWF0TPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:15:44 -0400
Message-ID: <44A183C5.6050002@zytor.com>
Date: Tue, 27 Jun 2006 12:15:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: rmk+serial@arm.linux.org.uk, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 8250 UART backup timer
References: <1151435054.11285.41.camel@lappy>
In-Reply-To: <1151435054.11285.41.camel@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson wrote:
>    The patch below works around a minor bug found in the UART of the
> remote management card used in many HP ia64 and parisc servers (aka the
> Diva UARTs).  The problem is that the UART does not reassert the THRE
> interrupt if it has been previously cleared and the IIR THRI bit is
> re-enabled.  This can produce a very annoying failure mode when used as
> a serial console, allowing a boot/reboot to hang indefinitely until an
> RX interrupt kicks it into working again (ie. an unattended reboot could
> stall).
> 
>    To solve this problem, a backup timer is introduced that runs
> alongside the standard interrupt driven mechanism.  This timer wakes up
> periodically, checks for a hang condition and gets characters moving
> again.  This backup mechanism is only enabled if the UART is detected as
> having this problem, so systems without these UARTs will have no
> additional overhead.
> 
>    This version of the patch incorporates previous comments from Pavel
> and removes races in the bug detection code.  The test is now done
> before the irq linking to prevent races with interrupt handler clearing
> the THRE interrupt.  Short delays and syncs are also added to ensure the
> device is able to update register state before the result is tested.
> Comments?  Thanks,
> 

I have seen this same bug in soft UART IP from "a major vendor."

	-hpa
