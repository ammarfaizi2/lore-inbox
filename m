Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbTJGU4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTJGU4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:56:35 -0400
Received: from fmr03.intel.com ([143.183.121.5]:47754 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262870AbTJGU4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:56:30 -0400
Subject: Re: vaio doesn't poweroff with 2.4.22 (fwd)
From: Len Brown <len.brown@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dimitri Torfs <dimitri@sonycom.com>, acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0310022254280.8802-400000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0310022254280.8802-400000@vervain.sonytel.be>
Content-Type: text/plain
Organization: 
Message-Id: <1065560111.3366.33.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Oct 2003 16:55:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-07 at 05:18, Geert Uytterhoeven wrote:
> 	Hi Len, Marcelo,
> 
> On 2 Oct 2003, Len Brown wrote:
> > Is this still a problem w/ the latest build?
> 
> Yes (see below).
> 
> > Is there a bugzilla entry for it?
> 
> No.
> 
> Attached you can find my .config, and dmesg output, without and with
> acpi=force.
> 
> Without acpi=force:
> 
>   - `halt' doesn't halt (still running)
> 
>   - `reboot' doesn't work, and pseudo-halts the machine (black screen, but
>     power LED still lit)
> 

The dmesg you attached says this:

< ACPI disabled because your bios is from 00 and too old
< You can enable it with acpi=force
...
< ACPI: Interpreter disabled.

So I'd expect the CONFIG_ACPI !CONFIG_APM kernel to fail to poweroff the
system.

> With acpi=force,
> 
>   - `halt' works fine
> 
>   - `reboot' doesn't work, and pseudo-halts the machine (black screen, but
>     power LED still lit)
> In 2.4.21, both `halt' and `reboot' work fine.

Did you configure with ACPI in 2.4.21?
If you configured with APM in 2.4.21, you might consider sticking with
it rather than switching to ACPI in 2.4.22.

Also, if there is a BIOS update available for this system you should
consider it.

thanks,
-Len





> > ---------- Forwarded message ----------
> > Date: Mon, 15 Sep 2003 08:43:56 +0200 (MEST)
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > To: acpi-devel@lists.sourceforge.net
> > Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
> > Subject: Vaio doesn't poweroff with 2.4.22
> > 
> >         Hi,
> > 
> > With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a
> > regression
> > w.r.t. power management:
> >   - It doesn't poweroff anymore (screen contents are still there after
> > the
> >     powering down message)
> >   - It doesn't reboot anymore (screen goes black, though)
> >   - It accidentally suspended to RAM once while I was actively working
> > on it (I
> >     never managed to get suspend working, except for this `accident'). I
> > didn't
> >     see any messages about this in the kernel log.
> > 
> > Relevant config options for 2.4.22:
> > | tux$ grep acpi .config
> > | # ACPI Support
> > | CONFIG_ACPI=y
> > | # CONFIG_ACPI_HT_ONLY is not set
> > | CONFIG_ACPI_BOOT=y
> > | CONFIG_ACPI_BUS=y
> > | CONFIG_ACPI_INTERPRETER=y
> > | CONFIG_ACPI_EC=y
> > | CONFIG_ACPI_POWER=y
> > | CONFIG_ACPI_PCI=y
> > | CONFIG_ACPI_SLEEP=y
> > | CONFIG_ACPI_SYSTEM=y
> > | CONFIG_ACPI_AC=y
> > | CONFIG_ACPI_BATTERY=y
> > | CONFIG_ACPI_BUTTON=y
> > | CONFIG_ACPI_FAN=y
> > | CONFIG_ACPI_PROCESSOR=y
> > | CONFIG_ACPI_THERMAL=y
> > | # CONFIG_ACPI_ASUS is not set
> > | # CONFIG_ACPI_TOSHIBA is not set
> > | CONFIG_ACPI_DEBUG=y
> > | # CONFIG_ACPI_RELAXED_AML is not set
> > | tux$ 
> > 
> > Relevant config options for 2.4.21, which does poweroff/reboot without
> > problems:
> > | tux$ grep acpi .config
> > | # CONFIG_HOTPLUG_PCI_ACPI is not set
> > | CONFIG_ACPI=y
> > | CONFIG_ACPI_DEBUG=y
> > | CONFIG_ACPI_BUSMGR=y
> > | CONFIG_ACPI_SYS=y
> > | CONFIG_ACPI_CPU=y
> > | CONFIG_ACPI_BUTTON=y
> > | CONFIG_ACPI_AC=y
> > | CONFIG_ACPI_EC=y
> > | CONFIG_ACPI_CMBATT=y
> > | CONFIG_ACPI_THERMAL=y
> > | tux$ 
> > 
> > If you need more information or want me to ttry something, please ask!
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

