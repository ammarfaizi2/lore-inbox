Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265286AbUFAXcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265286AbUFAXcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 19:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUFAXct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 19:32:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9359 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265286AbUFAXcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 19:32:46 -0400
Message-ID: <40BD1211.9030302@pobox.com>
Date: Tue, 01 Jun 2004 19:32:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com>
In-Reply-To: <40BC9EF7.4060502@shadowconnect.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Lidel wrote:
> Hello,
> 
> Jeff Garzik wrote:
> 
>>> could someone help me with a ioremap problem. If there are two 
>>> controllers plugged in, the ioremap request for the first controller 
>>> is successfull, but the second returns NULL. Here is the output of 
>>> the driver:
>>> i2o: Checking for PCI I2O controllers...
>>> i2o: I2O controller on bus 0 at 72.
>>> i2o: PCI I2O controller at 0xD0000000 size=134217728
>>> I2O: MTRR workaround for Intel i960 processor
>>> i2o/iop0: Installed at IRQ17
>>> i2o: I2O controller on bus 0 at 96.
>>> i2o: PCI I2O controller at 0xD8000000 size=134217728
>>> i2o: Unable to map controller.
>>
>> If "size=xxxx" indicates the size you are remapping, then that's
> 
> 
> Yep, it is...
> 
>> probably too large an area to be remapping.  Try remapping only the
>> memory area needed, and not the entire area.
> 
> 
> Is there a way, to increase the size, which could be remapped, or is 
> there a way, to find out what is the maximum size which could be remapped?

My preferred approach would be:  consider that the hardware does not 
need the entire 0x8000000-byte area mapped.  Plain and simple.

This is a "don't do that" situation, and that renders the other 
questions moot :)  You should only be mapping what you need to map.

	Jeff

