Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUBBSrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUBBSrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:47:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:36302 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265732AbUBBSrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:47:16 -0500
Subject: Re: ide taskfile and cdrom hang
From: Mark Haverkamp <markh@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
In-Reply-To: <200402012148.20590.bzolnier@elka.pw.edu.pl>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net>
	 <200402012148.20590.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1075747608.8503.198.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 10:46:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-01 at 12:48, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Friday 30 of January 2004 23:36, Mark Haverkamp wrote:
> > We have some test machines here at OSDL that have a problem with the ide
> > cdrom driver hanging when we cat the /proc/ide/hda/identify file. After
> > 30 seconds the console displays: "hda: lost interrupt" which reoccurs
> > every 30 seconds forever. We noticed it on 2.6.2-rc2-mm1 but It looks
> > like this has been a problem for a while. Our test machines just changed
> > their configuration to use make defconfig.  I found that if
> > CONFIG_IDE_TASKFILE_IO is N then the hang doesn't occur.  Is this a
> > common problem or are there just certain drives that won't work with
> > taskfile i/o enabled?  I've included my .config, lspci as attachments.
> > The cdrom model is CD-224E.
> 
> Does 'hdparm -I /dev/hda" work?  If so can you try this patch?
> It reverts taskfile code to use old (non-taskfile) order of accessing
> port registers for ATAPI identify command.  This is a good starting point.
> 
> If CONFIG_IDE_TASKFILE_IO is N code just ignores BUSY status of a drive
> and reads some random data.  I would like to have this problem solved
> at least instead of adding the same workaround to CONFIG_IDE_TASKFILE_IO.
> 
> Cheers,
> --bart

Thanks,

hdparm -I /dev/hda didn't hang.  I got this on the console:

hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04Aborted Command

I added the patch that you provided and I still get the hang when I cat
/proc/ide/hda/identify.  I put a printk In the code to make sure that it
was going through the added code, and it is. 


Mark.
-- 
Mark Haverkamp <markh@osdl.org>

