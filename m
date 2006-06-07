Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWFGNOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWFGNOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 09:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWFGNOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 09:14:35 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17309 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750799AbWFGNOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 09:14:34 -0400
Message-ID: <4486D070.2020806@jp.fujitsu.com>
Date: Wed, 07 Jun 2006 22:11:12 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 4/4] Make Emulex lpfc driver legacy I/O port free
References: <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644D6.9030907@jp.fujitsu.com> <20060607082448.GA31004@infradead.org> <4486C537.9040105@jp.fujitsu.com> <20060607124353.GA31777@infradead.org>
In-Reply-To: <20060607124353.GA31777@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Jun 07, 2006 at 09:23:19PM +0900, Kenji Kaneshige wrote:
> 
>>No. Your idea is very similar to the idea of previous version of my patche
>>which had a bug. The problem is that it doesn't work if 
>>pci_request_regions()
>>is called before pci_enable_device*() (This is the correct order, though so
>>many drivers breaks this rule).
> 
> 
> Doesn't matter.  Drivers not using pci_enable_device_noioport should be
> unaffect.  Any any driver you convert should be fixed to do thing in
> the right order.
> 
> 

I mean the right order is

    (1) pci_request_regions()
    (2) pci_enable_device*()

So there are no chance to set the flag for pci_request_regions() to
know which regions should be requested.

Thanks,
Kenji Kaneshige
