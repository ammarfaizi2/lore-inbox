Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUGaS1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUGaS1t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267981AbUGaS1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 14:27:49 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:24469 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S266014AbUGaS1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 14:27:46 -0400
Date: Sat, 31 Jul 2004 13:27:41 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
Message-ID: <20040731182741.GA21845@bliss>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731153609.GG23697@suse.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 05:36:10PM +0200, Jens Axboe wrote:
> On Fri, Jul 30 2004, Zinx Verituse wrote:
> > I'm going to bump this topic a bit, since it's been a while..
> > There are still some issues with ide-cd's SG_IO, listed from
> > most important as percieved by me to least:
> > 
> >  * Read-only access grants you the ability to write/blank media in the drive
> >  * (with above) You can open the device only in read-only mode.
> 
> That's by design. Search linux-scsi or this list for why that is so.

The only thing I can find on the linux-scsi list is refering to sg
devices, which are on a different device node from the non-generic
device.  This means you can still allow users read access to the disk
without allowing them to send random commands to the disk -- this isn't
currently possible with the IDE interface, since the device with
generic access is the same as the one with the original read/cdrom
commands access.

As it is, it's impossible grant users read-only access to an IDE cd-rom
without allowing them to do things like replacing the firmware with a
malicious/non-working one.

Generic access allowing such things is fine; but only if we can grant
non-generic access without granting generic access.

> 
> >  * You can't open the device unless there is media in the drive
> 
> False, you use O_NONBLOCK.

Thanks, I didn't know about this one -- works great :)


> 
[snip stuff about scatter gather/manual dma]
> 
> -- 
> Jens Axboe

-- 
Zinx Verituse                                    http://zinx.xmms.org/
