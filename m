Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUI2Ojz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUI2Ojz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUI2Og1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:36:27 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:51936 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268582AbUI2Oee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:34:34 -0400
Subject: Re: Core scsi layer crashes in 2.6.8.1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1096464245.15907.27.camel@localhost.localdomain>
References: <1096401785.13936.5.camel@localhost.localdomain>
	<1096467125.2028.11.camel@mulgrave> 
	<1096464245.15907.27.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Sep 2004 10:34:25 -0400
Message-Id: <1096468472.2123.17.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 09:24, Alan Cox wrote:
>         badness in kref_get
>                 kobject_get, get_device, scsi_request_fn
>                 blk_insert_request, scsi_queue_insert
>                 scsi_eh_flush_done_q, scsi_unjam_host
>                 scsi_error_handler

Yes .. this is the significant one ... we're trying to get a reference
to a device that has already been released

>         OOPS scsi_device_dev_release
>                 device_release
>                 kobject_cleanup
>                 kobject_release
>                 kref_put
>                 scsi_request_fn

James


