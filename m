Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVKKVmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVKKVmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVKKVmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:42:17 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:35997 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751237AbVKKVmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:42:16 -0500
Subject: RE: [PATCH 1/1] cciss: scsi error handling
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>, axboe@suse.de,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640A7A540D@cceexc18.americas.cpqcorp.net>
References: <45B36A38D959B44CB032DA427A6E10640A7A540D@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 15:41:47 -0600
Message-Id: <1131745307.3505.42.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 13:38 -0600, Cameron, Steve wrote:
> About the locking first,
> 
> So, there's one part that I was a little worried about, where
> it does this in a couple places:
> 
>         c = (ctlr_info_t **) &scsicmd->device->host->hostdata[0];
> 
> (gets our adapter structure by following pointers in the scsi
> command)
> 
> So, if that pointer chain can change suddenly, then my code is bad.
> 
> Can doing "echo scsi remove-single-device . . . > /proc/scsi/scsi"
> cause that pointer chain to break?  I noticed I can yank a disk
> out from under a mounted filesystem with 
> "echo scsi remove-single-device"  It wasn't obvious to me whether
> doing that would affect that pointer chain though, though I could
> imagine it might.
> 
> Or am I barking up the wrong tree worrying about 
> the scsicmd->device->host->hostdata pointer chain
> getting yanked out from under me?

No, the pointers are all held in place.  Even if everyone else releases
their references, the commmand still contains a reference to the device
(which holds it from being released) and the device likewise contains a
reference to the host.

James


