Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSI2If2>; Sun, 29 Sep 2002 04:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSI2If2>; Sun, 29 Sep 2002 04:35:28 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:32238 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262418AbSI2If1>; Sun, 29 Sep 2002 04:35:27 -0400
Date: Sun, 29 Sep 2002 10:38:08 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Toon van der Pas <toon@vanvergehaald.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020929103807.A1250@brodo.de>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de> <20020929000332.A16506@vdpas.hobby.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020929000332.A16506@vdpas.hobby.nl>; from toon@vanvergehaald.nl on Sun, Sep 29, 2002 at 12:03:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 12:03:32AM +0200, Toon van der Pas wrote:
> On Sat, Sep 28, 2002 at 01:44:57PM +0200, Dominik Brodowski wrote:
> > 
> > This add-on patch is needed to abort on Dell Inspiron 8000 / 8100
> > which would lock up during speedstep.c and to resolve an oops
> > (thanks to Hu Gang for reporting this)
> > 
> > 	Dominik
> 
> Wait a minute...
> Do I understand you and your patch right?
> Dell sells a machine with a Pentium III Mobile CPU with Speedstep
> technology, and now you tell us that it won't work?  Ever?
> Does this mean that a lot of people (including me) bought a very
> advanced and expensive piece of trash?  Then it's about time that
> I contact Dell, because they screwed me.
I've been contacted by two Dell Inspiron 8100 users who reported deadlocks
when using any cpufreq version on their systems. The reason is that Dell
doesn't use the (documented) interface in the ICH2-M southbridge, but
(proabably) the ISSCL (Intel SpeedStep Control Logic)-Interface also used on
440?X chipsets. Unfortunately, this interface is not documented - Intel
even _removes_ parts of documentation avaialable to the public that could 
lead to reverse-engineering of the ISSCL-Interface (440 MX Platform Design
Guide). So, a "legacy" speedstep driver for 440?X chipsets or Dell Inspiron 
8000/8100s is unlikely, at least for the moment.

However, you might have another chance: by using ACPI. The latest ACPI
releases for 2.4. as well as the 2.5. tree offers "P-State" support. So if
your BIOS' ACPI-tables make these P-States available, you _can_ use
speedstep on this notebook. For details on ACPI P-States, please take a look
at http://www.brodo.de/english/pub/acpi/proc/processor.html

> Does Speedstep work on this machine with Windows/XP?
> (I never checked, removed it first thing after unpacking the machine.)
AFAICT, it does work on the 8100  but not on the 8000.

BTW, just to set things clear: The only computer I own only uses the 440?X /
ISSCL-Interface, so I sit in the same boat as you. By developing the
ICH2-M/ICH3-M driver I had hoped to find ways to reverse-engineer the "old"
speedstep interface; so far I have been unsuccessful, though.

	Dominik
