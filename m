Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269827AbUJGWIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269827AbUJGWIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269847AbUJGWII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:08:08 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:62909 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269827AbUJGWFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:05:24 -0400
Message-ID: <4165BD38.4020403@rtr.ca>
Date: Thu, 07 Oct 2004 18:03:36 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lsml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca> <20041007150709.B12688@infradead.org> <4165624C.5060405@rtr.ca> <416565DB.4050006@pobox.com> <4165A45D.2090200@rtr.ca> <4165A766.1040104@pobox.com> <4165A85D.7080704@rtr.ca> <4165AB1B.8000204@pobox.com> <4165ACF8.8060208@rtr.ca> <20041007221537.A17712@infradead.org>
In-Reply-To: <20041007221537.A17712@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Christoph Hellwig wrote:
 >
>  - the !dev case in qs_scsi_queuecomman can't happen

Are you sure?
I have seen it occur immediately after hot-removal
of a drive.  There have been other structural changes
since then, so perhaps it is no longer possible,
but I'd rather have the test there than have the
kernel ooops again.  If you feel strongly about it,
then away it goes.

>  - never mess with eh_timeout from inside a driver

Give us an interface for it, please.
In the meanwhile, gone!

>  - please don't implemente the HDIO_ ioctls, Jeff said this can
>    be done via SG_IO

SG_IO is incompatible with current user-mode toolsets.
Once that interface becomes more mature, and the distributions
gradually get updated with newer versions of the tools,
then the HDIO_ stuff can go (as per the comments in the source).
For now, it is essential for hdparm and smartmontools, among others.

Alternatively, as Jeff has suggested, we may be able to implement
a generic HDIO_ mechanism in libata that re-issues the commands
through SG_IO (perhaps that is what you meant).  Is that there now?

>  - if ->info return a static string you can just store it into ->name

So just nuke the _info() proc, and use .name = QS_DESC ?
Okay, done.

>  - please use the kernel/kthread.c interface for your kernel thread

Good -- I hadn't noticed that new interface before.

It's quite hard to find all of this stuff first time through,
as there are practically no existing drivers that don't have
many of the same comments applicable to them.

Perhaps this will be one of the first/few drivers
to become totally compliant with the latest kernel APIs.

Cheers
--
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
