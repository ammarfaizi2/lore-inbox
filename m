Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUHIPZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUHIPZD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUHIPVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:21:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9697 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261563AbUHIPRs (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:17:48 -0400
Date: Mon, 9 Aug 2004 17:17:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Linux-kernel@vger.kernel.org
Subject: Re: Cannot burn without strace on 2.6.8-rc3-mm1
Message-ID: <20040809151717.GZ10418@suse.de>
References: <200408091649.20180@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408091649.20180@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Alexander Gran wrote:
> Ok, thats strange:
> 
> Just switched form 2.6.7-mm5 to 2.6.8-rc3-mm1
> However I cannot burn with cdrecord.
> cdrecord -v dev=/dev/hdc -dao driveropts=burnfree 
> -data /files/Pakete/KNOPPIX_V3.4-2004-05-17-DE.iso
> gives:
> 
> alex@t40:~$ cdrecord -v dev=/dev/hdc -dao driveropts\=burnfree 
> -data /files/Pakete/KNOPPIX_V3.4-2004-05-17-DE.iso
> Cdrecord-Clone 2.01a34 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg 
> Schilling
> NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord
>       and thus may have bugs that are not present in the original version.
>       Please send bug reports and support requests to 
> <cdrtools@packages.debian.org>.
>       The original author should not be bothered with problems of this 
> version.
> 
> TOC Type: 1 = CD-ROM
> scsidev: '/dev/hdc'
> devname: '/dev/hdc'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.8'.
> Driveropts: 'burnfree'
> SCSI buffer size: 64512
> cdrecord: Cannot allocate memory. Cannot get SCSI I/O buffer.

Apply this patch.

> However 
> strace cdrecord -v dev=/dev/hdc -dao driveropts=burnfree 
> -data /files/Pakete/KNOPPIX_V3.4-2004-05-17-DE.iso
> just works..Strange, um?

Uhm are you sure?

--- linux-2.6.8-rc3-mm1/drivers/block/scsi_ioctl.c~	2004-08-09 08:59:06.817350600 +0200
+++ linux-2.6.8-rc3-mm1/drivers/block/scsi_ioctl.c	2004-08-09 08:59:36.480841064 +0200
@@ -90,7 +90,7 @@
 	if (size < 0)
 		return -EINVAL;
 	if (size > (q->max_sectors << 9))
-		return -EINVAL;
+		size = q->max_sectors << 9;
 
 	q->sg_reserved_size = size;
 	return 0;

-- 
Jens Axboe

