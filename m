Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282971AbRK0Vg2>; Tue, 27 Nov 2001 16:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282970AbRK0VgS>; Tue, 27 Nov 2001 16:36:18 -0500
Received: from femail18.sdc1.sfba.home.com ([24.0.95.145]:8322 "EHLO
	femail18.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282969AbRK0VgA>; Tue, 27 Nov 2001 16:36:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: CS423x audio driver updates for testing
Date: Tue, 27 Nov 2001 13:34:53 -0500
X-Mailer: KMail [version 1.2]
Cc: whampton@staffnet.com, cobra@linse.ufsc.br
In-Reply-To: <E164Ja5-0007qT-00@the-village.bc.nu>
In-Reply-To: <E164Ja5-0007qT-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01112713345300.01486@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 November 2001 05:17, Alan Cox wrote:
> This gets rid of the nasty clicks on the thinkpad. On the TP600 this leaves
> us with fully functional sound including save/restore (if your bios is
> not too ancient at least). The mixer changes are from Daniel Cobra, I added
> the ident changes and made the driver pick the right (I hope) feature sets
> for each board.
>
> Can folks with cs42xx series audio give it a test make sure it doesn't
> break anything
>
> Alan

Well, it didn't break anything, but it didn't fix my no-sound after suspend 
problem.

Without your patch, sound on my dell inspiron 3500 laptop works fine until 
the first APM suspend and resume cycle, after which noatun under KDE will 
block indefinitely trying to write sound and trying sound from the command 
line (no X/KDE running) can get a little sound out sometimes, but it loops 
endlessly with warnings printing to the console about an IRQ problem.  To get 
sound working again, I have to power the laptop off and back on.

I just applied the patch against 2.5.0 (with the 
don't-eat-your-filesystem-on-shutdown patch as well: hey, it's 2.5, it's 
supposed to do that, isn't it?) and it made no noticeable difference.

lspci produces the same output before and after APM suspend.  It's a strange 
chipset, but it's using the ad1848 sound driver:

lspci -s 01:00.1 -v -v

01:00.1 Multimedia audio controller: Neomagic Corporation [MagicMedia 256AV 
Audio] (rev 12)
        Subsystem: Dell Computer Corporation MagicMedia 256AV Audio Device on 
Colorado Inspiron
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B+
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at fe000000 (32-bit, prefetchable) [size=4M]
        Region 1: Memory at fe700000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Any clues?

Rob
