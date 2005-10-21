Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbVJUVZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVJUVZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVJUVZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:25:03 -0400
Received: from magic.adaptec.com ([216.52.22.17]:952 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751150AbVJUVZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:25:01 -0400
Message-ID: <43595CA6.9010802@adaptec.com>
Date: Fri, 21 Oct 2005 17:24:54 -0400
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
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com>
In-Reply-To: <435959BE.5040101@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 21:24:59.0251 (UTC) FILETIME=[E3E75430:01C5D685]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05 17:12, Jeff Garzik wrote:
> 
> I already described why.  Examples are DMA boundary and s/g limit, among 
> others.  When confronted with this, you proposed an additional hardware 
> information struct which duplicates Scsi_Host_Template.

I told you -- I have this in the struct asd_ha_struct and it was merely
a downplay that I didn't include the same thing in struct sas_ha_struct.

> Solution?  Just use Scsi_Host_Template.  Take a look at how each libata 

No, this is the solution which would turn everything upside down.
The easiest and smallest solution is to just include this tiny struct
and end this.  It would have 0 impact on code.  In fact I'll
implement it now and push it to the git tree. ;-)

The host template _mixes_ hw, scsi core, and protocol knowlege into
one ugly blob.  I've given this argument before, several times.

> driver is implemented.  The host template is in the low level driver, 
> while most of the code is common code, implemented elsewhere.

libata isn't without architectural problems.  What strikes me is
that you think that libata-scsi is SATL.

You are so much better off renaming it to satl.c and given
the knowlege you've gained over the years and the backing you have
from engineers from companies, start with it at device level.  I, as
I'm sure other (not to name names) will be more than happy to contribute
if you started this.

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
