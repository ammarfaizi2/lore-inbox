Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUJLR5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUJLR5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUJLRxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:53:23 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:33475 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266308AbUJLRfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:35:38 -0400
Message-ID: <416C157A.6030400@rtr.ca>
Date: Tue, 12 Oct 2004 13:33:46 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i			nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165	A	4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca	>		<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.	A17	712@infradead.org>	<1097241583.2412.15.camel@mulgrave>		<4166AF2F.607090	4@rtr.ca> <1097249266.1678.40.camel@mulgrave>		<4166B48E.3020006@rtr.ca>	<1097250465.2412.49.camel@mulgrave> 	<416C0D55.1020603@rtr.ca>	<1097601478.2044.103.camel@mulgrave>  <416C12CC.1050301@rtr.ca> <1097602220.2044.119.camel@mulgrave>
In-Reply-To: <1097602220.2044.119.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
>
> In that scenario, you use a separate workqueue.

Okay. But what thread should run that workqueue?

> However, when I last looked at your driver you were only using the
> thread to provide user context for hotplug events ... where did this
> back end finishing thread come from?

It's been there since day one.  The interrupt handling sometimes requires
more functionality than is available at interrupt time, so it uses
schedule_work to have a bottom half re-run itself from thread context.
This is needed in the error-processing and hot plug paths.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
