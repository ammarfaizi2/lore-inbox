Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUIANYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUIANYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUIANYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:24:08 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:4992 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266555AbUIANWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:22:03 -0400
Message-ID: <4135CC9E.5060905@rtr.ca>
Date: Wed, 01 Sep 2004 09:20:30 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: bzolnier@milosz.na.pl
Cc: Lee Revell <rlrevell@joe-job.com>, Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <200408272005.08407.bzolnier@elka.pw.edu.pl> <1093630121.837.39.camel@krustophenia.net> <200408272059.51779.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200408272059.51779.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>
>>What determines whether 48 bit addressing will be used then?
> 
> Availability of 48-bit addressing feature set and host capabilities
> (some don't support LBA48 when DMA is used etc.).

I haven't examined the "released" IDE drivers in some time,
but one optimisation that can save a LOT of CPU usage
is for the driver to only use LBA48 *when necessary*,
and use LBA28 I/O otherwise.

Each access to an IDE register typically chews up 600+ns,
or the equivalent of a couple thousand instruction executions
on a modern core.  Avoiding LBA48 when it's not needed will
save four such accesses per I/O, or about 2.5us.

LBA48 is only needed when (1) the sector count is greater than 256,
and/or (2) the ending sector number >= (1<<28).

I regularly include this optimisation in the drivers I have been
working on since LBA48 first appeared.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
