Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVAEVGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVAEVGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVAEVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:06:07 -0500
Received: from mail1.kontent.de ([81.88.34.36]:24259 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262586AbVAEVFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:05:46 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Swsusp hanging the second time
Date: Wed, 5 Jan 2005 22:04:34 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200501041154.19030.oliver@neukum.org> <20050104110839.GF18777@elf.ucw.cz>
In-Reply-To: <20050104110839.GF18777@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501052204.34646.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 4. Januar 2005 12:08 schrieb Pavel Machek:
> Hi!
> 
> > there's a second, more serious problem with this laptop. It hangs the
> > in the second swsusp cycle on suspension.
> > As before 2.6.10, i386/UP/no highmem.
> > On the screen I get the two messages "radeonfb resumed!" and
> > "setting latency" superimposed and it hangs forever. This is a regression
> > the previous user commented: "It worked under 2.6.6"
> 
> Unless it was on the same hardware/config, I'd not call it regression.
> 
> Anyway two suspends in the row seem to work here on 2.6.10+my
> patches. I suspect you have problems with some more obscure driver.
> 
> Can you try going with minimal driver config to see if it is
> reproducible? If it is broken even with minimal drivers, I'll try
> harder to reproduce it here (but I believe it will just go away).

The culprit seems to be EHCI, possibly together with UHCI only.

0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff10
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1200 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff10
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1220 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff10
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1240 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03) (prog-if 20 [EHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff10
        Flags: bus master, medium devsel, latency 0
        Memory at f4000000 (32-bit, non-prefetchable)
        Capabilities: <available only to root>

	Regards
		Oliver
