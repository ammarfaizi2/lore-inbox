Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSGEO7z>; Fri, 5 Jul 2002 10:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSGEO7y>; Fri, 5 Jul 2002 10:59:54 -0400
Received: from [193.14.93.89] ([193.14.93.89]:38148 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S317471AbSGEO7y>;
	Fri, 5 Jul 2002 10:59:54 -0400
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cyrix IRQ routing is wrong?
References: <ag05ab$1gc$1@penguin.transmeta.com>
	<200207040848.g648mrm03698@verdi.et.tudelft.nl>
From: Christer Weinigel <wingel@acolyte.hack.org>
Date: 05 Jul 2002 17:02:26 +0200
In-Reply-To: Rob van Nieuwkerk's message of "Thu, 04 Jul 2002 10:48:53 +0200"
Message-ID: <m3sn2y43r1.fsf@acolyte.hack.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob van Nieuwkerk <robn@verdi.et.tudelft.nl> writes:
> PS: anyone else seeing screen corruption in console/text mode with these
>     boards ? (some chracters from before a screen update stay on the screen).
> 
> board:
> ------
> Axiom Technology, SBC84510VEE, 3.5" Capa board, 300 MHz Geode

The Geode doesn't really have a text mode, VGA is simulated in SMI
mode by the "VSA BIOS", which is more or less buggy depending on what
exact BIOS revision you are using.  In text mode, each byte written to
the screen will result in a SMI interrupt that then draws into the
real hardware frame buffer.

My suggestion is to never ever use the text mode on a Geode platform
and instead use the VESA framebuffer to seleect a framebuffer mode
that is directly supported by the hardware.  That way mode, only
modifications of the resolution or the palette will result in SMI
interrupts and that code does not seem to be as buggy as the text mode
emulation.

    /Christer

-- 
"Just how much can I get away with and still go to heaven?"
