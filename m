Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275309AbTHMSe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275317AbTHMSe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:34:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31755 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275309AbTHMSe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:34:27 -0400
Date: Wed, 13 Aug 2003 19:34:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus serial port ttyS02
Message-ID: <20030813193418.D20676@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
References: <Pine.GSO.4.21.0308131601070.11378-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0308131601070.11378-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Wed, Aug 13, 2003 at 05:40:23PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 05:40:23PM +0200, Geert Uytterhoeven wrote:
> Linux always finds 3 serial ports instead of 2:
> 
> | ttyS00 at 0x03f8 (irq = 4) is a 16550A
> | ttyS01 at 0x02f8 (irq = 3) is a 16550A
> | ttyS02 at 0x03e8 (irq = 4) is a 16450
> 
> The last one is bogus.

Do you know that it absolutely does not exist?  Can it exist on any
PPC box?  If the answer to both those questions is no, I suggest
you don't probe for it in the first place.

You could enable DEBUG_AUTOCONF in 8250.c in 2.6.0-test3 and give
further probing information. 8)

Looking at PPC's pc_serial.h, it seems that you've told it to probe
there using ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ.

ASYNC_SKIP_TEST means that we use a reduced test to probe for a port -
we just check that we can read back a value written to 0x3e9.  If this
suceeds, we decide that there is a port present, and go on to try and
derive its type.

If you want to enable the more rigorous tests, remove ASYNC_SKIP_TEST
from the port flags.  This will make us check that the device behaves
like a UART before deciding that it is one.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

