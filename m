Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311737AbSCTQLe>; Wed, 20 Mar 2002 11:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311739AbSCTQLZ>; Wed, 20 Mar 2002 11:11:25 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:32395 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S311737AbSCTQLK>;
	Wed, 20 Mar 2002 11:11:10 -0500
Date: Wed, 20 Mar 2002 17:10:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ken Brownfield <ken@irridia.com>, m.knoblauch@TeraPort.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP (RH7.2)
Message-ID: <20020320171051.A19871@ucw.cz>
In-Reply-To: <20020319190211.B15811@asooo.flowerfire.com> <E16nUx8-0000w4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 01:31:46AM +0000, Alan Cox wrote:
> > We're seeing this with Tyan 2410s and Seagate drives.  I think Tyan just
> > can't get DMA right.  Luckily we mainly lost docs or man pages before we
> > disabled DMA, although losing the rpm database sucked.  MDMA2 seems okay
> > but we haven't tested it long enough to form a lasting impression.
> > I'm actually patching the ServerWorks driver to honor the CONFIG flag,
> > since even with hdparm there is a narrow risk to the fs during the boot
> > process before DMA is disabled.
> 
> I can confirm problems with serverworks OSB4 and UDMA. With UDMA and
> a seagate disk you see 4 bytes repeat from one transfer into the next
> shuffling all the data up 4 bytes (which since it includes inode and
> metadata is *messy*). Current 2.4 has detect code that sometimes traps this
> and panics to avoid fs death.
> 
> With MWDMA all was fine.
> 
> This was observed across a large number of boxes in a rendering farm so its
> not a one off flawed box, and across two board vendors. I reported it to
> serverworks who were interested but couldnt reproduce it in their lab.

It seems like Daniela Engert found this problem too:

--------------------------------------------------------------------------------
 Vendor
 | Device
 | | Revision                          ATA      ATAPI        ATA66  ATA133
 | | | south/host bridge id          PIO  DMA  PIO  DMA  ATA33 | ATA100|   Docs
 | | | | south/host bridge rev.     32bit  |  32bit  |     |   |   |   |  avail
 | | | | |                            |    |    |    |     |   |   |   |    |   
 v v v v v                            v    v    v    v     v   v   v   v    v   

 0x1166 ServerWorks
   0x0211 OSB4                        x    x    ?    ?     x   -   -   -    x
   0x0212 CSB5
     < 0x92                           x    x    ?    ?     x   x   -   -    -
    >= 0x92                           x    x    ?    ?     x   x   x   -    -

 known bugs:
   - OSB4: at least some chip revisions can't do Ultra DMA mode 1 and above
   - CSB5: no host side cable type detection.

--------------------------------------------------------------------------------


-- 
Vojtech Pavlik
SuSE Labs
