Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWIENig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWIENig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWIENig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:38:36 -0400
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:22173 "EHLO
	smtp131.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S964943AbWIENif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:38:35 -0400
Message-ID: <44FD7DAE.7030705@gentoo.org>
Date: Tue, 05 Sep 2006 09:37:50 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
References: <1154091662.7200.9.camel@localhost.localdomain>	 <44DE5A6F.50500@gentoo.org> <1156906638.3022.18.camel@localhost.portugal>	 <44F50A0A.2040800@gentoo.org>	 <1156937128.2624.6.camel@localhost.localdomain>	 <44F5B933.2010608@gentoo.org> <1157024002.2724.4.camel@localhost.localdomain>
In-Reply-To: <1157024002.2724.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> On Wed, 2006-08-30 at 12:13 -0400, Daniel Drake wrote:
> 
>>> about Linus suggestion : 
>>> -	new_irq = dev->irq & 0xf;
>>> +	new_irq = dev->irq;
>>> +	if (!new_irq || new_irq >= 15)
>>> +		return;
>>>
>>> no, we have problem with VIA SATA controllers which have irq lower than
>>> 15 
>> Any chance you can provide a link to this example so that we can 
>> document the decision in the commit message?
> 
> http://lkml.org/lkml/2006/7/30/59

I'm confused. Heikki's report is about a sata_sil controller and he 
didn't include any dmesg output so I don't know how you can conclude 
that quirking an IRQ to something less than 15 was the fix...

Also note that the fix was *not* quirking the device at all (your patch 
ensured that the quirks didn't run because IO-APIC was enabled), this 
hardly seems like an accurate way of arguing that quirks that change the 
IRQ to something less than 15 are *required*...

Daniel


Daniel

