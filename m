Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311723AbSCTQAY>; Wed, 20 Mar 2002 11:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311721AbSCTQAF>; Wed, 20 Mar 2002 11:00:05 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:35530 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S311718AbSCTP77>;
	Wed, 20 Mar 2002 10:59:59 -0500
Date: Thu, 21 Mar 2002 02:59:53 +1100
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 VIA MWQ patch (Athlon stomper) corrupts video with KT133/KM133
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Message-Id: <1016639993.025783.8294.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The VIA MWQ patch[1] that went into 2.4.18 seems to play havoc
with my video card, a ProSavage KM133.  I get a bunch of vertical
lines in text mode, and that's it; the text display is completely
corrupted.  If I use a VESA framebuffer, I get an effect similar
to the old CGA 'snow' whenever I see the hard disk being
accessed: random streaks appear across the screen.

If I clear only bit 7 of register 55 on my chipset to fix the
Athlon stomper bug (which is what the kernels before 2.4.18 did),
I seem to have no problems at all.  2.4.18 clears bits 5, 6 and 7
of register 55.  Does anybody have any idea what bits 5 and 6 do?
Does anybody know what the Windows VIA patches do for particular
motherboard (Asus A7VC)?

Perhaps we should revert this patch if systems are stable without
clearing bits 5/6.

    2:50(0) chiba:~% lspci
    00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
    00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
    00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
    00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
    00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
    00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
    00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
    00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
    00:0d.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)
    00:0e.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
    00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
    01:00.0 VGA compatible controller: S3 Inc. ProSavage KM133 (rev 03)

    2:50(0) chiba:~% lspci -n
    00:00.0 Class 0600: 1106:0305 (rev 81)
    00:01.0 Class 0604: 1106:8305
    00:07.0 Class 0601: 1106:0686 (rev 40)
    00:07.1 Class 0101: 1106:0571 (rev 06)
    00:07.2 Class 0c03: 1106:3038 (rev 1a)
    00:07.3 Class 0c03: 1106:3038 (rev 1a)
    00:07.4 Class 0680: 1106:3057 (rev 40)
    00:07.5 Class 0401: 1106:3058 (rev 50)
    00:0d.0 Class 0400: 109e:0350 (rev 12)
    00:0e.0 Class 0200: 8086:1229 (rev 0c)
    00:12.0 Class 0200: 10ec:8139 (rev 10)
    01:00.0 Class 0300: 5333:8a26 (rev 03)

1. http://marc.theaimsgroup.com/?l=linux-kernel&m=100772126208656&w=2


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
