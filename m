Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264906AbUE0Roy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbUE0Roy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUE0Rox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:44:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8847 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264906AbUE0Rnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:43:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: George Georgalis <george@galis.org>
Subject: Re: 2.6.6 problem, cd and hd on second ide channel
Date: Thu, 27 May 2004 19:45:38 +0200
User-Agent: KMail/1.5.3
References: <20040527171325.GA13890@trot.local>
In-Reply-To: <20040527171325.GA13890@trot.local>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405271945.38976.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is ACPI bug in 2.6.6 related to IRQ routing.  Try 2.6.7-rc1.

http://bugme.osdl.org/show_bug.cgi?id=2665

On Thursday 27 of May 2004 19:13, George Georgalis wrote:
> I'm experiencing a problem booting 2.6.6 on a via c3 motherboard.
> A very similar .config works fine with 2.6.5, I've attached a
> diff of a working 2.6.5 .config and a broken .2.6.6 .config; along
> with the full (non working) 2.6.6 config.
>
> Under 2.6.6, when only the cdrom is connected on the second channel
> (/dev/hdd) boot seems normal, until a delay after "ATAPI reset", then
> boot continues normally.
>
> When /dev/hdc is connected, "lost interrupt" errors prevent 2.6.6 from
> booting, but 2.6.5 has no problem.
>
> I've tried toggling the ide interrupt sharing option, doesn't seem to
> have effect on the problem. Below is hdparm output, hdc is identical to
> hda.
>
>
> # hdparm -i /dev/hdd
>
> /dev/hdd:
>
>  Model=SONY DVD RW DW-U14A, FwRev=1.0d, SerialNo=FA674550
>  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2
>  AdvancedPM=no
>  Drive conforms to: device does not report version:
>
>
>
> # hdparm -i /dev/hda
>
> /dev/hda:
>
>  Model=Maxtor 6E040L0, FwRev=NAR61EA0, SerialNo=E1PJRQ0E
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80293248
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>  AdvancedPM=yes: disabled (255) WriteCache=enabled
>  Drive conforms to: :
>
> # uname -a
> Linux kw-rox.dynalias.net 2.6.6-c3 #2 Thu May 27 11:45:39 EDT 2004 i686
> unknown
>
> Output of lspci is also attached.
>
> Happy to provide more specific details, for the asking.  Any ideas of
> what's going on here, or a fix?
>
> Thanks,
> // George

