Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319587AbSIMJhV>; Fri, 13 Sep 2002 05:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319588AbSIMJhV>; Fri, 13 Sep 2002 05:37:21 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:61871 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S319587AbSIMJhU>;
	Fri, 13 Sep 2002 05:37:20 -0400
Date: Fri, 13 Sep 2002 11:41:49 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, vojtech@suse.cz,
       kernel@street-vision.com, linux-kernel@vger.kernel.org
Subject: Re: AMD 760MPX DMA lockup (partly solved)
Message-ID: <20020913114149.I29717@fi.muni.cz>
References: <20020912161258.A9056@fi.muni.cz> <200209121815.g8CIFdp06612@Port.imtp.ilyichevsk.odessa.ua> <20020912211452.C29717@fi.muni.cz> <1031863392.2902.113.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1031863392.2902.113.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Sep 12, 2002 at 09:43:12PM +0100
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
: On Thu, 2002-09-12 at 20:14, Jan Kasprzak wrote:
: > 	I the bug got merged from the -ac kernels, because it is
: > present bot in the kernel 2.4.19-11 from RedHat "null" beta
: > and in 2.4.20-pre2-ac1 (altough the later crashes instead of lock-up).
: 
: That would strange actually. The Red Hat beta kernel has 2.4.18 like IDE
: not -ac like IDE
: 
	Well, it is probably not IDE-related at all, but rather it has
something to do with PCI or may be scheduling changes that -pre2-ac2 does.
Currently I positively know that 2.4.20-pre2 works, but 2.4.20-ac2 and
2.4.20-pre5 does not. I have tested 2.4.20-pre2-ac1 and 2.4.20-pre[34],
but all these does not work for me probably for some other reason.

	So I have taken patch-2.4.20-pre2-ac2, and deleted all
changes except the ones that are IDE-related, and 2.4.20-pre2 plus the
following parts of -pre2-ac2 works:

 drivers/ide/Config.in      |   15 
 drivers/ide/Makefile       |    9 
 drivers/ide/amd74xx.c      |  292 +++---
 drivers/ide/hd.c           |   42 
 drivers/ide/ide-disk.c     |  879 +++++++++++-------
 drivers/ide/ide-dma.c      |  347 +++----
 drivers/ide/ide-features.c |  385 --------
 drivers/ide/ide-pci.c      |  539 +++++------
 drivers/ide/ide-probe.c    |  126 +-
 drivers/ide/ide-proc.c     |   58 -
 drivers/ide/ide-taskfile.c | 2159 +++++++++++++++++++++++++++++++++------------ drivers/ide/ide.c          |  651 +++----------
 drivers/ide/pdc202xx.c     | 1098 +++++++++++++---------
 drivers/ide/pdc4030.c      |  272 ++++-
 drivers/ide/pdcadma.c      |  106 ++
 include/asm-i386/ide.h     |   26 
 include/asm-i386/system.h  |   14 
 include/linux/hdreg.h      |   93 +
 include/linux/ide.h        |  409 +++++---
 include/linux/pci_ids.h    |   16 
 20 files changed, 4524 insertions, 3012 deletions

	I have to delete the first chunk of the patch of
include/asm-i386/ide.h, and I have deleted the call to
pci_enable_device_bars() in drivers/ide/ide-pci.c to be able to compile
this, but other than that it is exactly the same as 2.4.20-pre2-ac2 IDE code.
I will send you this as a patch against 2.4.20-pre2 if you want.

	This still works, so it means the problem has to be in some other
part of 2.4.20-pre2-ac2.

Vojtech Pavlik wrote:
: 
: X33? X33 doesn't make sense.
: 
	X34, sorry. DMA 33.

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
