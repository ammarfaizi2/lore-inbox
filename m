Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSCWBWj>; Fri, 22 Mar 2002 20:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSCWBPX>; Fri, 22 Mar 2002 20:15:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S293071AbSCWBPH>;
	Fri, 22 Mar 2002 20:15:07 -0500
Date: Fri, 22 Mar 2002 17:23:04 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-ID: <20020322232304.GA19579@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Danijel Schiavuzzi <dschiavu@public.srce.hr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <200203211209.NAA11121@jagor.srce.hr> <20020321172234.GA21274@hapablap.dyn.dhs.org> <200203222204.XAA01121@jagor.srce.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 17:13:34 up 1 day, 16:10,  1 user,  load average: 0.58, 0.91, 0.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 08:49:02PM +0100, Danijel Schiavuzzi wrote:
> In 2.4.18, unmodified (with 0x1f value), it shows:
> 	Disabling VIA memory write queue: [55] 38->18
> 
> In 2.4.18, modified (changed 0x1f to 0x7f), it shows:
> 	 Disabling VIA memory write queue: [55] 38->38
> 
> The modified kernel runs *fine*.

Aha.  Excellent.

> lspci tells:
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
                                              ^^^^^^
I think you actually do have an 8363, and so some sort of fix is
probably needed.

> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
> 40)
> /cut/
> 
> But in fact mine is a *VT8365* (KM133) Northbridge.
> 
> from pci-pc.c:
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      
> PCI_DEVICE_ID_VIA_8363_0,       pci_fixup_via_northbridge_bug },
> 		^^^^^^^^
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      
> PCI_DEVICE_ID_VIA_8622,         pci_fixup_via_northbridge_bug },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      
> PCI_DEVICE_ID_VIA_8361,         pci_fixup_via_northbridge_bug },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      
> PCI_DEVICE_ID_VIA_8367_0,       pci_fixup_via_northbridge_bug },
>         { 0 }
> 
> Maybe because of this, the kernel thinks mine is a 8363, and applies the fix, 
> but in fact it doesn't need to be applied, or does it? I'm confused %:I

I think your system does need the fix, but only bit 7 needs clearing.
Not all of it.  If memory serves me, clearing bit 7 was the
experimentally-determined fix for the bug, however, VIA said that all 3
bit needed clearing.  Perhaps this should be looked into, as I
experienced the same screen corruption bug on the same chipset.  I have
yet to try my own proposed fix on it, however :-/

I'll do this within the next week or so, and if it works for me, I'll
propose a patch to only clear bit 7, at least on these chips.  Sound
good to you?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
