Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269694AbUINSiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269694AbUINSiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269664AbUINS3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:29:16 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:6059 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269666AbUINS0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:26:11 -0400
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <414723B0.1090600@pobox.com>
References: <41471163.10709@rtr.ca>  <414723B0.1090600@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Sep 2004 14:25:35 -0400
Message-Id: <1095186343.2008.29.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 13:00, Jeff Garzik wrote:
> 9) use of do_sleep paradigm is dubious:  you should instead try to keep 
> your locked code regions as small as possible.  in general, this code 
> has far too many unlock-doit-lock sections.
> 
> Experience has shown that too much unlock-doit-lock leads to bugs and 
> increases the pain when analyzing your locking.
> 
> In particular, releasing the lock and sleeping would be very wrong in 
> the ->queuecommand and error handling paths (alas...  I would love to 
> sleep in the fine-grained eh hooks)

Actually, its only wrong in queuecommand because that can be called in
softirq context.

Sleeping in the eh paths is fine (as long as you drop the locks that the
EH thread has uselessly taken for you).  Indeed it's often required
since the return is supposed to tell the eh thread whether the action
was successful or not.

James


