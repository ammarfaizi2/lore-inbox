Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbUJ0OWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbUJ0OWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUJ0OW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:22:29 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:27407 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262456AbUJ0OVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:21:11 -0400
Message-ID: <417FAE3F.20908@vmware.com>
Date: Wed, 27 Oct 2004 07:18:39 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Strange IO behaviour on wakeup from sleep
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2004 14:18:39.0771 (UTC) FILETIME=[DB0C2EB0:01C4BC2F]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.41; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Hi !
>
>Not much datas at this point yet, but paulus and I noticed that current
>bk (happened already last saturday or so) has a very strange problem
>when waking up from sleep (suspend to ram) on our laptops.
>
>This doesn't seem to be directly related to the PM code, at least not
>the arch one, as far as I know. The IDE throughput goes down to less
>than 100k/sec on hdparm. We haven't yet figured out where the time is
>lost, the disk seem to properly be restored to UDMA4 as usual, that code
>didn't change for ages, I don't think it's a problem at that level in
>IDE.
>  
>

I would tend to be very suspicious of DMA not being restored correctly 
because on some systems, prior to or during suspend, DMA may be shutdown 
to conserve power.  There are changes afloat that touch suspend/resume, 
and there have been historical problems with DMA not being restored 
properly after wakeup on some laptops.

Although this may be another shot in the dark, it might rule out the DMA 
problem:  try cat /proc/ide/yourchipset before and after suspend and 
note any changes.  Failing that, use hdparm to turn off DMA before 
suspend and see if the performance suffers to the same degree as after 
wakeup.

Zachary Amsden
zach@vmware.com
