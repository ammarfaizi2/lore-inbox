Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTDWWrC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTDWWrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:47:02 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61121 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264272AbTDWWrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:47:01 -0400
Date: Thu, 24 Apr 2003 00:58:48 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@digeo.com>
cc: <alan@lxorguk.ukuu.org.uk>, <andre@linux-ide.org>, <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
In-Reply-To: <20030423153500.0d99b4d3.akpm@digeo.com>
Message-ID: <Pine.SOL.4.30.0304240042550.22047-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Apr 2003, Andrew Morton wrote:

> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> >
> >
> > Hey,
> >
> > Another bunch of patches:
> >
> > (1) Enhance bio_(un)map_user() and add blk_rq_bio_prep().
> > (2) Pass bdev to IDE ioctl handlers.
> > (3) Add support for rq->bio based taskfile.
> > (4) Use direct-IO in ide_taskfile_ioctl() and in ide_cmd_ioctl().
>
> Dumb question: what does all this code actually do?

Code actually implements 'subject' so direct IO to user memory
for IDE specific taskfile ioctl. As a side effect it also cleans
scsi_ioctl.c a little.

>
> It appears to be implementing an IDE-specific ioctl() which performs bulk
> IO direct to/from userspace.  But that seems to be equivalent to O_DIRECT
> access to /dev/hda.

No, it is not equivalent, it does much, much more then O_DIRECT.
And this ioctl has been here for ages, only now it gets direct IO.

> What is special about the IDE ioctl approach?
>
> Thanks.

It can be used for _any_ access to IDE drive, even for some diagnostic
or vendor specific commands. User decides on transfer protocol
(PIO/DMA/queued DMA), addressing mode (CHS/LBA28/LBA48) etc.
User also gets drive status after command completion etc.

The main goal of the patch is to bring internal kernel handling
of this ioctl closer to kernel handling of normal fs IO, so only
_one_ common code will be used in future (benefits desribed in annonce).

Hope this helps...
--
Bartlomiej




