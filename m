Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVJUWPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVJUWPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 18:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbVJUWPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 18:15:16 -0400
Received: from magic.adaptec.com ([216.52.22.17]:51906 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965039AbVJUWPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 18:15:14 -0400
Message-ID: <43596859.3020801@adaptec.com>
Date: Fri, 21 Oct 2005 18:14:49 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com>
In-Reply-To: <43596070.3090902@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 22:14:54.0327 (UTC) FILETIME=[DD1BA870:01C5D68C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05 17:41, Jeff Garzik wrote:
>>>I already described why.  Examples are DMA boundary and s/g limit, among 
>>>others.  When confronted with this, you proposed an additional hardware 
>>>information struct which duplicates Scsi_Host_Template.
>>
>>
>>I told you -- I have this in the struct asd_ha_struct and it was merely
>>a downplay that I didn't include the same thing in struct sas_ha_struct.

Here is the commit in question:
http://linux.adaptec.com/sas/git/?p=linux-2.6-sas.git;a=commit;h=785747ddc631f7618d728a377346965f7db2256a

>>>Solution?  Just use Scsi_Host_Template.  Take a look at how each libata 
>>
>>
>>No, this is the solution which would turn everything upside down.
>>The easiest and smallest solution is to just include this tiny struct
>>and end this.  It would have 0 impact on code.  In fact I'll
>>implement it now and push it to the git tree. ;-)
>>
>>The host template _mixes_ hw, scsi core, and protocol knowlege into
>>one ugly blob.
> 
> 
> True.
> 
> If you do not like the current situation, evolve the SCSI core (and all 
> drivers) to where you think they should be.

While the architecture in my mind is clear, I cannot do this myself
(and for all drivers).  Such a change would be gradual, involving more
than one developer, for more than one (new) driver, etc.

First we need SDI to make everyone happy.  This way HP/LSI/Adaptec
can move quickest to the customers with minimal pain to the customers
and to the companies which would have to change software (minimal change).

> Thus, regardless of whether or not libata-scsi meets the needs of 
> SAS+SATA hardware, libata-scsi is where all SCSI<->ATA translation 
> should occur.  If you are dissatisfied, evolve the code to where it 
> needs to be.

Ok.

> Naming is completely irrelevant.  Just modify the code.

Ok.

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
