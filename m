Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWFQLZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWFQLZh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 07:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWFQLZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 07:25:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:35276 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751598AbWFQLZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 07:25:36 -0400
Message-ID: <4493E6A9.4080604@garzik.org>
Date: Sat, 17 Jun 2006 07:25:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Brice Goglin <brice@myri.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport
 capabilities
References: <4493709A.7050603@myri.com> <20060617062840.GD31645@kroah.com>
In-Reply-To: <20060617062840.GD31645@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jun 16, 2006 at 11:01:46PM -0400, Brice Goglin wrote:
>> Several chipsets are known to not support MSI. Some support MSI but
>> disable it by default. Thus, several drivers implement their own way to
>> detect whether MSI works.
>>
>> We introduce whitelisting of chipsets that are known to support MSI and
>> keep the existing backlisting to disable MSI for other chipsets. When it
>> is unknown whether the root chipset support MSI or not, we disable MSI
>> by default except if pci=forcemsi was passed.
>>
>> Whitelisting is done by setting a new PCI_BUS_FLAGS_MSI in the chipset
>> subordinate bus. pci_enable_msi() thus starts by checking whether the
>> root chipset of the device has the MSI or NOMSI flag set.
> 
> Whitelisting looks all well and good today, and maybe for the rest of
> the year.  But what about 3 years from now when everyone has shaken all
> of the MSI bugs out of their chipsets finally?  Do you really want to
> add a new quirk for _every_ new chipset that comes out?  I don't think
> that it is managable over the long run.
> 
> I do like your checks to see if MSI is able to be enabled or not, and
> maybe we can just invert them to mark those chips that do not support
> MSI today?

My gut feeling is:

blacklist -> any Intel machines which fail (most work)
blacklist -> any PCI Express which fails (most should work)
whitelist -> any other situation which works

Regards,

	Jeff



