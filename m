Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUJLSBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUJLSBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUJLR5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:57:54 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:35267 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266236AbUJLRxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:53:43 -0400
Message-ID: <416C19B9.7000806@rtr.ca>
Date: Tue, 12 Oct 2004 13:51:53 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>, Mark Lord <lsml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i			nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165	A	4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca	>		<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.	A17	712@infradead.org>	<1097241583.2412.15.camel@mulgrave>		<4166AF2F.607090	4@rtr.ca> <1097249266.1678.40.camel@mulgrave>		<4166B48E.3020006@rtr.ca>	<1097250465.2412.49.camel@mulgrave> 	<416C0D55.1020603@rtr.ca>	<1097601478.2044.103.camel@mulgrave>  <416C12CC.1050301@rtr.ca> <1097602220.2044.119.camel@mulgrave> <416C157A.6030400@rtr.ca> <416C177B.6030504@pobox.com>
In-Reply-To: <416C177B.6030504@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
..
> The usual way to do what you want is either

That's how it works already, thanks, except that it
does have a few calls to in_interrupt() rather than
simply passing itself a flag parameter to convey the
same information -- I'll fix that now.

Except that it uses schedule_work() rather than a tasklet.
The bottom half is only there for abnormal conditions
like major chip errors and hotplug events.

So the only new suggestion here is to use a tasklet for
the bottom-half processing rather than schedule_work()?

I thought work queues were the preferred mechanism for
infrequent uses such as this these days?  A tasklet is no
problem here though, so long as worker threads (schedule_work)
do not also rely on tasklets.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
