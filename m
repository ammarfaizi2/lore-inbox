Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287896AbSABSvA>; Wed, 2 Jan 2002 13:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287897AbSABSuu>; Wed, 2 Jan 2002 13:50:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39178
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287896AbSABSud>; Wed, 2 Jan 2002 13:50:33 -0500
Date: Wed, 2 Jan 2002 10:48:00 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Flavio Stanchina <flavio.stanchina@tin.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.16.12102001.patch: please provide help for new config
 options
In-Reply-To: <20020102122032.MFVM3377.fep43-svc.tin.it@there>
Message-ID: <Pine.LNX.4.10.10201020926230.10050-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Flavio Stanchina wrote:

> Andre,
> I downloaded the ide.2.4.16.12102001.patch from linuxdiskcert.org and I 
> applied it to 2.4.17. Compiles fine, but now I'm looking for documentation 
> and there doesn't seem to be any on linuxdiskcert.org. Could you provide 
> us with basic help text for the following new configuration options?
> 
> CONFIG_IDEDISK_STROKE

Should you have a system w/ an AWARD Bios and your drives are larger than
32GB and it will not boot, one is required to perform a few OEM operations
first.  The option is called "STROKE" because it allows one to "soft clip"
the drive to work around a barrier limit.  For Maxtor drives it is called
"jumpon.exe".  Please search Maxtor's web-site for "JUMPON.EXE".  IBM has
an similar tool but I need to find a referrence.

Generally "N"

> CONFIG_IDE_TASK_IOCTL

This is a direct raw access to the media.  It is a complex but eligant
solution to test and validate the domain of the hardware and perform below
the driver data recover if needed.  This is the most basic form of
media-forensics..

Generally "N"

> CONFIG_IDE_TASKFILE_IO

This is the "Jewel" of the patch.  It will go away and become the new
driver core.  Since all the chipsets/host side hardware deal w/ their
exceptions in "their local code" currently, adpotion of a standardized
data-transport is the only logical solution.  Additionally we packetize
the requests and gain rapid performance and a reduction in system latency.
Additionally by using a memory struct for the commands we can redirect to
a MMIO host hardware in the next generation of controllers, specifically
second generation Ultra133 and Serial ATA.

Since this is a major transition, it was deemed necessary to make the
driver paths buildable in separtate models.  Therefore if using this
option fails for your arch then we need to address the needs for that
arch.

Generally "Y"

> CONFIG_BLK_DEV_IDEDMA_FORCED

This is an old piece of lost code from Linux 2.0 Kernels.

Generally "N"

> CONFIG_IDEDMA_ONLYDISK

This is used if you know your ATAPI Devices are going to fail DMA
Transfers.

Generally "N"

> Which ones are we supposed to enable for better performance, reliability, 
> etc. and which ones are for compatibility? I would guess 
> CONFIG_IDEDMA_ONLYDISK pertains to the latter category for example.

This option is used by Distros because of the listed problem above.


> Please CC me, I'm not on linux-kernel.
> 
> -- 
> Ciao,
>     Flavio Stanchina
>     Trento - Italy
> 
> "The best defense against logic is ignorance."
> http://spazioweb.inwind.it/fstanchina/
> 

Flavio,

If this does not explain it all please ask for more, thanks!

Respectfully,

Andre Hedrick
Linux ATA Development

