Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSKFSFS>; Wed, 6 Nov 2002 13:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265900AbSKFSFS>; Wed, 6 Nov 2002 13:05:18 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:64718 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265894AbSKFSFR>;
	Wed, 6 Nov 2002 13:05:17 -0500
Date: Wed, 6 Nov 2002 10:11:44 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106101144.A10985@eng2.beaverton.ibm.com>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de> <20021106155656.GA20403@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021106155656.GA20403@www.kroptech.com>; from akropel1@rochester.rr.com on Wed, Nov 06, 2002 at 10:56:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 10:56:56AM -0500, Adam Kropelin wrote:
> On Wed, Nov 06, 2002 at 08:22:23AM +0100, Jens Axboe wrote:
> > On Tue, Nov 05 2002, Adam Kropelin wrote:
> > > Still without coaster I tried one more thing...
> > > 'dd if=/dev/zero of=foo bs=1M' in parallel with another burn. That one
> > > did it in. ;) I'm running ext3 and the writeout load totally killed
> > > burn, which isn't surprising. I was asking for it, I know. What happened
> > 
> > Really, this should work. The deadline scheduler should handle this just
> > fine in fact. Which device is your burner and which device is the hard
> > drive? It sounds like a bug.
> 
> Hard disk is sdc on onboard AIC7xxx.
> Writer is hdc, the only device on the secondary onboard IDE channel.
> All other disks (IDE & SCSI) were idle during the test.

What queue depth is the AIC setting?

SCSI in 2.5.x no longer copies the request, so if you have a queue
depth larger than the allocated requests there might not be
any free requests left for the blk layer to play with.

AIC default queue depth is 253 (with 2.5.46 queue depth can be set to 1
if scsi is all in kernel, or no upper drivers are available when the 
host adapter is intialized), it should auto lock it to the right depth,
but right now it does not notify the upper layer of the queue depth
change (no call to scsi_adjust_queue_depth when locking in the new
queue depth). You can modify .config, or pass boot/module options to
lower it.

-- Patrick Mansfield
