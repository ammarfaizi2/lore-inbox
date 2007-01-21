Return-Path: <linux-kernel-owner+w=401wt.eu-S1751062AbXAUBui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbXAUBui (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 20:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXAUBui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 20:50:38 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:21751 "EHLO
	pd4mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbXAUBuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 20:50:37 -0500
Date: Sat, 20 Jan 2007 19:50:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <200701202332.58719.chunkeey@web.de>
To: Chr <chunkeey@web.de>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jeff Garzik <jeff@garzik.org>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Message-id: <45B2C6E1.9000901@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
 <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca>
 <200701202332.58719.chunkeey@web.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chr wrote:
>> Could you (or anyone else) test what happens if you take the 2.6.20-rc5
>> version of sata_nv.c and try it on 2.6.19? That would tell us whether
>> it's this change or whether it's something else (i.e. in libata core).
> 
> Ok, did that! (got a fresh 2.6.19 tar ball, and used 2.6.20-rc5' sata_nv.c
> with the oneliner in libata_sff.c)
> 
> And surprise.................... after one hour uptime, there is not even one 
> sata exceptions in dmesg! (I'll report back tomorrow...)

That is interesting, indeed.. If that holds up then I assume some other 
change in 2.6.20-rc is either causing or triggering this problem. It 
would be useful if you could try git bisect between 2.6.19 and 
2.6.20-rc5, keeping the latest sata_nv.c each time, and see if that 
gives any indication. If not, just trying some of the different 
2.6.20-rcX versions may be useful.

Before that, though, can you try making this change I suggested below in 
2.6.20-rc5 and see if the problem still shows up?

> 
>> Assuming that still doesn't work, can you then try removing these lines
>> from nv_host_intr in 2.6.20-rc5 sata_nv.c and see what that does?
>>
>> 	/* bail out if not our interrupt */
>> 	if (!(irq_stat & NV_INT_DEV))
>> 		return 0;
>>
>> as that's the difference I'm most suspicious of causing the problem.
> 
