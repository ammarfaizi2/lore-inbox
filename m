Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314769AbSESSOE>; Sun, 19 May 2002 14:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSESSOD>; Sun, 19 May 2002 14:14:03 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:61705
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S314769AbSESSOC>; Sun, 19 May 2002 14:14:02 -0400
Date: Sun, 19 May 2002 20:13:59 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: ULISSES FURQUIM FREIRE DA SILVA <ra993482@ic.unicamp.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware, IDE or ext3 problem?
Message-ID: <20020519201359.A17179@bouton.inet6-interne.fr>
Mail-Followup-To: ULISSES FURQUIM FREIRE DA SILVA <ra993482@ic.unicamp.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10205182031540.14231-100000@tigre.dcc.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 09:08:10PM -0300, ULISSES FURQUIM FREIRE DA SILVA wrote:
> 
> Hi,
> 
> 	I installed Red Hat 7.3 and the 2.4.18-3 kernel shows some IDE
> errors on boot like:
> 
> VFS: Mounted root (ext2 filesystem).
> Journalled Block Device driver loaded
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide0: reset: success
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> 
> 	I also tried the 2.4.18-4 kernel, but the errors continue. It's
> weird cause this happen only on boot and in spite of it the system runs
> fine.
> 	I have a SiS 5513 chipset with a QUANTUM FIREBALLlct15 20 IDE
> drive.
> 	I'm not sure if I have a true hardware problem or if there is a
> bug in the kernel. Any ideas?
> 	(please CC the answers to me)
> 
> Thanks,
> 
> -- Ulisses
> 

What's your exact chipset ?

`lspci | grep "00:00.0"` should show it.

SiS5513 is the IDE interface device shown on the PCI bus but there are a
hell lot of revisions.

BadCRC can be due to flaky hardware but I guess incorrect timings could be
another source of the problem. The only case of incorrect timings I'm aware
of is for ATA133: SiS645DX (just began working on it).

The IDE code should lower the DMA mode by itself when it sees BadCRC, what's
the output of `hdparm -i /dev/hda` after these errors show up ?

LB.
