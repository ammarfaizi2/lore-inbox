Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293566AbSBZLDq>; Tue, 26 Feb 2002 06:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293574AbSBZLDg>; Tue, 26 Feb 2002 06:03:36 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57607
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293566AbSBZLDX>; Tue, 26 Feb 2002 06:03:23 -0500
Date: Tue, 26 Feb 2002 02:50:33 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Ken Brownfield <brownfld@irridia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
In-Reply-To: <20020226042714.C930@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.10.10202260244170.14807-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the skinny.

Running DOMAIN VALIDATION against the HOST just totally throttles the
silicon-dma-core.  Basically direct access force the hardware to protect
itself from pushing the limits of the access, it BLOWS CHUNKS like a
freshman in college on his/her first drunk.

If you run the it top down via block, the mainloop eases alot of the
pressure.  The punch line is like this .........

DV(BLOWS CHUNKS) == Block_pressure(BLOWS CHUNKS)

If DV fails, you have not got a prayer of believing the physical is
stable, IMHO.

Cheers,



On Tue, 26 Feb 2002, Ken Brownfield wrote:

> On Tue, Feb 26, 2002 at 01:37:55AM -0800, Andre Hedrick wrote:
> [...]
> | The real solution for distros is to wrapper the dma_capable flags in the
> | module cores in 2.4 under the disk_only.  Also not setting
> | CONFIG_IDEDMA_AUTO will help but you are not permitted to invoke
> | 
> | echo using_dma:1 > /proc/ide/hda/settings
> 
> I noticed that "hdparm -d1 /dev/hda" timed out three times and reverted
> to PIO in my case, with DMA enabled but autoDMA disabled.  So does DMA
> support have to be on at boot and is only allowed to be disabled, not
> enabled?
> 
> If so, ide=dma is the proper solution for trusted boards, but it would
> be nice if the /proc or hdparm interfaces worked reliably for enabling
> DMA.
> 
> So what does this say about the autoDMA issue that I'm seeing?  For me,
> the best of both worlds is to have DMA enabled, but off by default and
> capable of being enabled from userspace (and kernel command line, less
> usefully).
> 
> Thanks,
> -- 
> Ken.
> brownfld@irridia.com
> 
> 
> | One of the issues to be address is a test for transfer modes, but have to
> | many other issues to address w/ clients to deal with distro issues.
> | 
> | Cheers,
> | 
> | Andre Hedrick
> | Linux Disk Certification Project                Linux ATA Development
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

