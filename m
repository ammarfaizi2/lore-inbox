Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311937AbSCTSpi>; Wed, 20 Mar 2002 13:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311942AbSCTSpS>; Wed, 20 Mar 2002 13:45:18 -0500
Received: from ohiper1-94.apex.net ([209.250.47.109]:37125 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S311937AbSCTSpI>; Wed, 20 Mar 2002 13:45:08 -0500
Date: Wed, 20 Mar 2002 12:45:05 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Andre Pang <ozone@algorithm.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 VIA MWQ patch (Athlon stomper) corrupts video with KT133/KM133
Message-ID: <20020320184505.GB14024@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Andre Pang <ozone@algorithm.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <1016639993.025783.8294.nullmailer@bozar.algorithm.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 11:02:44 up 12 min,  0 users,  load average: 0.04, 0.12, 0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this problem, as well.  The fix for me was simply not to perform
the fixup at all.  I'm not sure if clearing only bit 7 fixes the problem
on my machine, but would grudgingly try it, if wanted.  (I don't have
particularly ready access to the machine.)

On Thu, Mar 21, 2002 at 02:59:53AM +1100, Andre Pang wrote:
> Hi,
> 
> The VIA MWQ patch[1] that went into 2.4.18 seems to play havoc
> with my video card, a ProSavage KM133.  I get a bunch of vertical
> lines in text mode, and that's it; the text display is completely
> corrupted.  If I use a VESA framebuffer, I get an effect similar
> to the old CGA 'snow' whenever I see the hard disk being
> accessed: random streaks appear across the screen.
> 
> If I clear only bit 7 of register 55 on my chipset to fix the
> Athlon stomper bug (which is what the kernels before 2.4.18 did),
> I seem to have no problems at all.  2.4.18 clears bits 5, 6 and 7
> of register 55.  Does anybody have any idea what bits 5 and 6 do?
> Does anybody know what the Windows VIA patches do for particular
> motherboard (Asus A7VC)?
> 
> Perhaps we should revert this patch if systems are stable without
> clearing bits 5/6.
> 
>     2:50(0) chiba:~% lspci
>     00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
>     00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
>     00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
>     00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
>     00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
>     00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
>     00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
>     00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
>     00:0d.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)
>     00:0e.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
>     00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
>     01:00.0 VGA compatible controller: S3 Inc. ProSavage KM133 (rev 03)
> 
>     2:50(0) chiba:~% lspci -n
>     00:00.0 Class 0600: 1106:0305 (rev 81)
>     00:01.0 Class 0604: 1106:8305
>     00:07.0 Class 0601: 1106:0686 (rev 40)
>     00:07.1 Class 0101: 1106:0571 (rev 06)
>     00:07.2 Class 0c03: 1106:3038 (rev 1a)
>     00:07.3 Class 0c03: 1106:3038 (rev 1a)
>     00:07.4 Class 0680: 1106:3057 (rev 40)
>     00:07.5 Class 0401: 1106:3058 (rev 50)
>     00:0d.0 Class 0400: 109e:0350 (rev 12)
>     00:0e.0 Class 0200: 8086:1229 (rev 0c)
>     00:12.0 Class 0200: 10ec:8139 (rev 10)
>     01:00.0 Class 0300: 5333:8a26 (rev 03)
> 
> 1. http://marc.theaimsgroup.com/?l=linux-kernel&m=100772126208656&w=2
> 
> 
> -- 
> #ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
