Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWB1BdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWB1BdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWB1BdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:33:09 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:55821 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751900AbWB1BdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:33:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FolsMQMiih7FxQhs2XlUFlq656hS4ufOIYVmtrfQ3cAN1ecvY3E3OVc9Z+QMTmO++j1AfJRamt4Y/m1n/qVqYHXiSSHbU+/+dmKkhlmrQV47zzL9Jz0w5QU7JihCTEoAn/qGI8y/Tme0mqEk8ZfW1cRQkAqBFJyj3G6VtmYZio8=
Message-ID: <4403A84C.6010804@gmail.com>
Date: Tue, 28 Feb 2006 10:33:00 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Jeff Garzik <jgarzik@pobox.com>, David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca>
In-Reply-To: <4403704E.4090109@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mark.

Mark Lord wrote:
> 
> .. hold off on 2.6.16 because of this or not?
> 

It certainly is dangerous. I guess we should turn off FUA for the time 
being. Barrier auto-fallback was once implemented but it didn't seem 
like a good idea as it was too complex and hides low level bug from 
higher level. The concensus seems to be developing blacklist of drives 
which lie about FUA support (currently only one drive). Official kernel 
doesn't seem to be the correct place to grow the blacklist, Maybe we 
should do it from -mm?

>>
>> Well, no doubt whatsoever about it being a "regression",
>> since the FUA code is *new* in 2.6.16 (not present in 2.6.15).
>>
>> The FUA code should either get fixed, or removed from 2.6.16.
> 
> 
> Actually, now that I've done a little more digging, this FUA stuff
> is inherently dangerous as implemented.  A least a few SATA controllers
> including pipelines and whatnot that rely upon recognizing the (S)ATA
> opcodes being using.  And I sincerely doubt that any of those will
> recognize the very newish (and aptly named..) FUA opcodes.
> 
> These may be unsafe in general, unless we tag controllers as
> FUA-capable and NON-FUA-capable, in addition to tagging the drives.

All sii controllers and piix/ahci seem to handle FUA pretty ok. And 
yeah, we may have to create controller blacklist too.

BTW, can you let me know what drive we're talking about now (model name 
and firmware revision)?

-- 
tejun
