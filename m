Return-Path: <linux-kernel-owner+w=401wt.eu-S932674AbWLTAjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWLTAjx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWLTAjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:39:53 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57061 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674AbWLTAjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:39:53 -0500
Message-ID: <45888653.6080702@pobox.com>
Date: Tue, 19 Dec 2006 19:39:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan <alan@lxorguk.ukuu.org.uk>, David Shirley <tephra@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA DMA problem (sata_uli)
References: <f0e65c090612122102o327ac693u2f24a74a9ba973ef@mail.gmail.com> <20061213112004.59cb186c@localhost.localdomain> <45841B20.9030402@pobox.com> <458884B2.9080802@gmail.com>
In-Reply-To: <458884B2.9080802@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Alan wrote:
>>>> I tracked it down to one of the drives being forced into PIO4 mode
>>>> rather than UDMA mode; dmesg bits:
>>>> ata4.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
>>>> ata4.00: ata4: dev 0 multi count 16
>>>> ata4.00: simplex DMA is claimed by other device, disabling DMA
>>> Your ULi controller is reporting that it supports UDMA upon only one
>>> channel at a time. The kernel is honouring this information. The older
>>> ULi (was ALi) PATA devices report simplex but let you turn it off so
>>> see if the following does the trick. Test carefully as always with
>>> disk driver
>>> changes.
>>>
>>> (Jeff probably best to check the docs before merging this but I believe
>>> it is sane)
>>>
>>> Signed-off-by: Alan Cox <alan@redhat.com>
>> My Uli SATA docs do not appear to cover the bmdma registers :(  Only the
>> PCI config registers.
>>
>> But regardless, I think the better fix is to never set ATA_HOST_SIMPLEX
>> if ATA_FLAG_NO_LEGACY is set.
>>
>> None of the SATA controllers I've ever encountered has been simplex.
> 
> Just another data point.  The same problem is reported by bug #7590.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7590
> 
> Is somebody brewing a patch?

Not to my knowledge.  Did you just volunteer?  ;-)

/me runs...

	Jeff



