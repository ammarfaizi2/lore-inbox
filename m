Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273477AbRIQE6G>; Mon, 17 Sep 2001 00:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273475AbRIQE55>; Mon, 17 Sep 2001 00:57:57 -0400
Received: from gear.torque.net ([204.138.244.1]:40463 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S273471AbRIQE5o>;
	Mon, 17 Sep 2001 00:57:44 -0400
Message-ID: <3BA5759B.B5743C6D@torque.net>
Date: Mon, 17 Sep 2001 00:01:31 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lkml@krimedawg.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: OOPS in scsi generic stuff 2.4.10-pre6
In-Reply-To: <3BA4CB70.50B4A3AB@torque.net> <20010916182208.B9006@suse.de> <20010916185522.D9006@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sun, Sep 16 2001, Jens Axboe wrote:
> > It looks like a race in that sg_cmd_done_bh can be completed before
> > generic_unplug_device is called (and thus on a free'd scsi request). We
> > then pass an invalid queue to generic_unplug_device.
> 
> (corrected version, scsi_allocate_request can of course fail)

Jens,
Prior to this patch (actually the first one you posted
today) sg_dd would frequently crash in generic_unplug_device
when tested against the scsi_debug adapter driver. [I have 
hacked up that driver to simulate a large number of (ram) 
disks to test Richard Gooch's 2000+ scsi disk patch.]

The way scsi_debug handles all its commands, the bottom
half handler in sg will be called before scsi_do_req()
completes. With this patch the problem goes away.

Doug Gilbert

