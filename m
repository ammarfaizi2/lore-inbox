Return-Path: <linux-kernel-owner+w=401wt.eu-S1751735AbXAUW0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbXAUW0a (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 17:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbXAUW0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 17:26:30 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24991 "EHLO
	pd4mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbXAUW03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 17:26:29 -0500
Date: Sun, 21 Jan 2007 16:26:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <20070121221126.GA2352@atjola.homenet>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Chr <chunkeey@web.de>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Message-id: <45B3E87F.4080400@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <45B18160.9020602@shaw.ca> <200701202332.58719.chunkeey@web.de>
 <45B2C6E1.9000901@shaw.ca> <45B2DF43.8080304@garzik.org>
 <20070121045437.GA7387@atjola.homenet> <45B30A98.3030206@shaw.ca>
 <20070121083618.GA2434@atjola.homenet> <20070121184032.GA3220@atjola.homenet>
 <45B3C5C9.4010007@shaw.ca> <20070121220811.GA2136@atjola.homenet>
 <20070121221126.GA2352@atjola.homenet>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink wrote:
> On 2007.01.21 23:08:11 +0100, Björn Steinbrink wrote:
>> On 2007.01.21 13:58:01 -0600, Robert Hancock wrote:
>>> Björn Steinbrink wrote:
>>>> All kernels were bad using that approach. So back to square 1. :/
>>>>
>>>> Björn
>>>>
>>> OK guys, here's a new patch to try against 2.6.20-rc5:
>>>
>>> Right now when switching between ADMA mode and legacy mode (i.e. when 
>>> going from doing normal DMA reads/writes to doing a FLUSH CACHE) we just 
>>> set the ADMA GO register bit appropriately and continue with no delay. 
>>> It looks like in some cases the controller doesn't respond to this 
>>> immediately, it takes some nanoseconds for the controller's status 
>>> registers to reflect the change that was made. It's possible that if we 
>>> were trying to issue commands during this time, the controller might not 
>>> react properly. This patch adds some code to wait for the status 
>>> register to change to the state we asked for before continuing.
>> I went for the "I feel lucky" route and did just add mmio reads after the
>> mmio writes, posting them. Rationale being that if it is a write posting
>> issue, the debug patch would/could actually hide it AFAICT.
>> It's the "I feel lucky" route, because my whole "knowledge" about mmio
>> and write posting originates from the few things I read up on when you
>> discovered the comment about write posting in the generic ata code.
> 
> Uhm, yeah, exception occured about the time that I hit "send".
> 
> Björn

Yeah, I don't think just adding reads to flush posted writes is enough 
here - it seems to need more delay than that, and it also wasn't always 
in the idle state even before we would write the register..

