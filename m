Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUIAOoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUIAOoC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 10:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266806AbUIAOoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 10:44:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266805AbUIAOny
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 10:43:54 -0400
Message-ID: <4135E017.1000901@pobox.com>
Date: Wed, 01 Sep 2004 10:43:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: bzolnier@milosz.na.pl, Lee Revell <rlrevell@joe-job.com>,
       Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <200408272005.08407.bzolnier@elka.pw.edu.pl> <1093630121.837.39.camel@krustophenia.net> <200408272059.51779.bzolnier@elka.pw.edu.pl> <4135CC9E.5060905@rtr.ca>
In-Reply-To: <4135CC9E.5060905@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>>
>>> What determines whether 48 bit addressing will be used then?
>>
>>
>> Availability of 48-bit addressing feature set and host capabilities
>> (some don't support LBA48 when DMA is used etc.).
> 
> 
> I haven't examined the "released" IDE drivers in some time,
> but one optimisation that can save a LOT of CPU usage
> is for the driver to only use LBA48 *when necessary*,
> and use LBA28 I/O otherwise.
> 
> Each access to an IDE register typically chews up 600+ns,
> or the equivalent of a couple thousand instruction executions
> on a modern core.  Avoiding LBA48 when it's not needed will
> save four such accesses per I/O, or about 2.5us.


Doing this is either pointless or impossible on newer SATA controllers. 
  Most are memory-mapped I/O not PIO, where the high-order bits of the 
ATA taskfile are accessed due to an extended register size, not 
"double-pumping" a FIFO.

Even-newer SATA controllers are FIS-based rather than taskfile-based, so 
you pass it a FIS (containing all the registers) unconditionally.

	Jeff


