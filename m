Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWCaXg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWCaXg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCaXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:36:28 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:45810 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751146AbWCaXg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:36:28 -0500
Date: Fri, 31 Mar 2006 18:36:26 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.16.1 (1) vs ieee1394 (0)  HELP! (I told the missus I could do this)
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Reply-to: gene.heskett@verizononline.net
Message-id: <200603311836.26478.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

I sent this once, but it hasn't come back in about 20 minutes, sorry if 
it hits twice.

I may have found a gotcha in the 2.6.16.1 and NDI how far back it goes 
because I haven't used anything ieee1394 in months.

Anyway, I plugged in my camera, a Sony DCR-TVR460 and fired up kino, 
fully expecting to see the viewfinders image on screen as soon as I 
switched kino to the capture screen.

Unforch, its blank and kino is locked up, needing kde's emergency kill 
the process to kill it when I click on the closing x.

>From the logs, I get this is 4 or 5 lines.

Mar 31 17:30:16 coyote ieee1394.agent[8925]: ... no drivers for IEEE1394 
product 0x/0x/0x
Mar 31 17:30:16 coyote ieee1394.agent[8921]: ... no drivers for IEEE1394 
product 0x/0x/0x
Mar 31 17:30:16 coyote kernel: ieee1394: raw1394: /dev/raw1394 device 
initialized

And about 6 or 7 lines of gconf verbosy later, this:

Mar 31 17:31:28 coyote kernel: ohci1394: fw-host0: Waking dma ctx=0 ... 
processing is probably too slow

then:

[root@coyote linux-2.6.16.1]# lsmod |grep 1394
raw1394                24172  0
dv1394                 16716  0
ohci1394               27824  1 dv1394
ieee1394               82488  3 raw1394,dv1394,ohci1394

And:

[root@coyote linux-2.6.16.1]# 
ls /lib/modules/2.6.16.1/kernel/drivers/ieee1394
dv1394.ko  ieee1394.ko  ohci1394.ko  raw1394.ko  sbp2.ko  video1394.ko

sbp2.ko isn't needed, its for a webcam thats a POS.  I should quit 
building it altogether.

modprobe video1394 inserts that module, but makes zilch difference.
kino still freezes the instant the capture button is clicked.

Unplugging the firewire cable from the camera is silent in messages, but 
dmesg says:
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[08004601044684e4]
ieee1394: Node resumed: ID:BUS[0-00:1023]  GUID[08004601044684e4]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[08004601044684e4]
ieee1394: Node resumed: ID:BUS[0-00:1023]  GUID[08004601044684e4]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023

Then from:
[root@coyote boot]# lspci -vv |grep -A10 01:09
01:09.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at ec004000 (32-bit, non-prefetchable)
        Region 1: Memory at ec000000 (32-bit, non-prefetchable) 
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

And I'm not smart enough for anything there to raise a flag.

So obviously something's gone aglay, but what?

The last time I ran this config to do some movie editing of a wedding, 
along about June of last year, it all Just Worked. And I recently did 
some much needed housekeeping, such that if I wanted to build a 2.6.14 
kernel, I'd have to go get the tarball & start from scratch.

Ideas anybody?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.

