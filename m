Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWFBDAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWFBDAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWFBDAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:00:44 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:8669 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750756AbWFBDAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:00:44 -0400
Message-ID: <447FA920.9060509@jp.fujitsu.com>
Date: Fri, 02 Jun 2006 11:57:36 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com>
In-Reply-To: <20060601113625.A4043@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for replying late.

I understand that I had a woring assumption and I need to change my
patch. I'll post the fixed one as soon as possible.

As Rajesh pointed out, there are many drivers which initialize the
device with the wrong order. They should be fixed. I would like to
confirm the correct order to initialize the device again. Is the
following correct order?

    (1) pci_request_regions()

    (2) pci_enable_device()

    (3) request_irq()

    (4) free_irq()

    (5) pci_disable_device()

    (6) pci_release_regions()

Thanks,
Kenji Kaneshige


Rajesh Shah wrote:
> On Thu, Jun 01, 2006 at 11:15:59AM -0600, Grant Grundler wrote:
> 
>>+   The device driver needs to call pci_request_region() to make sure
>>+no other device is already using the same resource. The driver is expected
>>+to determine MMIO and IO Port resource availability _before_ calling
>>+pci_enable_device().  Conversely, drivers should call pci_release_region()
>>+_after_ calling pci_disable_device(). The idea is to prevent two devices
>>+colliding on the same address range.
>>+
> 
> A quick look in the drivers directory shows that _lots_ of drivers
> violate this rule. In fact, I suspect Kaneshige-san made the original
> incorrect assumption since there were so many drivers out there
> which do it in the wrong order.
> 
> Rajesh
> 

