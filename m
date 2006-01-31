Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWAaClg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWAaClg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 21:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWAaClg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 21:41:36 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:34613 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030276AbWAaClf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 21:41:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RrUa3ezXMCtgq/TIQvPxPxxeCckxDdZMZ0dSv51TOwXn28Hp5xnrRZC/95ZgsbY4y5rS/CKTo7vf+jbuDItki4N/zc4JX7cMiFejr4nDGdjBxAXjGmozb+BiY2Pq/xd29WKNliT/96xRiHAaTcUOPkvi8AuA7fzOmdyp+bJhFYw=
Message-ID: <43DECE55.7030308@gmail.com>
Date: Tue, 31 Jan 2006 11:41:25 +0900
From: Tejun <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
References: <20060128182522.GA31458@havoc.gtf.org> <200601302002.18962.ioe-lkml@rameria.de> <43DEA978.8000706@gmail.com> <200601310333.57518.ioe-lkml@rameria.de>
In-Reply-To: <200601310333.57518.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo.

Ingo Oeser wrote:
> Hi Tejun,
> 
> On Tuesday 31 January 2006 01:04, Tejun wrote:
> 
>>Ingo Oeser wrote:
>>
>>>What about putting the information directly into "ap->device[INDEX].class" 
>>>in the sole caller (ata_drive_probe_reset) so far?
>>>
>>
>>Not altering ->class directly in lldd driver is one major point of this 
>>whole patchset such that higher level driving logic has a say on whether 
>>a device is online or not, not the low level driver.  Primarily this is 
>>useful for sharing low-level codes with hot plugging / EH but it's also 
>>possible to retry some of the operations during probing in limited cases.
> 
> 
> Ok, with this argument, I finally get it. Now I know why you do it this
> way. You let the lld driver suggest a class for it's devices and verify
> these suggestions by high level code. 
> 
> The only way to get to this classification data is by resetting the ATA
> device.
> 
> It might be technically possible to set ->class directly and 
> fix it up in high level logic, as needed.

Yeap, that's right.  I actually considered that too but it was kind of 
messy that way - storing the current value, invoke callbacks, restoring 
values if something doesn't look right.  Just using temporary variable 
is much more straight-forward, it seemed.

> 
> Your explicit design decision was NOT to do this but to put this
> suggestions from low level driver into a temporary on stack structure
> from the higher level API.
> 
> And since the maintainer is happy already, I couldn't care less.
> 
> Thanks for your patience :-)

Great that we could reach an agreement.

Thanks. :-)

-- 
tejun
