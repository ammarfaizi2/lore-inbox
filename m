Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVJUVlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVJUVlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVJUVlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:41:16 -0400
Received: from mail.dvmed.net ([216.237.124.58]:26040 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751221AbVJUVlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:41:15 -0400
Message-ID: <43596070.3090902@pobox.com>
Date: Fri, 21 Oct 2005 17:41:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com>
In-Reply-To: <43595CA6.9010802@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 10/21/05 17:12, Jeff Garzik wrote:
> 
>>I already described why.  Examples are DMA boundary and s/g limit, among 
>>others.  When confronted with this, you proposed an additional hardware 
>>information struct which duplicates Scsi_Host_Template.
> 
> 
> I told you -- I have this in the struct asd_ha_struct and it was merely
> a downplay that I didn't include the same thing in struct sas_ha_struct.
> 
> 
>>Solution?  Just use Scsi_Host_Template.  Take a look at how each libata 
> 
> 
> No, this is the solution which would turn everything upside down.
> The easiest and smallest solution is to just include this tiny struct
> and end this.  It would have 0 impact on code.  In fact I'll
> implement it now and push it to the git tree. ;-)
> 
> The host template _mixes_ hw, scsi core, and protocol knowlege into
> one ugly blob.

True.

If you do not like the current situation, evolve the SCSI core (and all 
drivers) to where you think they should be.

The correct answer is NOT to duplicate information between 
Scsi_Host_Template and Lubens_Hardware_Struct.


>>driver is implemented.  The host template is in the low level driver, 
>>while most of the code is common code, implemented elsewhere.
> 
> 
> libata isn't without architectural problems.  What strikes me is
> that you think that libata-scsi is SATL.

The only things that matter are (a) what the code is now, and (b) what 
changes are needed to get where we need to be.

Thus, regardless of whether or not libata-scsi meets the needs of 
SAS+SATA hardware, libata-scsi is where all SCSI<->ATA translation 
should occur.  If you are dissatisfied, evolve the code to where it 
needs to be.


> You are so much better off renaming it to satl.c and given

Naming is completely irrelevant.  Just modify the code.

	Jeff


