Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270321AbTHLMlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270322AbTHLMlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:41:01 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:32195 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S270321AbTHLMk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:40:58 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Martin Schlemmer <azarah@gentoo.org>
Subject: Re: 2.6.0-test3+sk98lin driver with hardware bug make eth unusable
Date: Tue, 12 Aug 2003 14:40:50 +0200
User-Agent: KMail/1.5.3
Cc: Mirko Lindner <mlindner@syskonnect.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <200308121301.43873.gallir@uib.es> <1060689676.13254.172.camel@workshop.saharacpt.lan>
In-Reply-To: <1060689676.13254.172.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121440.50395.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 14:01, Martin Schlemmer shaped the electrons to 
shout:
> On Tue, 2003-08-12 at 13:01, Ricardo Galli wrote:
> > I've already reported this problem to syskonnect few weeks ago (without
> > success as I see).
> >
> > There is a ASIC bug in several popular motherboards (including ASUS ones)
> > related to TX hardware checksum.
> >
> > For packets smaller that 56 bytes (payload), as UDP dns queries, the asic
> > generates a bad checksum making the drivers unusable for "normal"
> > Internet usage:
>
> <snip>
>
> > The only solution is to comment out
> >  #define USE_SK_TX_CHECKSUM
> > in skge.c
>
> Known issue.
>
> Mirko will have a look as soon as he have time.

Thanks, I just sent a Kconfig patch as a workaround:

http://lkml.org/lkml/2003/8/12/83

BTW, I'm testing it in a ASUS P4800 Deluxe motherboard, which has the asic 
bug:

gallir@antoli:~$ lspci
00:00.0 Host bridge: Intel Corp.: Unknown device 2578 (rev 02)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2579 (rev 02)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02)
00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02)
00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02)
00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24d5 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200] 
(rev a3)
02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller 
(rev 80)
02:05.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev 12)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
02:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
02:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
07)
02:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
78)


Cheers,

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/
