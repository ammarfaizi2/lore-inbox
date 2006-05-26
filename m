Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWEZKbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWEZKbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWEZKbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:31:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5321 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751377AbWEZKbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:31:19 -0400
Message-ID: <4476D8E3.40101@garzik.org>
Date: Fri, 26 May 2006 06:30:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Ingo Oeser <netdev@axxeo.de>, Anton Blanchard <anton@samba.org>,
       Brice Goglin <brice@myri.com>, netdev@vger.kernel.org,
       gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
References: <20060517220218.GA13411@myri.com>	 <20060523153928.GB5938@krispykreme>	 <1148543810.13249.265.camel@localhost.localdomain>	 <200605261149.18415.netdev@axxeo.de> <1148637720.8089.145.camel@localhost.localdomain>
In-Reply-To: <1148637720.8089.145.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>> No proper interface exposed, he'll have to do an #ifdef powerpc here or
>>> such and use __ioremap with explicit page attributes. I have a hack to
>>> do that automatically for memory covered by prefetchable PCI BARs when
>>> mmap'ing from userland but not for kernel ioremap.
>> Stupid question: pci_iomap() is NOT what you are looking for, right?
>>
>> Implementation is at the end of lib/iomap.c
> 
> No, there is no difference there, pci_iomap won't help for passing in
> platform specific page attributes for things like write combining.

Since we already have ioremap_nocache(), maybe adding ioremap_wcomb() is 
appropriate?

	Jeff


