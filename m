Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWCCUaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWCCUaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWCCUaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:30:13 -0500
Received: from mail.dvmed.net ([216.237.124.58]:58769 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932351AbWCCUaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:30:11 -0500
Message-ID: <4408A74B.30306@garzik.org>
Date: Fri, 03 Mar 2006 15:30:03 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Steve Byan <smb@egenera.com>, Mark Lord <lkml@rtr.ca>,
       Matthias Andree <matthias.andree@gmx.de>,
       Douglas Gilbert <dougg@torque.net>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org> <4405E8AA.1090803@rtr.ca> <Pine.LNX.4.64.0603011036110.22647@g5.osdl.org> <CF493E39-B369-46D8-85EE-013F2484F1C6@egenera.com> <Pine.LNX.4.64.0603031035140.22647@g5.osdl.org> <44089C34.2030604@garzik.org> <Pine.LNX.4.64.0603031204370.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603031204370.22647@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 3 Mar 2006, Jeff Garzik wrote:
> 
>>256 max sectors IDE driver, 200 max sectors libata (due to driver not
>>hardware).
> 
> 
> When I said "lower due to broken hw" I was more thinking about things like 
> the SiIimage driver, which actually limits the rqsize to 15 sectors due to 
> some strange hw interactions with seagate SATA devices.

Yep.  There's trouble if the last FIS (sata packet, max 8K) is exactly 7.5K.


> (It will then raise it back up to 128 if it's not a Seagate SATA drive. I 
> forget what the exact issue was. Some strange corruption in some limited 
> case, and not allowing big requests worked around it. There's some 
> strange IDE quirks out there...).

Technically its

	if (sectors % 15 == 1)
		explode

:)  Yes, IDE is a weird weird world...

	Jeff


