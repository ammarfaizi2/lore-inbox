Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbSJCPs0>; Thu, 3 Oct 2002 11:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbSJCPs0>; Thu, 3 Oct 2002 11:48:26 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:17841 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261325AbSJCPsY>;
	Thu, 3 Oct 2002 11:48:24 -0400
Message-ID: <3D9C680F.5080705@colorfullife.com>
Date: Thu, 03 Oct 2002 17:53:51 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, alan@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.40-ac1
References: <3D9C5827.70703@colorfullife.com>	<20021003.075034.12648168.davem@redhat.com> 	<3D9C5FAE.60008@colorfullife.com> <1033660105.28814.11.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-10-03 at 16:18, Manfred Spraul wrote:
> 
>>There should bit nonatomic bit ops for every byte width.
>>
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=99167415926343&w=2
>>
>>I even sent you the patch proposal, but never got a reply.
>>
>>Patch again attached, but untested.
> 
> 
> What about reverse endianness ?

AFAIK, writeX macros should swap as needed, i.e.

	writel(0x100,ioaddr);

should arrive as bit 8 set on the hardware. [please correct me if I'm 
wrong] Thus the input into write{b,w,l} should be in host byte order.

	u{8,16,32}	array[];

	__set_bit_{8,16,32}(,array);

	write{b,w,l}(array[],ioaddr);

would achieve that.

