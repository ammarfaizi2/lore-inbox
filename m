Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUGWATV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUGWATV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 20:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267496AbUGWATV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 20:19:21 -0400
Received: from bimba.bezeqint.net ([192.115.104.6]:60359 "EHLO
	bimba.bezeqint.net") by vger.kernel.org with ESMTP id S267495AbUGWATE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 20:19:04 -0400
Date: Fri, 23 Jul 2004 03:20:53 +0300
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: Video memory corruption during suspend
Message-ID: <20040723002053.GC17704@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
References: <20040718225247.GA30971@hell.org.pl> <20040722161047.GB15145@atrey.karlin.mff.cuni.cz> <40FFFB00.3030704@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FFFB00.3030704@blue-labs.org>
User-Agent: Mutt/1.5.6+20040523i
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 01:36:00PM -0400, David Ford wrote:
> Just as a side note, all of the notebooks I have owned or worked on have 
> had suspend issues.  Linux just doesn't handle it very well.  The common 
> problems on resume are:
> 

Actually all computers I worked with functioned great with software
suspend (up to solving dri issues), none of them managed to suspend
properly with windows (XP was worse them w2k).

> 1. the screen is somehow switched to the external VGA port or port other 
> than the LCD
> 2. the screen is 50% rolled; i.e. the whole screen has been shifted 
> halfway down the screen with the bottom wrapping back up to the top
> 3. on a text console, the characters are garbage/high ascii/blocks
> 4. the back light is off and can't be turned back on
> 
> Of these I'm currently dealing with #1, 2, and 3.  I can fix #1 by using 
> the Function-Display key to step through displays until I have
> selected 

Thats a weird one.

> the LCD display again.  I fix #2 by ctrl-alt-f1 and then back to X
> tty.  

If its an ATI with dri, I think it still needs a VT switch to reset the
driver. There was also something with nvidia I think. You should change
VT to the console and then change back on resume.

> I fix #3 by running setfont.  

Strange one also.

>I haven't had to deal with #4 in over a 
> year, but I no longer have that notebook.
> 

I had such problems a lot with windows and the screen saver. With linux
only when it got stuck (a over heating problem).

> Chris root # lspci -vvv -s 0:00.0
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
> Bridge (rev 04)
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort+ >SERR- <PERR-
>        Latency: 0
>        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
>        Capabilities: [e4] #09 [d104]
>        Capabilities: [a0] AGP version 2.0
>                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
> HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
>                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
> 
> Chris root # lspci -vvv -s 01:00.0
> 01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440 
> Go] (rev a3) (prog-if 00 [VGA])
>        Subsystem: Dell Computer Corporation: Unknown device 00d4
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 32 (1250ns min, 250ns max)
>        Interrupt: pin A routed to IRQ 11
>        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
>        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
>        Region 2: Memory at dff80000 (32-bit, prefetchable) [size=512K]
>        Expansion ROM at 80000000 [disabled] [size=128K]
>        Capabilities: [60] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [44] AGP version 2.0
>                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
> HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
>                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
> 
> no DRI/FB.
> 
> David
> 
> Pavel Machek wrote:
> 
> >Hi!
> >
> > 
> >
> >>My setup is:
> >>ASUS L3800C laptop, Radeon M7, i845 chipset, using DRI and radeonfb.
> >>
> >>Note that this is not specific to the kernel used, as I've been seeing 
> >>similar corruption every now and then, most recently under 2.6.7 +
> >>ACPICA20040715 + swsusp2.0.0.100 (S3, S4), but also under 2.4 with S1 
> >>(but not with S4/swsusp2).
> >>
> >>I have a very simple script I use to suspend (i.e. basically echo $arg >
> >>/proc/acpi/sleep), which is usually started by acpid. Once the script is
> >>triggered (by pressing power / sleep button) and an X session is running, 
> >>various red and green patches appear on the screen (the background image
> >>and the tinted terminal emulator), followed by the VT switch the PM code
> >>does. After resume and subsequent VT switch by the PM code the corruption
> >>is still visible. The screen is properly restored by a manual VT switch.
> >>The corruption is clearly related to the existing background pixmap, as
> >>moving the windows does not change its pattern. Oddly enough, starting a 
> >>GL
> >>app such as glxgears and moving it into and out of focus also properly
> >>restores the screen.
> >>   
> >>
> >
> >So what happens on 2.6.7 with swsusp1? Can you try vesafb (and fbdev
> >Xserver)?
> >
> >								Pavel
> > 
> >
> 
> 
> +++++++++++++++++++++++++++++++++++++++++++
> This Mail Was Scanned By Mail-seCure System
> at the Tel-Aviv University CC.

> begin:vcard
> fn:David Ford
> n:Ford;David
> email;internet:david@blue-labs.org
> title:Industrial Geek
> tel;home:Ask please
> tel;cell:(203) 650-3611
> x-mozilla-html:TRUE
> version:2.1
> end:vcard
> 
