Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264809AbSJ3THH>; Wed, 30 Oct 2002 14:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264807AbSJ3THH>; Wed, 30 Oct 2002 14:07:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:21635 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264809AbSJ3THC>; Wed, 30 Oct 2002 14:07:02 -0500
Subject: Re: post-halloween 0.2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021030171149.GA15007@suse.de>
References: <20021030171149.GA15007@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 19:33:01 +0000
Message-Id: <1036006381.5297.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 17:11, Dave Jones wrote:

> Regressions:
> ~~~~~~~~~~~~
> (Things not expected to work just yet)
> - The hptraid/promise RAID drivers are currently non functional.
[These hopefully can be converted to use device mapper..]

> - Various SCSI drivers still need work, and don't even compile.

Many older network drivers ditto
Much of the ISDN layer ditto

> - software suspend is still in development, and in need of more work.
>   It is unlikely to work as expected currently.
> - Some filesystems still need work (Coda, Intermezzo).
		UFS, HFS HPFS,...

Add "Most older SCSI controllers are *NOT* doing error handling. Be
careful."
Add "Simplex IDE devices (eg Ali15x3) are missing DMA sometimes"
Add "Serverworks OSB4 may panic on bad blocks or other non fatal errors"
Add "PCMCIA IDE hangs on eject"
Add "Most PCMCIA devices have unload races and may oops on eject"
Add "Modular IDE does not yet work, modular IDE PCI modules sometimes
oops on loading"


>> Deprecated features:
> ~~~~~~~~~~~~~~~~~~~~
> - khttpd is gone.
> - Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
>   has been removed. Upgrade to XFree86 4.1.0 or higher.

LVM1 is no longer supported, upgrade to LVM2. This supports the LVM1
disk format.

 
> PnP layer
> ~~~~~~~~~
> Support for plug and play devices such as early ISAPNP cards has
> improved a lot in the 2.5 kernel. You should no longer need to
> futz with userspace tools to configure IRQ's and the likes.
> Report any regressions in plug & play functionality to
> Adam Belay <ambx1@neo.rr.com>

Right at the moment the executive summary would be "ISAPnP doesnt work
any more but the new interfaces will mean it works a lot better soon (I
hope)"

 
> ALSA
> ~~~~
> The advanced linux sound architecture got merged into 2.5.
> This offers considerably improved functionality over the
> older OSS drivers, but requires new userspace tools.
> Several distros have shipped ALSA for some time, so you
> may already have the necessary tools. If not, you can find them
> at http://www.alsa-project.org/
> (Note that the OSS drivers are also still functional, and
>  still present)

Kind of work in some cases, they are deprecated and may vanish before
2.6 or may vanish the release after.

> IDE
> ~~~
> The IDE code was subject to much criticism in early 2.5.x, which
> put off a lot of people from testing. This work was then subsequently
> dropped, and reverted back to a 2.4.18 IDE status.
> (Since then additional work has occured, but not to the extent
>  of the first cleanup attempts).
> Additional work on the ATA code is happening in 2.4-ac, and pending
> merging to 2.5

Actually its happening in 2.5 back merging to 2.4-ac now.

> IDE TCQ
> ~~~~~~~
> Tagged command queueing for IDE devices has been included.
> Not all devices may like this, so handle with care.
> If you didn't choose the "TCQ on by default" option,
> you can enable it by using the command
> 
> echo "using_tcq:32" > /proc/ide/hdX/settings
> (replacing 32 with 0 disables TCQ again).
> Report success/failure stories to Jens Axboe <axboe@suse.de> with
> inclusion of hdparm -i /dev/hdX

** Don't use IDE TCQ on any data you value.


> x86 CPU detection.
> ~~~~~~~~~~~~~~~~~~
> The CPU detection code got a pretty hefty shake up. To be certain your
> CPU has all relevant workarounds applied, be sure to check that it was
> detected correctly. cat /proc/cpuinfo will tell what the kernel thinks it is.
> Likewise, the x86 MTRR driver got a considerable makeover.
> Any regressions in both should go to mochel@osdl.org

Early PII Xeon processors and possibly other early PII processors
require microcode updates either from the BIOS or the microcode driver
to handle O(1) scheduler reliably

Can you also mention not using gcc 3.0.x (stack pointer handling bug)

