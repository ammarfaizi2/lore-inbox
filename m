Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290319AbSAXVZV>; Thu, 24 Jan 2002 16:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290315AbSAXVZN>; Thu, 24 Jan 2002 16:25:13 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:34284 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S290307AbSAXVZB>; Thu, 24 Jan 2002 16:25:01 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Rasmus =?iso-8859-15?q?B=F8g=20Hansen?= <moffe@amagerkollegiet.dk>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a chipset)
Date: Thu, 24 Jan 2002 22:15:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Andrew Grover <andrew.grover@intel.com>
In-Reply-To: <Pine.LNX.4.44.0201241803540.1345-100000@grignard.amagerkollegiet.dk>
In-Reply-To: <Pine.LNX.4.44.0201241803540.1345-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020124212507Z290307-13996+11382@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 18:22, Rasmus Bøg Hansen wrote:
> Hello Dieter
>
> > Hello Rasmus,
> >
> > I hope that I've extracted your name right?
>
> Yup, just a danish letter in my middle-name :-)

You see, my KDE-2.2.2 (iso-8859-15, Europe) kann handle it easily...;-)

> > > However, after disabling APM and enabling ACPI, my system won't power
> > > off anymore :-(
> >
> > This should be easily solved.
> >
> > I point on your distro's startup scripts. They only look if apm is
> > enabled but _NOT ACPI...
>
> Well, RedHat 7.2 does not look if apm or acpi is configured, it just
> uses -p unless the command run was 'halt' or 'reboot'.

OK.

> When running '/sbin/poweroff' from single-user, 'halt -i -d p' is the
> last command run by the halt script. The I get the message 'Power down.'
> from the kernel and my system just hangs here.

What if you do it by hand?

> When running /sbin/poweroff from runlevel 3 or 5, 'halt -i -d -p' is
> again the last command run, follwing this from the kernel:
>
> Power down.
>  hwsleep-0178 [02] Acpi_enable_sleep_state: Entering S5

Maybe this is an indication of broken BIOS.
You should grep for the ACPI diagnosis tools and send your results to the 
acpi-devel list.

> And again my system hangs. Pressing the power button for 4 seconds turns
> off the computer (the BIOS is set to 'immediate power off').

What? This is contradictorily.

> In runlevel 3, the following modules are loaded (some are patched in
> from the iptables package. They should not cause this, as I can
> reproduce this without iptables configured/patched at all):

Should all be unrelated.

>
> From my 'make menuconfig:
>
> [*] Power Management support
> [*]   ACPI support
> [*]     ACPI Debug Statements
> <*>     ACPI Bus Manager
> <*>       System
> <*>       Processor
> < >       Button
> < >       AC Adapter
> < >       Embedded Controller
> < >   Advanced Power Management BIOS support

I have Button enabled, too. Please try.

My .config file looks like this:

CONFIG_ACPI=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_EC is not set
# CONFIG_APM is not set


> At bootup I get the following regarding ACPI:

Can you send the fist lines from your boot log?
Maybe you should CC to acpi-devel.

>
>  tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully
> loaded
> Parsing
> Methods:...................................................................
>................................................ 115 Control Methods found
> and parsed (364 nodes total)
> ACPI Namespace successfully loaded at root c0286ee0
> ACPI: Core Subsystem version [20011018]
> evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode
> successful
> Executing device _INI methods:.......................................
> 39 Devices found: 39 _STA, 0 _INI
> Completing Region and Field initialization:...................
> 17/24 Regions, 2/2 Fields initialized (364 nodes total)
> ACPI: Subsystem enabled
> ACPI: System firmware supports S0 S1 S4 S5
> Processor[0]: C0 C1 C2, 8 throttling states

Here is something missing. Ah, the power button thing.

>
> My motherboard is an Asus A7V133-C. Output from lspci -v:

> 00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
> 40) Subsystem: Asustek Computer, Inc.: Unknown device 8042
> 	Flags: medium devsel, IRQ 9
> 	Capabilities: <available only to root>

Unknown device 8042

Maybe here is something missing, too.

The ACPI people should lighten this. --- Andrew?

> I have very little knowledge of ACPI,

I am, too...;-)

But hey, we have OSS and Andrew and his team. They did very good work!

> ut I'll be happy to help

Every "new" ACPI chip need support.

> (if this is not my fault of course - then I will apologize for taking your
> time

Never mind.

Regards,
	Dieter
