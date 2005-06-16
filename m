Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVFPXtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVFPXtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVFPXtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 19:49:36 -0400
Received: from quark.didntduck.org ([69.55.226.66]:64709 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261841AbVFPXt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 19:49:27 -0400
Message-ID: <42B21002.7090502@didntduck.org>
Date: Thu, 16 Jun 2005 19:49:22 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Greg KH <gregkh@suse.de>, Rajesh Shah <rajesh.shah@intel.com>,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/04] PCI: use the MCFG table to properly access pci
 devices (x86-64)
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com> <20050616153404.B5337@unix-os.sc.intel.com> <20050616224223.GA13619@suse.de> <20050616230020.GM7048@bragg.suse.de>
In-Reply-To: <20050616230020.GM7048@bragg.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, Jun 16, 2005 at 03:42:23PM -0700, Greg KH wrote:
> 
>>On Thu, Jun 16, 2005 at 03:34:06PM -0700, Rajesh Shah wrote:
>>
>>>On Tue, Jun 14, 2005 at 10:32:14PM -0700, Greg KH wrote:
>>>
>>>>+	for (i = 0; i < pci_mmcfg_config_num; ++i) {
>>>>+		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
>>>>+		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
>>>
>>>This will map 256MB for each mmcfg aperture, probably better
>>>to restrict it based on bus number range for this aperture.
>>
>>It should be 1MB per bus number, right?
> 
> 
> It shouldn't make much difference anyways - we have plenty of vmalloc
> space on x86-64

What about excess page table usage?

--
				Brian Gerst
