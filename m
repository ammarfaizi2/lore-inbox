Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWEYKU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWEYKU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWEYKU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:20:28 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24479 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965103AbWEYKU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:20:27 -0400
Message-ID: <447584E8.6050903@garzik.org>
Date: Thu, 25 May 2006 06:20:24 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz> <4474FFE1.4030202@garzik.org> <44758308.2040408@gmail.com> <447583FF.1000309@gmail.com>
In-Reply-To: <447583FF.1000309@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Jiri Slaby napsal(a):
>> Jeff Garzik napsal(a):
>>> Jiri Slaby wrote:
>>>> +static int __init gt96100_probe1(struct pci_dev *pdev, int port_num)
>>>>  {
>>>>      struct gt96100_private *gp = NULL;
>>>> -    struct gt96100_if_t *gtif = &gt96100_iflist[port_num];
>>>> +    struct gt96100_if_t *gtifs = pci_get_drvdata(pdev);
>>>> +    struct gt96100_if_t *gtif = &gtifs[port_num];
>>>>      int phy_addr, phy_id1, phy_id2;
>>>>      u32 phyAD;
>>>> -    int retval;
>>>> +    int retval = -ENOMEM;
>>>>      unsigned char chip_rev;
>>>>      struct net_device *dev = NULL;
>>>>           if (gtif->irq < 0) {
>>>> -        printk(KERN_ERR "%s: irq unknown - probing not supported\n",
>>>> -              __FUNCTION__);
>>>> +        dev_err(&pdev->dev, "irq unknown - probing not supported\n");
>>>>          return -ENODEV;
>>>>      }
>>>> +
>>>> +    retval = pci_enable_device(pdev);
>>>> +    if (retval) {
>>>> +        dev_err(&pdev->dev, "cannot enable pci device\n");
>>>> +        return retval;
>>>> +    }
>>> bug #1:  please confirm pci_enable_device() is OK on this embedded hardware
>> I do not understand too much, did you mean something like this:
>> } else
>> 	dev_info(..., "pci device is enabled now\n");
>> or?
> Or..., aha, I got it now. How can I confirm?

Asking the maintainer would be a good first step.

	Jeff


