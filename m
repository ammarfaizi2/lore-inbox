Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVCDJA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVCDJA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVCDJA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:00:26 -0500
Received: from siaag2aa.compuserve.com ([149.174.40.131]:50384 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262693AbVCDIzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:55:50 -0500
Date: Fri, 4 Mar 2005 03:52:57 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch ide-dev 6/9] check capacity in
  ide_task_init_flush()
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
Message-ID: <200503040355_MC3-1-979D-F1DF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 at 15:44:34, Bartlomiej Zolnierkiewicz wrote:

> --- a/drivers/ide/ide-io.c    2005-02-23 20:58:16 +01:00
> +++ b/drivers/ide/ide-io.c    2005-02-23 20:58:16 +01:00
> @@ -61,7 +61,8 @@
> 
>       memset(task, 0, sizeof(*task));
> 
> -     if (ide_id_has_flush_cache_ext(drive->id)) {
> +     if (ide_id_has_flush_cache_ext(drive->id) &&
> +         (drive->capacity64 >= (1UL << 28))) {
                               ^^
------------------------------>||

>               tf->command = WIN_FLUSH_CACHE_EXT;
>               tf->flags |= ATA_TFLAG_LBA48;
>       } else

  Shouldn't that be ">" ???

  Either that or this code from ide-disk is wrong:

        /* limit drive capacity to 137GB if LBA48 cannot be used */
        if (drive->addressing == 0 && drive->capacity64 > 1ULL << 28) {
                printk(KERN_WARNING "%s: cannot use LBA48 - full capacity "
                       "%llu sectors (%llu MB)\n",
                       drive->name, (unsigned long long)drive->capacity64,
                       sectors_to_MB(drive->capacity64));
                drive->capacity64 = 1ULL << 28;
        }


--
Chuck
