Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUI0JKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUI0JKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUI0JIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:08:16 -0400
Received: from mrt-aod.iram.es ([150.214.224.146]:22035 "EHLO mrt-lx16.iram.es")
	by vger.kernel.org with ESMTP id S266543AbUI0JHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:07:45 -0400
Date: Mon, 27 Sep 2004 09:07:20 +0000
From: Gabriel Paubert <paubert@iram.es>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040927090720.A12831@mrt-lx16.iram.es>
References: <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru> <20040924214330.GD8151@vana.vc.cvut.cz> <20040925080426.GB12901@iram.es> <415563C7.8000701@aknet.ru> <20040925191808.GA5901@iram.es> <4155D7D2.8000705@aknet.ru> <20040925234214.GA10603@iram.es> <415704C7.60704@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415704C7.60704@aknet.ru>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 10:04:55PM +0400, Stas Sergeev wrote:

	Hi,

On Sun, Sep 26, 2004 at 10:04:55PM +0400, Stas Sergeev wrote:
> OK, I agree, so I tested that: wrote some value
> to the higher word of ESP in the struct that
> dosemu passes to vm86() syscall, let the prog
> to run for a while, and the value was still there.
> It is not 100% reliable test because I can't
> guarantee the vm86() was interrupted during the
> period I was waiting (because vm86() is executed
> for the short durations, then exits on fault or
> signal), but it looks OK and why not to beleive
> Petr that v86 is not affected.

Should be enough, you'll likely get at least a timer 
interrupt in the middle of v86 mode sooner or later.

> 
> >>http://www.tenberry.com/dos4g/watcom/rn4gw.html
> >>---
> >>B ** Fixed the mouse32 handler to ignore a Microsoft Windows DOS box bug
> >>    which mangles the high word of ESP.
> >But if the bug is also affects Windows DOS box, it means that
> >V86 is affected too, no? 
> No. This URL is about dos4gw, so that's about a
> prot. mode either.

I see, I missed the 32 in mouse32.

> 
> >I'd like to know what OS/2 did.
> AFAIK also WinNT is not affected. Not sure though.
> 
> >The DOS boxes and 16 bit mode
> >DPMI applications ran very well and it was very stable, despite
> Hey. It is not about 16bit DPMI mode, it is
> about the 32bit DPMI mode. That's the whole
> problem. Be it only about the 16bit DPMI mode,
> the problem may not ever harm anything at all.
> But for 32bit mode that's quite a problem.

Well, I did not express myself correctly. OS/2 was probably the 
most frightening mix of 16 and 32 bit code ever produced, so 
they certainly had to work around the problem. There
were literally tons of "thunks" to interface both modes
and the LDT was set up in a way which made the translation
of addresses relatively easy:

  off32 = (seg16>>3) + off16

Therefore the base address of LDT segment n was n*64k,
limiting the addressable memory to 512MB in all versions
I used (later versions lifted this limit), but making
conversions of 16 to 32 bit addresses and back quite
efficient. However, I can't remember exactly how the 
thunks worked.

	Gabriel


	Gabriel

