Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265821AbSKFXqM>; Wed, 6 Nov 2002 18:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266098AbSKFXqM>; Wed, 6 Nov 2002 18:46:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23286 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265821AbSKFXqL>;
	Wed, 6 Nov 2002 18:46:11 -0500
Date: Wed, 6 Nov 2002 15:52:35 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106155235.A17479@eng2.beaverton.ibm.com>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de> <20021106155656.GA20403@www.kroptech.com> <20021106101144.A10985@eng2.beaverton.ibm.com> <20021106233325.GA29940@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021106233325.GA29940@www.kroptech.com>; from akropel1@rochester.rr.com on Wed, Nov 06, 2002 at 06:33:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 06:33:25PM -0500, Adam Kropelin wrote:
> On Wed, Nov 06, 2002 at 10:11:44AM -0800, Patrick Mansfield wrote:

> > What queue depth is the AIC setting?
> > 
> > SCSI in 2.5.x no longer copies the request, so if you have a queue
> > depth larger than the allocated requests there might not be
> > any free requests left for the blk layer to play with.
> > 
> > AIC default queue depth is 253 (with 2.5.46 queue depth can be set to 1
> 
> Are you talking tcq depth here? Best as I can tell, 2.5.46 defaults to
> 16. Lowering it to 2 doesn't seem to help.

Yes, but not the IDE code (I have know idea what IDE defaults to). If you
have sg its proc interface can dump them, but AIC should default to 253,
on my system with AIC adapter (not the aic7xxx_old adapter, it looks like
it defaults to 32) I typically see:

cat /proc/scsi/sg/device_hdr /proc/scsi/sg/devices
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       0       2       253     0       1
0       0       1       0       0       1       253     0       1
0       0       15      0       3       0       2       0       1

The last device does not support tcq (id 15), so it gets a depth of 2.

The AIC driver also prints the depth on init/boot like so:

	scsi0:A:0:0: Tagged Queuing enabled.  Depth 253

My .config has (default cmd per device):

CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000

-- Patrick Mansfield
