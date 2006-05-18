Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWERXSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWERXSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWERXSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:18:49 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:29484 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750989AbWERXSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:18:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=B7NsjRpMct6k2Fho4mKfccMQZUoqnt6KIkjLjYhUFMxM3rLRctOV38THWOWSXPIhj1IFPCfSKMSypr9hWBhhuxtagj3vSZnYVpQOLL6s3VGl1NTIJUSP0g0UnX5DsmWF+ZGydZs2iosFwc+opCAhjhosOdfrC39l3bAVUZJexUg=
Message-ID: <446D00D5.2040006@gmail.com>
Date: Fri, 19 May 2006 08:18:45 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Mark Lord <lkml@rtr.ca>, Jan Wagner <jwagner@kurp.hut.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com> <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi> <446BD8F2.10509@gmail.com> <446C7435.2040809@rtr.ca> <446C9503.1020609@garzik.org>
In-Reply-To: <446C9503.1020609@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> The device driver has to know about it, at a minimum so that it can
>> select a different EH protocol for the streams.  Which in turn means
>> that the streaming commands should be known to the driver as well.
> 
> Different taskfile protocol, you mean?

I haven't checked all the docs and codes thoroughly but I don't see a 
need for new protocol or anything.  When a streaming command fails due 
to failing to meet timing constraints, it fails w/ device error.  sg can 
adjust retry count and the device error will be reported without much 
recovery action (only revalidation).  If the device fails due to some 
other reasons (say HSM violation), it needs full EH no matter what. 
Without full EH, it becomes completely unusable.

>> But how to handle it all nicely is the real question.
>> A new block driver, if libata cannot handle it?
> 
> I seriously doubt writing a whole new ATA driver subsystem will fly :)

All I can see are little extensions to sg interface and maybe libata.  I 
don't think it needs full-blown in-kernel driver.  However, to use this 
feature with a filesystem, we would need to build a block map of the 
file to use.  I think such feature is already provided and used by 
LILO/GRUB kinds of things.

-- 
tejun
