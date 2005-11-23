Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbVKWK1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVKWK1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 05:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVKWK1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 05:27:11 -0500
Received: from mailgate.tebibyte.org ([83.104.187.130]:19972 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S1030383AbVKWK06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 05:26:58 -0500
Message-ID: <438443E8.5040602@tebibyte.org>
Date: Wed, 23 Nov 2005 10:26:48 +0000
From: Chris Ross <lak1646@tebibyte.org>
Organization: At home (Guildford, UK)
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic reading bad disk sector
References: <4381DA23.10201@tebibyte.org> <4382B815.5000701@snapgear.com> <43836758.6050001@tebibyte.org> <4383C205.7020608@snapgear.com> <43843594.9050009@tebibyte.org> <20051123095640.GA5022@flint.arm.linux.org.uk>
In-Reply-To: <20051123095640.GA5022@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Russell King - ARM Linux escreveu:
> On Wed, Nov 23, 2005 at 09:25:40AM +0000, Chris Ross wrote:
>>Greg Ungerer escreveu:
>>>Chris Ross wrote:
>>>
>>>>According System.map it is in the function ide_dma_timeout_retry.
>>>
>>>Ok, that is good information. I would try and figure out which
>>>line of code in there is dereferencing a NULL pointer.
>>
>>It would seem to be this line
>>
>>	rq->errors = 0;

because rq is set to NULL by earlier the line

	ret = DRIVER(drive)->error(drive, "dma timeout retry",
				hwif->INB(IDE_STATUS_REG));


> I'd strongly suggest that you talk to IDE folk about this - I
> suspect HWGROUP(drive)->rq should never be NULL while a request
> is being handled on drive.

Which list specifically? I've taken your advice and "promoted" this to 
LKML so if that was wrong please correct it politely.

For those just tuning in this is about an ARM system with a Promise 
20275 IDE controller which suffers a kernel panic when attempting to 
read from a bad sector on the disk.

Regards,
Chris R.
