Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVCFKy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVCFKy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVCFKy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:54:57 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:32718 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261362AbVCFKyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:54:53 -0500
Date: Sun, 6 Mar 2005 02:54:51 -0800
From: Chris Wedgwood <cw@f00f.org>
To: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix for 8250.c *wrongly* detecting XScale UART(s) on x86 PC
Message-ID: <20050306105451.GA4204@taniwha.stupidest.org>
References: <20050306093321.GA3040@taniwha.stupidest.org> <20050306101912.A19558@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306101912.A19558@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 10:19:12AM +0000, Russell King wrote:

> If it breaks here (due to your ports being "embraced and extended") it
> could well break elsewhere, and wrapping it in CONFIG_ARM doesn't solve
> that.

Yeah, I forgot other ARM stuff might have regular UART(s) which
potentially would break here too.

> I'm not sure what the solution to this is, but unless we can
> autodetect the port "type", it rather screws the current direction
> of 8250, which has been to move away from port types to a set of
> port capabilities.

Well, as I see it there are three types of serial port knowledge:

(1) Ports we know for (almost) certain we have.  For x86* we can
    probably assume ttyS0 has some fairly standard values like 0x3f8,4
    and if not expect the user to specify otherwise.

(2) Ports we know for (almost) certain we don't have.  We have
    #ifdef's for this in places already.  Basically things like PPC
    and ARM/XScale UARTs won't be found on PCs (though the reverse is
    clearly not true).

(3) Everything else.

If (1) & (2) end up being pretty limited and the bulk of 8250.c is
required for (3) then changing things around probably isn't worth
while at all.

> I wonder if its possible to get hold of any documentation for your
> misdetected serial port...

I assumed it's part of the AMD-768 southbridge but the documentation
for that mentions no UARTs so I wonder if it's an external chip
hanging of the LPC bus?  I'll have a closer look tomorrow if that will
help.
