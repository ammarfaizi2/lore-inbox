Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWERJf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWERJf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWERJfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:35:25 -0400
Received: from smtp-1.hut.fi ([130.233.228.91]:25790 "EHLO smtp-1.hut.fi")
	by vger.kernel.org with ESMTP id S1751129AbWERJfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:35:23 -0400
Date: Thu, 18 May 2006 12:33:53 +0300 (EEST)
From: Jan Wagner <jwagner@kurp.hut.fi>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
In-Reply-To: <20060517134003.GE23933@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.58.0605181009020.9544@kurp.hut.fi>
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com>
 <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi> <20060517134003.GE23933@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-TKK-Virus-Scanned: by amavisd-new-2.1.2-hutcc at katosiko.hut.fi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 17 May 2006, Lennart Sorensen wrote:
> > To record or play back real-time continuous streamed data that is not
> > error-critical but delay critical, from/to a bidirectional data
> > aquisition card at ~1Gbit/s over longer time spans.
>
> Do you know of a disk that can handle 1Gbit/s to the platter?  Or are
> you planning to stripe this across multiple disks?
> I would think a controller on a fast enough bus (plain PCI isn't going
> to handle it), with enough drives in a raid setup of the right type
> should probably handle it.  Might need to do a filesystem specially
> designed for the streaming needs rather than general purpose file
> storage.

Yes, multiple disks striped in RAID-0, 4 x DiamondMax 10 300GB, ext2 fs.
On a cheapish Dell OptiPlex GX620 that uses Intel 945G. 1.6Gbit/s write
to disk while reading PCI(-X) goes just fine, though of course gets
slower near disk ends.

Streaming filesystems, yes, that's what I'd like to evaluate next vs
ext2 once the Samsung SP2504C disks with Streaming Feature Set support
arrive.

> > Direct kernel device support for the feature set could also be very useful
> > for linux projects like the Digital Video Recorder and Video Disk
> > Recorder. And seek/stutter free video playback from DVD/ATAPI (scratched
> > disks, for example) or video editing. Etc.
>
> Can you tell a DVD drive to stop retrying?  Perhaps you can.  I know
> some of the retries are in software.

Ok, probably yes, this is also something to be done outside of kernel.

However this guy over here
 http://www.ussg.iu.edu/hypermail/linux/kernel/0411.3/0338.html
has written speedcontrol.c for SET STREAMING (linked pdf there, page
457), which is somewhat similar to the commands in the Streaming feature
set. One quote: "In my opinion it would make sence to also enhance the
kernel function cdrom_select_speed (linux/drivers/ide/ide-cd.c), so that
this function works also for "newer" DVD-drives." etc

But OTOH also Tejun's points about that this Streaming set should be
implemented in userland are quite valid. And I don't know where exactly
such functionality could be added to the kernel i.e. where I would propose
such a feature to be added; it was a thought there might be some suitable
place and people here would know where to add ;-))

But actually after googling more, XFS file system seems to have something
like Streaming feature set support, or at least provisions for adding such
commands, as it has a guaranteed-rate I/O feature
  http://en.wikipedia.org/wiki/XFS#Guaranteed_rate_I.2FO

So I guess XFS code is the better place to start thinking about Streaming
feature set implementation.

Many thanks for your input! :-))

 - Jan
