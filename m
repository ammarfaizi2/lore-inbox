Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273529AbRIQH7A>; Mon, 17 Sep 2001 03:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273527AbRIQH6v>; Mon, 17 Sep 2001 03:58:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37896 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273522AbRIQH6m>;
	Mon, 17 Sep 2001 03:58:42 -0400
Date: Mon, 17 Sep 2001 09:59:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: lkml@krimedawg.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: OOPS in scsi generic stuff 2.4.10-pre6
Message-ID: <20010917095902.A1717@suse.de>
In-Reply-To: <3BA4CB70.50B4A3AB@torque.net> <20010916182208.B9006@suse.de> <20010916185522.D9006@suse.de> <3BA5759B.B5743C6D@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA5759B.B5743C6D@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17 2001, Douglas Gilbert wrote:
> Jens Axboe wrote:
> > 
> > On Sun, Sep 16 2001, Jens Axboe wrote:
> > > It looks like a race in that sg_cmd_done_bh can be completed before
> > > generic_unplug_device is called (and thus on a free'd scsi request). We
> > > then pass an invalid queue to generic_unplug_device.
> > 
> > (corrected version, scsi_allocate_request can of course fail)
> 
> Jens,
> Prior to this patch (actually the first one you posted
> today) sg_dd would frequently crash in generic_unplug_device
> when tested against the scsi_debug adapter driver. [I have 
> hacked up that driver to simulate a large number of (ram) 
> disks to test Richard Gooch's 2000+ scsi disk patch.]
> 
> The way scsi_debug handles all its commands, the bottom
> half handler in sg will be called before scsi_do_req()
> completes. With this patch the problem goes away.

Good, so at least that long standing race has been closed now.

-- 
Jens Axboe

