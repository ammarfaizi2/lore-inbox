Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVE0IeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVE0IeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVE0IeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:34:10 -0400
Received: from brick.kernel.dk ([62.242.22.158]:148 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S262069AbVE0IeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:34:05 -0400
Date: Fri, 27 May 2005 10:35:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050527083509.GT1435@suse.de>
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de> <4296DA4B.6040303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296DA4B.6040303@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Fri, May 27 2005, Jeff Garzik wrote:
> >>I just noticed a bug -- When ata_scsi_qc_new() fails, the code should 
> >>complete the command with queue-full, but does not.
> >>
> >>       qc = ata_scsi_qc_new(ap, dev, cmd, done);
> >>       if (!qc)
> >>               return;
> >
> >
> >Indeed, looks like an old bug.
> 
> Yep.  If you are knocking around in that area, would you mind killing it 
> for me?  :)

Actually, I didn't look far enough up - ata_scsi_qc_new() already
completes the command with QUEUE_FULL if ata_qc_new_init() fails. So
there's no bug, but perhaps it would be cleaner to move it to
ata_scsi_translate instead?

-- 
Jens Axboe

