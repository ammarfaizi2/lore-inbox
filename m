Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVJUWnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVJUWnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVJUWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 18:43:49 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51128 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965069AbVJUWns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 18:43:48 -0400
Message-ID: <43596F16.7000606@pobox.com>
Date: Fri, 21 Oct 2005 18:43:34 -0400
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
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com>
In-Reply-To: <43596859.3020801@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 10/21/05 17:41, Jeff Garzik wrote:
> 
>>>>I already described why.  Examples are DMA boundary and s/g limit, among 
>>>>others.  When confronted with this, you proposed an additional hardware 
>>>>information struct which duplicates Scsi_Host_Template.
>>>
>>>
>>>I told you -- I have this in the struct asd_ha_struct and it was merely
>>>a downplay that I didn't include the same thing in struct sas_ha_struct.
> 
> 
> Here is the commit in question:
> http://linux.adaptec.com/sas/git/?p=linux-2.6-sas.git;a=commit;h=785747ddc631f7618d728a377346965f7db2256a

This effectively illustrates the wrong thing to do:  duplicating 
information that's already in Scsi_Host_Template.

Just use Scsi_Host_Template in the LLDD and see where that goes.


>>>>Solution?  Just use Scsi_Host_Template.  Take a look at how each libata 
>>>
>>>
>>>No, this is the solution which would turn everything upside down.
>>>The easiest and smallest solution is to just include this tiny struct
>>>and end this.  It would have 0 impact on code.  In fact I'll
>>>implement it now and push it to the git tree. ;-)
>>>
>>>The host template _mixes_ hw, scsi core, and protocol knowlege into
>>>one ugly blob.
>>
>>
>>True.
>>
>>If you do not like the current situation, evolve the SCSI core (and all 
>>drivers) to where you think they should be.
> 
> 
> While the architecture in my mind is clear, I cannot do this myself
> (and for all drivers).  Such a change would be gradual, involving more
> than one developer, for more than one (new) driver, etc.

Correct.  That's why there is resistance to aic94xx's approach of 
creating a totally new "strict SAM" path, existing in parallel with the 
traditional SCSI core.  You need to evolve the existing code to get 
there.  Such changes are gradual, involving more than one developer, etc.

We don't need one small set of SCSI drivers behaving differently from 
the vast majority of existing SCSI drivers.

Hear me now, and believe me later:  we all largely agree on the points 
you've raised about legacy crapola in the SCSI core.  James, Christoph, 
myself, and several others disagree with your assertion that the old 
SCSI core should exist in parallel with your new SCSI core.

We differ on the path, not the goal.  As a thought experiment, you could 
try simply implementing the changes requested, and see where that goes.

	Jeff


