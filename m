Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbTFLK6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264813AbTFLK6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:58:47 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:40622 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S264812AbTFLK6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:58:46 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@digeo.com>
Cc: andyp@osdl.org, adam@yggdrasil.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030612035442.29345778.akpm@digeo.com>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	 <1055377253.1222.8.camel@andyp.pdx.osdl.net>
	 <20030611172958.5e4d3500.akpm@digeo.com>
	 <1055414558.565.4.camel@chtephan.cs.pocnet.net>
	 <20030612035442.29345778.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055416343.566.15.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 13:12:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2003-06-12 um 12.54 schrieb Andrew Morton:

> Christophe Saout <christophe@saout.de> wrote:
> >
> > Am Don, 2003-06-12 um 02.29 schrieb Andrew Morton:
> >
> > > I'd be interested in seeing the contents of /proc/meminfo immediately after
> > > the lilo run, see if there's any dirty memory left around.
> > 
> > Yes, one page. After running lilo, there are 4k diry, running sync
> > doesn't get it below 4k.
> 
> That would tend to imply that a page got onto the wrong list.  But if that
> were so, nothing would be able to write it.
> 
> > Only flushb /dev/hda does (or waiting several minutes).
> 
> What is flushb?

A program that does a flush ioctl on a block device:

open("/dev/hda", O_RDONLY)              = 3
ioctl(3, BLKFLSBUF, 0)                  = 0

> I use `lilo ; reboot -f' about 1000 times a day, no probs.  There's
> something different.
> 
> Adam was doing strange things with an initrd and pivot_root.  Are you doing
> anything unconventional?

I'm using an initrd (but no pivot_root) that initializes my LVM2 volumes
(using device-mapper).

/boot and / are on device-mapper devices.

> > BTW: I found out that now strace lilo freezes the machine...
> 
> Works OK here.  Try `strace strace lilo' ;)

I'll try to find out what happens. Not interested in crashing my system
while answering emails now. ;)

-- 
Christophe Saout <christophe@saout.de>

