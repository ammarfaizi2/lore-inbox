Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUEOOUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUEOOUv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUEOOUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:20:51 -0400
Received: from h00207813f68b.ne.client2.attbi.com ([24.91.60.206]:20624 "EHLO
	buddha.badbelly.com") by vger.kernel.org with ESMTP id S262503AbUEOOUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:20:48 -0400
Subject: Re: Burning CDs with a CD-ROM is a bad idea
From: Gregory Boyce <gboyce@badbelly.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040515104752.GC24600@suse.de>
References: <Pine.LNX.4.58.0405141352540.7746@buddha.badbelly.com>
	 <20040515104752.GC24600@suse.de>
Content-Type: text/plain
Message-Id: <1084630641.1540.8.camel@qube.badbelly.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 15 May 2004 10:17:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-15 at 06:47, Jens Axboe wrote:
> On Fri, May 14 2004, gboyce@badbelly.com wrote:
> > Hello folks,
> > 
> > Yesterday I made a slight thinko while attempting to burn a CD.  Rather 
> > than specifying dev=/dev/hdd, I add dev=/dev/hdc, which is my CD-ROM 
> > drive rather than my cd burner.  Whoops!
> > 
> > Now, I believe I've done this before, and recieved an error message.  
> > However, in this particular case with 2.6.6, the system behaved a bit 
> > different.
> > 
> > bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
> > cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
> > ide-cd: cmd 0x1e timed out
> > hdc: lost interrupt
> 
> Looks like one of the burning commands confused the drive so much, that
> it now refuses to do anything (the above command is a simple medium
> removal prevention command, doesn't even need a data transfer).
> 
> So I don't think this is a kernel problem. Well maybe we could reset the
> device and see if it recovers (do you see any resets in the log?)

There was a reset early on, but it was before the majority of errors.

Here is the begining of problem:

May 13 16:38:14 cthulhu hdc: DMA interrupt recovery
May 13 16:38:14 cthulhu hdc: lost interrupt
May 13 16:38:14 cthulhu hdc: status timeout: status=0xd0 { Busy }
May 13 16:38:14 cthulhu hdc: status timeout: error=0x00
May 13 16:38:14 cthulhu hdc: DMA disabled
May 13 16:38:14 cthulhu hdc: drive not ready for command
May 13 16:38:15 cthulhu hdc: ATAPI reset complete
May 13 16:38:15 cthulhu cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC
May 13 16:38:15 cthulhu sector 0, nr/cnr 0/0
May 13 16:38:15 cthulhu bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
May 13 16:38:15 cthulhu cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
May 13 16:38:15 cthulhu hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
May 13 16:39:15 cthulhu ide-cd: cmd 0x1e timed out
May 13 16:39:15 cthulhu hdc: lost interrupt
May 13 16:39:15 cthulhu cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
May 13 16:39:15 cthulhu sector 0, nr/cnr 0/0
May 13 16:39:15 cthulhu bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
May 13 16:39:15 cthulhu cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
May 13 16:39:15 cthulhu hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)

There are an additional 700K of errors like this before I finally
rebooted the machine the next day.  The machine also refused to let me
burn CDs on the actual CD burner during this time.

--
Greg

