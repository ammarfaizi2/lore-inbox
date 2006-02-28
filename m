Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWB1Mbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWB1Mbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWB1Mbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:31:42 -0500
Received: from mail.dvmed.net ([216.237.124.58]:61061 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751751AbWB1Mbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:31:41 -0500
Message-ID: <440442A4.2090201@pobox.com>
Date: Tue, 28 Feb 2006 07:31:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pavel@ucw.cz, randy_d_dunlap@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>	<20060228114500.GA4057@elf.ucw.cz>	<44043B4E.30907@pobox.com> <20060228041817.6fc444d2.akpm@osdl.org>
In-Reply-To: <20060228041817.6fc444d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Fine-grained 
>> message selection allows one to turn on only the messages needed, and 
>> only for the controller desired.
> 
> 
> Except
> 
> - There's (presently) no way of making all the messages go away for a
>   non-debug build.

They aren't supposed to go away.


> - The code is structured as
> 
> 	if (ata_msg_foo(p))
> 		printk("something");
> 
>   So if we later do
> 
> 	#define ata_msg_foo(p)	0
> 
>   We'll still get copies of "something" in the kernel image (may be fixed
>   in later gcc, dunno).

We don't do that in net driver land, and I don't wish to do it for 
libata either.  Its just a bit test, that jumps over code if the message 
class isn't enabled (see link below).

We want users to be able to enable specific messages for specific 
controllers, without recompiling their kernel.

grep for msg_enable in various net drivers.  ethtool(8) is used to 
select specific controllers and messages to print.


> - The new debug stuff isn't documented.  One has funble around in the
>   source to work out how to even turn it on.  Can it be altered at runtime?
>   Dunno - the changelogs are risible.  What effect do the various flags
>   have?

The model has always been documented:
http://www.scyld.com/pipermail/vortex/2001-November/001426.html
(scroll down a tad)

	Jeff


