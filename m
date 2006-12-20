Return-Path: <linux-kernel-owner+w=401wt.eu-S1753172AbWLTAdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbWLTAdE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbWLTAdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:33:04 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:38805 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbWLTAdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:33:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=AZapLEgoJj3HQuBew6vrrL1GWy+yUmr3bM/o8biAtkp14K74pORUMTGAJGpO82qlsbaEZ/3Mpt4TeFYvV8oxnVotP3tPfPB89TZIw6q8yeUUk99mxb3B+FytZ+EmbyBbIxVNW3CM/mqcrm3gGlLrSufoHpyd+OMI0yhY7LFqklo=
Message-ID: <458884B2.9080802@gmail.com>
Date: Wed, 20 Dec 2006 09:32:50 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Alan <alan@lxorguk.ukuu.org.uk>, David Shirley <tephra@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA DMA problem (sata_uli)
References: <f0e65c090612122102o327ac693u2f24a74a9ba973ef@mail.gmail.com> <20061213112004.59cb186c@localhost.localdomain> <45841B20.9030402@pobox.com>
In-Reply-To: <45841B20.9030402@pobox.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Alan wrote:
>>> I tracked it down to one of the drives being forced into PIO4 mode
>>> rather than UDMA mode; dmesg bits:
>>> ata4.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
>>> ata4.00: ata4: dev 0 multi count 16
>>> ata4.00: simplex DMA is claimed by other device, disabling DMA
>>
>> Your ULi controller is reporting that it supports UDMA upon only one
>> channel at a time. The kernel is honouring this information. The older
>> ULi (was ALi) PATA devices report simplex but let you turn it off so
>> see if the following does the trick. Test carefully as always with
>> disk driver
>> changes.
>>
>> (Jeff probably best to check the docs before merging this but I believe
>> it is sane)
>>
>> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> My Uli SATA docs do not appear to cover the bmdma registers :(  Only the
> PCI config registers.
> 
> But regardless, I think the better fix is to never set ATA_HOST_SIMPLEX
> if ATA_FLAG_NO_LEGACY is set.
> 
> None of the SATA controllers I've ever encountered has been simplex.

Just another data point.  The same problem is reported by bug #7590.

http://bugzilla.kernel.org/show_bug.cgi?id=7590

Is somebody brewing a patch?

-- 
tejun
