Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbSI2PfR>; Sun, 29 Sep 2002 11:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262666AbSI2PfR>; Sun, 29 Sep 2002 11:35:17 -0400
Received: from meel.hobby.nl ([212.72.224.15]:17928 "EHLO meel.hobby.nl")
	by vger.kernel.org with ESMTP id <S262665AbSI2PfP>;
	Sun, 29 Sep 2002 11:35:15 -0400
Date: Sun, 29 Sep 2002 16:44:34 +0200
From: Toon van der Pas <toon@vanvergehaald.nl>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020929164434.A5618@vdpas.hobby.nl>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de> <20020929000332.A16506@vdpas.hobby.nl> <20020929103807.A1250@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929103807.A1250@brodo.de>; from linux@brodo.de on Sun, Sep 29, 2002 at 10:38:08AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 10:38:08AM +0200, Dominik Brodowski wrote:
> On Sun, Sep 29, 2002 at 12:03:32AM +0200, Toon van der Pas wrote:
> > On Sat, Sep 28, 2002 at 01:44:57PM +0200, Dominik Brodowski wrote:
> > > 
> > > This add-on patch is needed to abort on Dell Inspiron 8000 / 8100
> > > which would lock up during speedstep.c and to resolve an oops
> > > (thanks to Hu Gang for reporting this)
> > 
> > Wait a minute...
> > Do I understand you and your patch right?
> > Dell sells a machine with a Pentium III Mobile CPU with Speedstep
> > technology, and now you tell us that it won't work?  Ever?
> > Does this mean that a lot of people (including me) bought a very
> > advanced and expensive piece of trash?  Then it's about time that
> > I contact Dell, because they screwed me.
> 
> I've been contacted by two Dell Inspiron 8100 users who reported deadlocks
> when using any cpufreq version on their systems. The reason is that Dell
> doesn't use the (documented) interface in the ICH2-M southbridge, but
> (proabably) the ISSCL (Intel SpeedStep Control Logic)-Interface also used on
> 440?X chipsets. Unfortunately, this interface is not documented - Intel
> even _removes_ parts of documentation avaialable to the public that could 
> lead to reverse-engineering of the ISSCL-Interface (440 MX Platform Design
> Guide). So, a "legacy" speedstep driver for 440?X chipsets or Dell Inspiron 
> 8000/8100s is unlikely, at least for the moment.
> 
> However, you might have another chance: by using ACPI. The latest ACPI
> releases for 2.4. as well as the 2.5. tree offers "P-State" support. So if
> your BIOS' ACPI-tables make these P-States available, you _can_ use
> speedstep on this notebook. For details on ACPI P-States, please take a look
> at http://www.brodo.de/english/pub/acpi/proc/processor.html

First of all, thanks for your elaborate reply.
It cleared up a lot of things for me.

According to your patch the first accaptable version is 5 while the version
of thehost bridge op my Inspiron 8100 appears to be 4, so I'm definitely hit
by INTEL's saddening policy.  :-(

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [88] #09 [e104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

But my current home-baked 2.4.18 kernel with a fairly old acpi-version
already appears to support the acpi P-state support you mention.
It seems to work. No throttling support though. I'm less than
thrilled by the power management support of this laptop and
the SpeedStep policy of INTEL. (yes, it's more of a (marketing) policy
than a technology, in my opinion)

[toon@roach toon]$ uname -a
Linux roach.hobby.nl 2.4.18-rc4-rmap12h-acpi20020503-pciirq.17.acpi #2 do mei 9 21:21:22 GMT+1 2002 i686 unknown
[root@roach toon]# cat /proc/acpi/processor/CPU0/performance 
state count:             2
active state:            P0
states:
   *P0:                  1000 Mhz, 15800 mW, 500 uS
    P1:                  733 Mhz, 12500 mW, 500 uS

Regards,
Toon.
-- 
 /"\                             |
 \ /     ASCII RIBBON CAMPAIGN   |  "Who is this General Failure, and
  X        AGAINST HTML MAIL     |   what is he doing on my harddisk?"
 / \
