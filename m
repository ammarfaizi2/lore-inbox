Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270034AbUJHPgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270034AbUJHPgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270030AbUJHPgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:36:46 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:59838 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S270023AbUJHPgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:36:15 -0400
Message-ID: <4166B37D.8030701@rtr.ca>
Date: Fri, 08 Oct 2004 11:34:21 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@infradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165A45D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca>	<4165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca> 	<20041007221537.A17712@infradead.org>	<1097241583.2412.15.camel@mulgrave>  <4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave>
In-Reply-To: <1097249266.1678.40.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
 >
> We use this already for other entities that require user context like
> domain validation.  It seems to work as advertised.

Okay, done.

>>>scsi_done() doesn't require a lock
>>
>>Really?  I wonder why the mid-layer is so religious about
>>doing the lock around every invocation of it today?
> 
> It's not if you look at other drivers.

Well, I was actually looking at scsi.c, where this kind of thing is common:

    spin_lock_irqsave(host->host_lock, flags);
    scsi_done(cmd);
    spin_unlock_irqrestore(host->host_lock, flags);

If those locks are not needed, the scsi.c maintainer really should
nuke'em.  Meanwhile, I'll take them out of qstor.c as well, thanks.

> And you've tested this with things like SUSE's hwinfo utility which
> seems to send INQUIRIES on its own?

Not yet, but I have tested them with other scsiinfo-like tools.
Again, when it is proven to be an issue with something, it will get fixed.

> Really, I suppose, libata should provide the interfaces for doing this
> work for emulated commands.

Well, after this driver submission work is done with,
that's next on my list.  Right now libata doesn't have
the right interface for easy sharing of such functions.

And the driver will need it's own copy in some versions anyway,
since this driver will be used on much older/earlier kernels
than just the ones with the latest libata stuff.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
