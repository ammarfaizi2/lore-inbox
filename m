Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264823AbTFBSAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbTFBSAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:00:33 -0400
Received: from [65.198.37.67] ([65.198.37.67]:484 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S264823AbTFBSAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:00:32 -0400
Subject: Re: Different geometry settings for identical drives
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <30751917229@vcnet.vc.cvut.cz>
References: <30751917229@vcnet.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1054577632.10369.5.camel@heat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 02 Jun 2003 11:13:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-30 at 17:19, Petr Vandrovec wrote:
> On 30 May 03 at 16:38, Jeffrey W. Baker wrote:
> > On Fri, 2003-05-30 at 16:20, Petr Vandrovec wrote:
> > > On 30 May 03 at 15:46, Jeffrey Baker wrote:
> > > 
> > > > hda: host protected area => 1
> > > > hda: setmax LBA 234441648, native  234375000
> > > > hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> > > > hdc: attached ide-disk driver.
> > > > hdc: host protected area => 1
> > > > hdc: setmax LBA 234441648, native  234375000
> > > > hdc: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> > > > hdd: attached ide-cdrom driver.
> > > > hdd: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
> > > > 
> > > > The result is that hda works fine but hdc doesn't.  When I try to mke2fs
> > > > on the latter I see:
> > > > 
> > > > hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > > > hdc: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=234441583, sector=232343808
> 
> > The x86-64.org patch doesn't touch much outside of arch/x86_64.  You are
> > right that CONFIG_IDE_STROKE is off:
> 
> Ok, after looking at your kernel output more, it seems like that there is 
> something strange with your drive: we asked for sector 232343808 (0xDD94900), 
> but your drive reports SectorIdNotFound on sector 234441583 (0xDF94B6F), 
> which is 2097775 (0x020026F) sectors away from sector we requested... 
> As with LBA largest transfer length is 256 sectors, there is something
> wrong with your disk firmware... Which points to the dead disk 
> together with some bug in the disk firmware (maybe drive wanted to
> report bug in sector DD9496F, but got it somehow wrong?). Can you
> try running Western's drive diagnostics on that drive?

I rebooted with the same drive but added hdc=14589,255,63, and now I can
make the filesystem perfectly well.  So it does seem to be an issue with
the way the disk is addressed.  Or I could just be fooling myself.

Later I can try swapping in identical hardware and see if the problem
persists.  All these disks are brand new and were burned in and
qualified by the vendor.

-jwb

