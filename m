Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUKFSqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUKFSqL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbUKFSqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 13:46:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16304 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261437AbUKFSp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 13:45:58 -0500
Date: Sat, 6 Nov 2004 18:45:55 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       Richard Waltham <richard@fars-robotics.net>,
       SUPPORT <support@4bridgeworks.com>, Thomas Babut <thomas@babut.net>,
       linux-kernel@vger.kernel.org, Linux SCSI <linux-scsi@vger.kernel.org>,
       groudier@free.fr
Subject: Re: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Ada pter
Message-ID: <20041106184555.GD24690@parcelfarce.linux.theplanet.co.uk>
References: <D5169CBBC6369D4CBFFABD7905CC9D695D31@tehran.Fars-Robotics.local> <20041106035951.GC24690@parcelfarce.linux.theplanet.co.uk> <20041106120358.GC23305@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106120358.GC23305@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:03:58PM +0000, Christoph Hellwig wrote:
> On Sat, Nov 06, 2004 at 03:59:51AM +0000, Matthew Wilcox wrote:
> > On Sat, Nov 06, 2004 at 12:02:32AM -0000, Richard Waltham wrote:
> > > Good as a backup but the original PPR capability is defined in
> > > scan_scsi.c. Shouldn't scan_scsi.c take note of the bus mode and enable
> > > PPR capabilities accordingly? This would then cover this issue for all
> > > relevant LLDDs wouldn't it?
> > 
> > scan_scsi.c doesn't know what mode the bus is in.  scan_scsi.c doesn't
> > even know whether the bus is SPI, FC, iSCSI, SAS or SATA.
> 
> And PPR only makes sense for SPI anyway.  An good argument why this
> should move to the SPI transport class, which does know about SE vs HVD
> vs LVD.

That would make sense if more of this were done at a higher level.
As it is right now, the decision whether to use PPR, SDTR or WDTR is
entirely up to the driver.  I think there's a lot more consolidation
that could be done into the midlayer, but we should probably see what
other drivers requirements are before making it perfect for sym2.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
