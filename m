Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313661AbSEJLIK>; Fri, 10 May 2002 07:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSEJLIJ>; Fri, 10 May 2002 07:08:09 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:7172 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313661AbSEJLII>; Fri, 10 May 2002 07:08:08 -0400
Date: Fri, 10 May 2002 13:08:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.15 IDE possibly trying to scribble beyond end of device
Message-ID: <20020510110805.GA9054@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 18 days, 4:44)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just rebooted to 2.5.15 to find 'depmod -a' report I/O errors
on one of the files in the module tree.

Back in 2.4, trying to access the file (on my reiserfs root) reports:

May 10 12:56:26 nibbler kernel: attempt to access beyond end of device
May 10 12:56:26 nibbler kernel: 03:03: rw=0, want=807359916, limit=8185117

Everything else looks intact.

Running reiserfsck on the fs exits on an assertion error. Looks like I'll
have to re-mkfs the whole thing -- getting rid of the corrupt file seems
impossible.

The setup is:
K7/1GHz
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 9729/255/63, sectors = 156301488, start = 0
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5


I haven't observed similar problems in any of 2.5.14, 2.5.14-dj[12].

T.
