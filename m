Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWDFSrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWDFSrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWDFSrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:47:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15583 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932220AbWDFSrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:47:13 -0400
Date: Thu, 6 Apr 2006 20:47:12 +0200
From: Jan Kara <jack@suse.cz>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hanging ext3 or USB, linux 2.6.16-rc6-mm2
Message-ID: <20060406184712.GA5458@atrey.karlin.mff.cuni.cz>
References: <20060327210514.GA24421@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327210514.GA24421@aitel.hist.no>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I managed to hang ext3 or usb today.
> I have a small machine that boot off a compactflash card.
> I want to use a bigger card, so I used scp to copy everything
> from that machine to a new 4GB card in a usb cardreader.
> This cardreader have never given me trouble before, but is
> usually used for reading.
> 
> I decided on a ext3 fs in order to avoid long fsck runs,
> and a minimal 4MB journal in order to not waste space.
> Disk seeks are supposed to be really cheap on a device
> with no moving parts anyway.  The root reserved percentage
> is 1% instead of the usual 5% - more space, and fragmentation
> will probably not hurt much with cheap seeks.
> 
> When scp had filled the card to 71% of capacity (according to df), 
> it stopped in the middle of a file.  I first suspected network
> errors, but a "ls /mnt" hung.
> 
> I now have the following processes in D-state:
> [khubd] [scsi_eh_4] [usb-storage] [kjournald] scp,
> 3 x [pdflush], 2 x ls, lsusb, and a sync.
> 
> Could this be a ext3 problem due to the small journal or something?
> 
> Or is a usb problem more likely? "Dmesg" shows an
> usb disconnect sometime after I mounted that filesystem,
> but it seems to be usblp0 which looks like the printer to me.
  I'd guess it is some USB/block layer problem. If just ext3 hung, then
you would not see [usb-storage] and similar hung. I would need to see
where each process hung to tell more..

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
