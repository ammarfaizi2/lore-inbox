Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVFEHLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVFEHLA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 03:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFEHKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 03:10:23 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49860 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261505AbVFEHKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 03:10:09 -0400
Message-ID: <42A2A54B.9070607@pobox.com>
Date: Sun, 05 Jun 2005 03:10:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 02/09] blk: make scsi use -EOPNOTSUPP
 instead of -EIO on ILLEGAL_REQUEST
References: <20050605055337.6301E65A@htj.dyndns.org> <20050605055337.215AB52C@htj.dyndns.org>
In-Reply-To: <20050605055337.215AB52C@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> 02_blk_scsi_eopnotsupp.patch
> 
> 	Use -EOPNOTSUPP instead of -EIO on ILLEGAL_REQUEST.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
>  scsi_lib.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> Index: blk-fixes/drivers/scsi/scsi_lib.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/scsi_lib.c	2005-06-05 14:53:32.000000000 +0900
> +++ blk-fixes/drivers/scsi/scsi_lib.c	2005-06-05 14:53:33.000000000 +0900
> @@ -849,7 +849,8 @@ void scsi_io_completion(struct scsi_cmnd
>  				scsi_requeue_command(q, cmd);
>  				result = 0;
>  			} else {
> -				cmd = scsi_end_request(cmd, 0, this_count, 1);
> +				cmd = scsi_end_request(cmd, -EOPNOTSUPP,
> +						       this_count, 1);

This looks like a change from zero to EOPNOTSUPP, but your description 
says its a change from EIO to EOPNOTSUPP.

	Jeff



