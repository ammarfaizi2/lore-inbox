Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264081AbTEaAGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 20:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTEaAGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 20:06:31 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:38560 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264081AbTEaAG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 20:06:26 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Date: Sat, 31 May 2003 02:19:10 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Different geometry settings for identical drives
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <30751917229@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 03 at 16:38, Jeffrey W. Baker wrote:
> On Fri, 2003-05-30 at 16:20, Petr Vandrovec wrote:
> > On 30 May 03 at 15:46, Jeffrey Baker wrote:
> > 
> > > hda: host protected area => 1
> > > hda: setmax LBA 234441648, native  234375000
> > > hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> > > hdc: attached ide-disk driver.
> > > hdc: host protected area => 1
> > > hdc: setmax LBA 234441648, native  234375000
> > > hdc: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> > > hdd: attached ide-cdrom driver.
> > > hdd: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
> > > 
> > > The result is that hda works fine but hdc doesn't.  When I try to mke2fs
> > > on the latter I see:
> > > 
> > > hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > > hdc: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=234441583, sector=232343808

> The x86-64.org patch doesn't touch much outside of arch/x86_64.  You are
> right that CONFIG_IDE_STROKE is off:

Ok, after looking at your kernel output more, it seems like that there is 
something strange with your drive: we asked for sector 232343808 (0xDD94900), 
but your drive reports SectorIdNotFound on sector 234441583 (0xDF94B6F), 
which is 2097775 (0x020026F) sectors away from sector we requested... 
As with LBA largest transfer length is 256 sectors, there is something
wrong with your disk firmware... Which points to the dead disk 
together with some bug in the disk firmware (maybe drive wanted to
report bug in sector DD9496F, but got it somehow wrong?). Can you
try running Western's drive diagnostics on that drive?
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

