Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265424AbUFCBKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbUFCBKp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 21:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265428AbUFCBKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 21:10:44 -0400
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:48382 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S265424AbUFCBKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 21:10:42 -0400
Message-ID: <40BE7ABD.1050609@quark.didntduck.org>
Date: Wed, 02 Jun 2004 21:11:25 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: reg@dwf.com, linux-kernel@vger.kernel.org, reg@orion.dwf.com,
       linux@horizon.com
Subject: Re: Intel 875 Motherboard cant use 4GB of Memory.
References: <200406011956.i51JuYkD019999@orion.dwf.com> <Pine.LNX.4.53.0406020812440.2552@chaos>
In-Reply-To: <Pine.LNX.4.53.0406020812440.2552@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Tue, 1 Jun 2004 reg@dwf.com wrote:
> 
> 
>>>That could be PCI devices.  Some (particularly high-end video cards)
>>>take up a lot of address space, which comes straight out of the available
>>>4 GB physical address space.
>>>
>>>Check /proc/iomem.
>>>
>>
>>OK, that leaves me more confused, and (to me) it still looks like a
>>BIOS problem rather than a greedy device.  Here is the /proc/iomem
>>with some decimal annotations: (as noted, there is 4x1GB of memory installed)
>>
> 
> 
> 
> Not just Intel motherboards. There is 32 bits of address-space.
> This needs to be shared between RAM and the I/O addresses of
> PCI/Bus and AGP boards. Unfortunately, the PCI/AGP specification
> wastes a lot of address space because something that needs 1 megabyte
> of address-space must sit on a 1 megabyte boundary.  If this
> comes after something that used 128 bytes, there is nearly a megabyte
> wasted to get to the next boundary. A megabyte here a megabyte there..
> pretty soon you are talking about a lot of wasted address-space.
> 
> Solution: A 64 bit machine will have the same problem, you end up
> wasting RAM address space if it overlays PCI/Bus space. But, you
> probably would never opt for a gazzzilion bytes of RAM anyway?
> 
> 	One gazzzilion = 1844 6744 0737 0955 1615  (2 ^ 64)
> 
> Just don't put 4 gigs of RAM in a 4 gig address-space and expect
> to use it all. Sell the spare 2 gigs or build another PC with it!
> 

Wrong.  Ever since the Pentium Pro, x86 processors have had 36-bit 
*physical* addressing.  This is why PAE-mode paging was introduced.  A 
sane BIOS would configure the memory controller to remap some of the 
memory above 4G physical to allow for memory mapped devices.  It sounds 
like this board's BIOS isn't doing that, or at least not reporting it in 
the e820 map.

--
				Brian Gerst
