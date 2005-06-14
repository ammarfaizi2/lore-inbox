Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVFNSQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFNSQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVFNSQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:16:40 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:2826 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261277AbVFNSQc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:16:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y/H0kQRvtu1WtrNQcan2SR1x155yyjbDNK+5ODflKdxNQmXEEBUn6EmyJ5fwkcyGq4iNLAub66NkfOBom9eGKggrSU1sB367Y3HkhqCadclKaJOrpiVrJy2n+Nux2m22ga/0p0mmgsR7MIMoGGgHn/j2bVxKQEqe031Elm+HggM=
Message-ID: <58cb370e05061411162b190ae9@mail.gmail.com>
Date: Tue, 14 Jun 2005 20:16:29 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Wiegley <jeffw@cyte.com>
Subject: Re: amd64 cdrom access locks system
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Jens Axboe <axboe@suse.de>
In-Reply-To: <42AEB30B.1070808@cyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42A64556.4060405@cyte.com> <20050608052354.7b70052c.akpm@osdl.org>
	 <42A861F8.9000301@cyte.com> <20050609160045.69c579d2.akpm@osdl.org>
	 <42ADB5B4.1020704@cyte.com>
	 <58cb370e05061400555407d144@mail.gmail.com>
	 <42AEB30B.1070808@cyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, Jeff Wiegley <jeffw@cyte.com> wrote:
> using "dev=/dev/hda" yeilds the exact same behavior...
> 
>    Jun 14 03:21:50 localhost kernel: ide-cd: cmd 0x3 timed out
>    Jun 14 03:21:50 localhost kernel: hda: lost interrupt
>    Jun 14 03:22:50 localhost kernel: ide-cd: cmd 0x3 timed out
>    Jun 14 03:22:50 localhost kernel: hda: lost interrupt
>    Jun 14 03:23:30 localhost kernel: hda: lost interrupt

Jens, any idea?

> And I'm a little confused by Robert's suggestion... Should it
> ever be possible for a user-space application to cause lost
> interrupts and other kernel state problems regardless of what
> "interface" is used?? Sure, if the application uses the wrong
> interface it should get spanked somehow but should it be able to
> mess up the kernel for other applications as well? (Like now
> I can't read or eject.)

It shouldn't be possible unless it is "raw" interface
(requires CAP_SYS_RAWIO) w/o checking all possible
parameters (it is not always possible) or device is buggy.

Also it is quite unlikely that somebody will fix obsolete
interface (hey, it got obsoleted for some reason ;-).

> The output from the cdrecord command was:
>    root@mail:~# cdrecord -v -eject -tao dev=/dev/hda stupid.iso
>    Cdrecord-Clone 2.01.01a01 (x86_64-unknown-linux-gnu) Copyright (C)
> 1995-2004 Joerg Schilling
>    NOTE: this version of cdrecord is an inofficial (modified) release of
> cdrecord
>          and thus may have bugs that are not present in the original
> version.
>          Please send bug reports and support requests to
> <cdrtools@packages.debian.org>.
>          The original author should not be bothered with problems of
> this version.
> 
>    cdrecord: Warning: Running on Linux-2.6.12-rc6-jw14
>    cdrecord: There are unsettled issues with Linux-2.5 and newer.
>    cdrecord: If you have unexpected problems, please try Linux-2.4 or
> Solaris.
>    TOC Type: 1 = CD-ROM
>    scsidev: '/dev/hda'
>    devname: '/dev/hda'
>    scsibus: -2 target: -2 lun: -2
>    Warning: Open by 'devname' is unintentional and not supported.
>    Linux sg driver version: 3.5.27
>    Using libscg version 'ubuntu-0.8ubuntu1'.
>    cdrecord: Warning: using inofficial version of libscg
> (ubuntu-0.8ubuntu1 '@(#)scsitransp.c      1.91 04/06/17 Copyright
> 1988,1995,2000-2004 J. Schilling').
>    SCSI buffer size: 64512
>    atapi: 1
>    Device type    : Removable CD-ROM
>    Version        : 0
>    Response Format: 2
>    Capabilities   :
>    Vendor_info    : 'SONY    '
>    Identifikation : 'DVD RW DRU-500A '
>    Revision       : '2.0h'
>    Device seems to be: Generic mmc2 DVD-R/DVD-RW.
>    Current: 0x0009
>    Profile: 0x001B
>    Profile: 0x001A
>    Profile: 0x0014
>    Profile: 0x0013
>    Profile: 0x0011
>    Profile: 0x0010
>    Profile: 0x000A
>    Profile: 0x0009 (current)
>    Profile: 0x0008
> 
> Since the kernel gets messed up and reports losts interrupts I'm
> inclined to believe that this is a kernel/driver issue and not my
> misuse of an application/interface. Though I realize cdrecord is
> being run as the superuser and therefore might be overiding some
> kernel security checks and messing with the kernel so I might be
> wrong about that.
> 
> One question comes to mind... Would Robert's suggestion and my
> results be affected by the fact that I don't have Packet Writing
> for CD drives turned on the current kernel?

No.

Bartlomiej
