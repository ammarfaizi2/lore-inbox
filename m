Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287299AbRL3BmE>; Sat, 29 Dec 2001 20:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbRL3Blz>; Sat, 29 Dec 2001 20:41:55 -0500
Received: from 217-125-101-55.uc.nombres.ttd.es ([217.125.101.55]:22723 "EHLO
	jep.dhis.org") by vger.kernel.org with ESMTP id <S287299AbRL3Blt>;
	Sat, 29 Dec 2001 20:41:49 -0500
Message-ID: <3C2E709A.1D12BEFB@jep.dhis.org>
Date: Sun, 30 Dec 2001 02:40:43 +0100
From: Josep Lladonosa i Capell <jep@jep.net.dhis.org>
Reply-To: jlladono@pie.xtec.es
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: ca, en, es
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
        Guest section DW <dwguest@win.tue.nl>,
        James Stevenson <mistral@stev.org>, jlladono@pie.xtec.es,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels, big ide disks and old bios
In-Reply-To: <Pine.LNX.4.10.10112271926400.24491-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> You have it called "STROKE".
>
> Use a patch and execute a soft-clip operation to the device and you are
> fixed.

...depends. I want the big disk to be /dev/hda, and bootable (an unattended
boot).

Disk is  119150/16/63. I soft (un)clipped it to max capacity (60Gb) with setmax
.

Configured it in the bios (32Gb limit) as a smaller disk, bios complained,
telling an error, asking to press F1 to continue. The LBA mode (4111/255/63,
LBA, for example) told the error, and asking for F1, as well. With
(65530/16/63, NORM), it booted well.
Kernel (2.4.17, patched) corrected the geometry while booting, but mke2fs
generated many io-errors, I suspect beyond the 32Gb.

Finally, a bios upgrade (unfortunately not for sizes beyond 32Gb), let me to
configure the setup with
the LBA mode, and boot works well, and mke2fs doesn't complain.

I don't need to use setmax to clip-unclip when booting.

What's the meaning of the 65535 max limit in bios_cyl? *

*I don't think it is a kernel limit.
*Is it the max value accepted by the physical disk, and that's why lba is used?

*Was that the problem with the io-errors?


# cat /proc/ide/hdc/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                119150          0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw


--
Salutacions...Josep
http://www.geocities.com/SiliconValley/Horizon/1065/
--



