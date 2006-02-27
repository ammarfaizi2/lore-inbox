Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWB0Si1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWB0Si1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWB0Si0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:38:26 -0500
Received: from mail.dvmed.net ([216.237.124.58]:39378 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751493AbWB0Si0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:38:26 -0500
Message-ID: <44034713.5080102@pobox.com>
Date: Mon, 27 Feb 2006 13:38:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pomac@vapor.com
CC: Stephen Hemminger <shemminger@osdl.org>, woho@woho.de,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert sky2 to 0.13a
References: <4400FC28.1060705@gmx.net> <200602270003.46353.woho@woho.de>	 <20060227080042.0cf3f05d@localhost.localdomain>	 <200602271738.38675.woho@woho.de>	 <20060227091837.3c214435@localhost.localdomain> <1141064841.23375.36.camel@localhost>
In-Reply-To: <1141064841.23375.36.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:
> On Mon, 2006-02-27 at 09:18 -0800, Stephen Hemminger wrote:
> 
>>On Mon, 27 Feb 2006 17:38:38 +0100
>>Wolfgang Hoffmann <woho@woho.de> wrote:
>>
>>>On Monday 27 February 2006 17:00, Stephen Hemminger wrote:
>>>2.6.16-rc5 with disable_msi=1 works for me, no hangs seen so far. I rsynced 80 
>>>GB of data, thats about 5-10 times more than I typically need to reproduce a 
>>>hang, so it seems to be solid. For the record: 2.6.16-rc5 with disable_msi=0 
>>>does hang.
>>>
>>>I have not seen the memory trashing others reported, with no version I tested 
>>>so far. Maybe my scenario is not likely to trigger this, so I can't tell.
>>>
>>>Unless a fix for msi is at hand, may I suggest for 2.6.16 to revert the msi 
>>>commit or switch the default to disable_msi=1?
>>>
>>>I've updated bugzilla #6084 accordingly.
>>
>>Okay, then what I need is lspci -v of all systems that have the problem, I'll make
>>a blacklist (or update PCI quirks). I suspect that MSI doesn't work for any devices
>>on these systems, or MSI changes the timing enough to expose existing races.
> 
> 
> Am i just tired from trying to make XSLT to do something unnatural or is
> there something odd going on in msi.c?
> 
> static void msi_set_mask_bit(unsigned int vector, int flag)
> {
>         struct msi_desc *entry;
> 
>         entry = (struct msi_desc *)msi_desc[vector];
>         if (!entry || !entry->dev || !entry->mask_base)
>                 return;
>         switch (entry->msi_attrib.type) {
>         case PCI_CAP_ID_MSI:
>         {
>                 int             pos;		<==
>                 u32             mask_bits;
> 
>                 pos = (long)entry->mask_base;	<==
> ...

Just from the casting it seems a bit bogus, yes...

	Jeff



