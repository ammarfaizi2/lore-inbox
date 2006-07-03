Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWGCVKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWGCVKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWGCVKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:10:36 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:61923 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932130AbWGCVKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:10:35 -0400
Subject: Re: [Ubuntu PATCH] CDROMEJECT cannot eject some devices
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       axboe <axboe@suse.de>, scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <44A98220.2000007@oracle.com>
References: <44A98220.2000007@oracle.com>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 16:10:31 -0500
Message-Id: <1151961031.3445.15.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 13:46 -0700, Randy Dunlap wrote:
> -			err = blk_send_start_stop(q, bd_disk, 0x02);
> +			err = 0;
> +
> +			err |= blk_send_allow_medium_removal(q, bd_disk);

This piece is clearly wrong.  If the medium has physically been locked
(and the lock is managed by the cdrom layer) then we don't want to be
overriding it.  It should be up to the user or the tools to figure out
who has it open or mounted and take the appropriate action.

> +			err |= blk_send_start_stop(q, bd_disk, 0x01);

And this looks unnecessary.  Why does the device need to be started to
eject its medium?

> +			err |= blk_send_start_stop(q, bd_disk, 0x02);

James


