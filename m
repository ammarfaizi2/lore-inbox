Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVASH0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVASH0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVASH0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:26:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38035 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261610AbVASH0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:26:03 -0500
Date: Wed, 19 Jan 2005 08:25:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Peter Osterlund <petero2@telia.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix verify_command to allow burning more than 1 DVD
Message-ID: <20050119072555.GQ6909@suse.de>
References: <41EC214D.6060607@stud.feec.vutbr.cz> <m3k6qafjea.fsf@telia.com> <41EDAD71.80203@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EDAD71.80203@stud.feec.vutbr.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19 2005, Michal Schmidt wrote:
> Peter Osterlund wrote:
> >Michal Schmidt <xschmi00@stud.feec.vutbr.cz> writes:
> >>--- linux-2.6.11-mm1/drivers/block/scsi_ioctl.c.orig	2005-01-17 
> >>20:42:40.000000000 +0100
> >>+++ linux-2.6.11-mm1/drivers/block/scsi_ioctl.c	2005-01-17 
> >>20:43:14.000000000 +0100
> >>@@ -197,9 +197,7 @@ static int verify_command(struct file *f
> >>	if (type & CMD_WRITE_SAFE) {
> >>		if (file->f_mode & FMODE_WRITE)
> >>			return 0;
> >>-	}
> >>-
> >>-	if (!(type & CMD_WARNED)) {
> >>+	} else if (!(type & CMD_WARNED)) {
> >>		cmd_type[cmd[0]] = CMD_WARNED;
> >>		printk(KERN_WARNING "scsi: unknown opcode 0x%02x\n", cmd[0]);
> >>	}
> >
> >
> >That patch will not write the warning message in some cases. 
> 
> Yes. In cases when the device is opened for reading and the command is 
> known as safe_for_write.
> Do we really want to print this warning in that case?

No, the command should only be dumped if it is unknown and denied.

-- 
Jens Axboe

