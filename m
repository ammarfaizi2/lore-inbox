Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269685AbUINSMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbUINSMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269667AbUINSK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:10:28 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:52120 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269540AbUINSFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:05:11 -0400
Message-ID: <41473270.3070405@rtr.ca>
Date: Tue, 14 Sep 2004 14:03:28 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com> <41472FA0.2090108@rtr.ca> <414730D9.3000003@pobox.com>
In-Reply-To: <414730D9.3000003@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >The SCSI LLD API really needs to -not- spinlock on the EH hooks,
 >and instead simply guarantee that ->queuecommand and other hooks
 >will not be called while the driver is in EH.
 >
 >ISTR James didn't disagree, so maybe a patch can be worked out...

It looks to me as if the eh code prevents further queuecommand()
calls while the LLD *_reset_handler() code is running.
I wonder if it also does so for the eh_strategy_handler() ?

Have to look at it, I guess.

 >Of course, you could always just use ->eh_strategy_handler
 >and do 100% of the error handling yourself.

Mmmm.. yes, that may be better, perhaps.

Whatever this driver does, it has to be reasonably portable
back to early 2.4.xx kernels, so it cannot depend too much
upon newly (or to-be) implemented semantics in 2.6.xx.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
