Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270065AbTHGTXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270316AbTHGTXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:23:12 -0400
Received: from codepoet.org ([166.70.99.138]:43160 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270065AbTHGTXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:23:03 -0400
Date: Thu, 7 Aug 2003 13:23:01 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mitch@0Bits.COM,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hch@lst.de
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Message-ID: <20030807192301.GA9494@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Mitch@0Bits.COM,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hch@lst.de
References: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 07, 2003 at 10:27:03AM -0300, Marcelo Tosatti wrote:
> > That doesn't seem a 2.4.22 candidate thing to me. If vmap broke the DRI
> > then the vmap patch wants reverting for 2.4.22 IMHO, and looking at for
> > 2.4.23.
> 
> I dont understand how the vmap change can break DRM. 
> 
> The vmap patch only changes internal mm/vmalloc.c code (vmalloc() call
> acts exactly the same way as before AFAICS).
> 
> Anyway, Mitch (or Erik who's seeing the problem), can please revert the
> vmap() change to check if its causing the mentioned problem? 
> 
> The patch is attached. Apply it with -R.

Reverting this patch has no effect on the problem....

    $ glxgears 
    Illegal instruction

same as before,

As a guess, the "Unknown" in the drm detection below could
be related to my problem....  As could the fact I have 2 GB
ram installed.  Or the fact I'm running SMP.  dunno.


Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: Detected Intel(R) 865G chipset
agpgart: AGP aperture is 64M @ 0xf8000000
[----------snip-----------]
[drm] AGP 0.99 on Unknown @ 0xf8000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0



00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe800000-fe8fffff
        Prefetchable memory behind bridge: e7e00000-f7dfffff

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: PC Partner Limited RV100 QY [Sapphire Radeon VE 7000]
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 16
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at c000 [size=256]
        Memory at fe8f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe8c0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2


 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
