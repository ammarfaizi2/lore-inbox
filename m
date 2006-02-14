Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWBNUqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWBNUqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWBNUqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:46:31 -0500
Received: from rtr.ca ([64.26.128.89]:18072 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161075AbWBNUqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:46:30 -0500
Message-ID: <43F2419E.9060308@rtr.ca>
Date: Tue, 14 Feb 2006 15:46:22 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add cast to __iomem pointer in scsi drivers
References: <s5hzmktaecj.wl%tiwai@suse.de>	<Pine.LNX.4.61.0602141530420.32364@chaos.analogic.com> <s5hu0b1ad2o.wl%tiwai@suse.de>
In-Reply-To: <s5hu0b1ad2o.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Tue, 14 Feb 2006 15:35:29 -0500,
> linux-os (Dick Johnson) wrote:
>>
>> On Tue, 14 Feb 2006, Takashi Iwai wrote:
>>
>>> Add the missing cast to __iomem pointer in some scsi drivers.
..
>>> -#define WROUTDOOR(adapter,value)	writel(value, (adapter)->base + 0x2C)
...
>>> +#define WROUTDOOR(adapter,value)	writel(value, (void __iomem *)((adapter)->base + 0x2C))
..
>> With all these casts, doesn't it point out that something is wrong
>> with writel(), writew(), readl(), and readw() ??? The cast's to
>> volatile types should be within the macros, not scattered
>> throughout everyone's driver code!
> 
> The patch is just for fixing compile warnings.
> 
> readl(), writel() and co are inline functions, and they should be cast
> explicitly on the caller side.

I think Linus's intent when he added the __iomem "feature", was that code
should change the underlying data declarations to match.  So rather than
casting things left and right, and defeating compiler diagnostics by doing so,
perhaps the actual data type for "base" et al. should get changed to match.

Cheers
