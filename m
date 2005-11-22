Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVKVQPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVKVQPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVKVQPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:15:01 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:24593 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964975AbVKVQPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:15:00 -0500
Message-ID: <43834400.3040506@argo.co.il>
Date: Tue, 22 Nov 2005 18:14:56 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org>
In-Reply-To: <20051122155143.GA30880@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 16:14:58.0828 (UTC) FILETIME=[E26804C0:01C5EF7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>On Tue, Nov 22, 2005 at 05:46:41PM +0200, Avi Kivity wrote:
>  
>
>>4) Write a translation layer (for xorg or the kernel) that can load 
>>Windows drivers. Use binary translation for non-x86. Hope the APIs are 
>>not patented.
>>    
>>
>
>Give up all hope of ever diagnosing or fixing a crash.
>
>Welcome to Windows instability, circa 1995.
>
>  
>
You exaggerate. Windows drivers work well enough in Windows (or so I 
presume). One just has to implement the environment these drivers 
expect, very carefully.

For the untrusting, options do remain:

- run the driver in userspace (if it's a xorg driver, in a separate 
process) so that all outputs can be validated
- use binary translation even on x86 and validate all memory and I/O 
accesses (like valgrind, but hopefully faster)

It's still possible for the driver to dma stuff where it shouldn't. 
Maybe IOMMU games (where available) can help. But I seriously doubt it 
will be that bad.

