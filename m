Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWEYKQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWEYKQa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWEYKQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:16:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:44565 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965102AbWEYKQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:16:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=F3xt3RI5xbj1HfxAK0vUXsrw5Fj5oZ8SbL1E9F+p7NT1NrkrmdUND6kVwTqcikzwFoN6xFJudVNpHCz3imMq9B1YsdXBTX1MWyxfDk0VvUatGi4bQkNWio7rGTO5WzXvWU2hTjq1ilcBZBiYVLbQwJGzMbBWPV+BitnxWvEA+SI=
Message-ID: <447583FF.1000309@gmail.com>
Date: Thu, 25 May 2006 12:16:08 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
CC: Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz> <4474FFE1.4030202@garzik.org> <44758308.2040408@gmail.com>
In-Reply-To: <44758308.2040408@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):
> Jeff Garzik napsal(a):
>> Jiri Slaby wrote:
>>> +static int __init gt96100_probe1(struct pci_dev *pdev, int port_num)
>>>  {
>>>      struct gt96100_private *gp = NULL;
>>> -    struct gt96100_if_t *gtif = &gt96100_iflist[port_num];
>>> +    struct gt96100_if_t *gtifs = pci_get_drvdata(pdev);
>>> +    struct gt96100_if_t *gtif = &gtifs[port_num];
>>>      int phy_addr, phy_id1, phy_id2;
>>>      u32 phyAD;
>>> -    int retval;
>>> +    int retval = -ENOMEM;
>>>      unsigned char chip_rev;
>>>      struct net_device *dev = NULL;
>>>           if (gtif->irq < 0) {
>>> -        printk(KERN_ERR "%s: irq unknown - probing not supported\n",
>>> -              __FUNCTION__);
>>> +        dev_err(&pdev->dev, "irq unknown - probing not supported\n");
>>>          return -ENODEV;
>>>      }
>>> +
>>> +    retval = pci_enable_device(pdev);
>>> +    if (retval) {
>>> +        dev_err(&pdev->dev, "cannot enable pci device\n");
>>> +        return retval;
>>> +    }
>> bug #1:  please confirm pci_enable_device() is OK on this embedded hardware
> I do not understand too much, did you mean something like this:
> } else
> 	dev_info(..., "pci device is enabled now\n");
> or?
Or..., aha, I got it now. How can I confirm?

thnaks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
