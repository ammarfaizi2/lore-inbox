Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270040AbUJHPqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270040AbUJHPqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270039AbUJHPnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:43:53 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:63166 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S270040AbUJHPkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:40:45 -0400
Message-ID: <4166B48E.3020006@rtr.ca>
Date: Fri, 08 Oct 2004 11:38:54 -0400
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
> On Fri, 2004-10-08 at 10:15, Mark Lord wrote:
> 
>>>Actually, the driver has no need for a thread at all.  Since you're
>>>simply using it to fire hotplug events, use schedule_work instead.
>>
>>That worries me some, because the mid-layer will perform blocking I/O
>>and the like, and I'm not sure how much that stuff may depend on its
>>own usage (any?) of workqueues.  If you believe it to be safe,
>>then I'll nuke the kthread entirely.
> 
> 
> We use this already for other entities that require user context like
> domain validation.  It seems to work as advertised.

Can deadlock occur here, since qstor.c is already using schedule_work()
as part of it's internal bottom-half handling for abnormal conditions?

Eg.  hotplug event -> schedule_work -> mid-layer -> queuecommand
       --> sleep  :: interrupt -> schedule_work -> deadlock?

Just checking.. we all want this to function well.
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
