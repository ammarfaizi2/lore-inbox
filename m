Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbTICAzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 20:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTICAzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 20:55:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19672 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261608AbTICAzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 20:55:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: steveb@unix.lancs.ac.uk
Subject: Re: corruption with A7A266+200GB disk?
Date: Wed, 3 Sep 2003 02:55:28 +0200
User-Agent: KMail/1.5
References: <E19uBCi-00054b-00@wing0.lancs.ac.uk>
In-Reply-To: <E19uBCi-00054b-00@wing0.lancs.ac.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309030255.28645.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Corruption is fixed in 2.6.0-test4.

Unfortunately it seems your IDE chipset doesnt support LBA48,
so you wont be able to access full capacity (137GB limit).

If you are ready to take a risk (again ;-) ) you can remove
"hwif->no_lba48 = ..." line from a drivers/ide/pci/alim15x3.c,
recompile and retest without using DMA (add "ide=nodma"
boot option).  Maybe LBA48 will work in PIO mode.

--bartlomiej

On Tuesday 02 of September 2003 15:28, steveb@unix.lancs.ac.uk wrote:
> I just got a new 200GB disk (WDC WD2000JB) for my home machine (Asus
> A7A266, Ali chipset). I put some partitions on it like so:
>   hda1:   100MB - /boot
>   hda2:  8192MB - /
>   hda3:  1024MB - swap
>   hda4:  the rest (about 190GB I guess) - /home
>
> I find that when I mkfs on /home, I get massive filesystem corruption on /
> When I fsck / (and restore the deleted files) I get massive filesystem
> corruption on /home. Luckily all my real data is still on my old disk...
>
> I reduced the size of /home to 40GB and everything was fine.
> I see the same behaviour with both 2.6.0test3 and 2.4.22.
> My guess is that writes to very high numbered blocks are wrapping round
> to lower numbered blocks in some way.
>
> so...anyone else seen this? Is it a known driver problem?
> Or is it a hardware issue?
> Anyone care to suggest stuff to try? The contents of the disk are toast
> (pretty much) so I can do destructive tests if it'll help...
>
> Output from lspci looks like this:
>   00:00.0 Host bridge: ALi Corporation M1647 Northbridge [MAGiK 1 /
> MobileMAGiK 1] (rev 04) 00:01.0 PCI bridge: ALi Corporation PCI to AGP
> Controller
>   00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
>   00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
>   00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
> 10) 00:06.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
> 00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
> 0c) 00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
> (rev 0c) 00:0d.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev
> 02) 00:11.0 Bridge: ALi Corporation M7101 PMU
>   01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO
> AGP 4x TMDS
>
> Thanks in advance,
>
> Steve Bennett
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> I just got a new 200GB disk (WDC WD2000JB) for my home machine (Asus
> A7A266, Ali chipset). I put some partitions on it like so:
>   hda1:   100MB - /boot
>   hda2:  8192MB - /
>   hda3:  1024MB - swap
>   hda4:  the rest (about 190GB I guess) - /home
>
> I find that when I mkfs on /home, I get massive filesystem corruption on /
> When I fsck / (and restore the deleted files) I get massive filesystem
> corruption on /home. Luckily all my real data is still on my old disk...
>
> I reduced the size of /home to 40GB and everything was fine.
> I see the same behaviour with both 2.6.0test3 and 2.4.22.
> My guess is that writes to very high numbered blocks are wrapping round
> to lower numbered blocks in some way.
>
> so...anyone else seen this? Is it a known driver problem?
> Or is it a hardware issue?
> Anyone care to suggest stuff to try? The contents of the disk are toast
> (pretty much) so I can do destructive tests if it'll help...
>
> Output from lspci looks like this:
>   00:00.0 Host bridge: ALi Corporation M1647 Northbridge [MAGiK 1 /
> MobileMAGiK 1] (rev 04) 00:01.0 PCI bridge: ALi Corporation PCI to AGP
> Controller
>   00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
>   00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
>   00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
> 10) 00:06.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
> 00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
> 0c) 00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
> (rev 0c) 00:0d.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev
> 02) 00:11.0 Bridge: ALi Corporation M7101 PMU
>   01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO
> AGP 4x TMDS
>
> Thanks in advance,
>
> Steve Bennett

