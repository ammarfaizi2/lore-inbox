Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287027AbRL1VGk>; Fri, 28 Dec 2001 16:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284136AbRL1VGb>; Fri, 28 Dec 2001 16:06:31 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51421 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S287027AbRL1VG1>;
	Fri, 28 Dec 2001 16:06:27 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 28 Dec 2001 21:06:25 GMT
Message-Id: <UTC200112282106.VAA133464.aeb@cwi.nl>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: "H. Peter Anvin" <hpa@zytor.com>

    > Unfortunately, I need to use zImage on my Tecra.  I know that zImage is
    > old, and I've heard that support for it will eventually be withdrawn,
    > but I don't really have much alternative right now unless there is
    > a patch which works around the Tecra's buggy A20 handling.

    Oh, by the way, the "I need to use zImage on my Tecra" thing is making
    it work by the use of voodoo.  It's rather unfortunate it worked on
    some systems -- it's going to fail randomly on you anyway; it's just a
    matter of which way the timings and cache items get jerked around.

    I have asked Alan for more details on the workaround, but perhaps the
    thing to do is to backport the latest 2.4 A20 code back to 2.2 and see
    if that solves the *real* problem, so bzImage works.

    I don't think there is any reason to believe zImage doesn't work
    unless bzImage works on your system.

I my A20 writeup (http://www.win.tue.nl/~aeb/linux/kbd/A20.html) I wrote:

------------------------------------------------------------------------
Jens Maurer reported in 1996 on boot problems with a bzImage kernel: 

    On the Toshiba laptop, the first two bytes at 0x100000 are incorrect
    and identical to those from address 0x000000 (which was an alias for
    0x100000 before the A20 gate enable). At a second read from 0x100000
    immediately afterwards, the correct memory content is returned.
    Asus P55TP5XE boards (Triton I chipset) show quite the same problem,
    but there, only the first byte is incorrect and booting bzImage kernels
    works fine. To me, this looks like some buffer or cache coherency
    problem although I think that caches are organized in at least 16
    byte cache lines. ... This exact same problem reportedly also exists
    on Fujitsu 555T (report from Andrea Caltroni) laptop and Compudyne
    Pentium 60 (report from David Kerr) desktop computers. 

He gives a patch, and adds "Unfortunately, Philip Hands reports that
the above patch makes some people with other non-laptop computers unable
to boot." 

Using zImage instead of bzImage avoids the problem (since zImage is not
loaded high). Debian has distributed special Tecra boot floppies for a while.
Later it was found out that these laptops just have an incredibly slow
keyboard controller and that all is fine with a larger timeout. 
------------------------------------------------------------------------

Is this inaccurate?

Andries
