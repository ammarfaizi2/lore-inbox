Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUIJH5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUIJH5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUIJH5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:57:05 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17096 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266578AbUIJH4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:56:09 -0400
Date: Fri, 10 Sep 2004 16:58:07 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] missing pci_disable_device()
In-reply-to: <1094735472.14640.18.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <41415E8F.3000404@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <413D0E4E.1000200@jp.fujitsu.com>
 <1094550581.9150.8.camel@localhost.localdomain>
 <413E7925.1010801@jp.fujitsu.com>
 <1094647195.11723.5.camel@localhost.localdomain>
 <413FF05B.8090505@jp.fujitsu.com> <20040909062009.GD10428@kroah.com>
 <41403075.1010103@jp.fujitsu.com>
 <1094735472.14640.18.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Iau, 2004-09-09 at 11:29, Kenji Kaneshige wrote:
>> > 	dev_warn(&pci_dev->dev, "Device was removed without properly "
>> > 				"calling pci_disable_device(), please fix.\n");
>> > 	WARN_ON(1);
>> > 
> 
> "This may need fixing" would be better than "please fix" as it may be
> a wrong warning
>

Yes.
I should have considered drivers that intentionally don't disable
devices. I'll change the message.

 
>> I changed my patch based on your feedback. But I have one
>> concern about putting "WARN_ON(1);". I'm worrying that people
>> might be surprised if stack dump is shown on their console,
>> especially if the broken driver handles many devices.
> 
> You could put
> 
> #ifdef CONFIG_DEBUG_KERNEL
> 
> #endif
> 
> around that section, then only users selecting kernel debugging would
> be bothered by it.
> 

Thank you for advice.

But I don't know if we should take this approach, because
'CONFIG_DEBUG_KERNEL' is set by default on RedHat and some
other distros.

How do you think?

Thanks,
Kenji Kaneshige


