Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVAKDse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVAKDse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVAKDrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:47:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:56222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262412AbVAKDpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:45:46 -0500
Message-ID: <41E34A51.3080005@osdl.org>
Date: Mon, 10 Jan 2005 19:38:57 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@osdl.org>, Dave <dave.jiang@gmail.com>,
       linux-kernel@vger.kernel.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
References: <8746466a050110153479954fd2@mail.gmail.com> <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org> <41E31D95.50205@osdl.org> <Pine.LNX.4.58.0501101722200.2373@ppc970.osdl.org> <20050111020550.GE2696@holomorphy.com>
In-Reply-To: <20050111020550.GE2696@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Jan 10, 2005 at 05:30:25PM -0800, Linus Torvalds wrote:
> 
>>I don't think ioaddr_t needs to match resources. None of the IO accessor
>>functions take "u64"s anyway - and aren't likely to do so in the future
>>either - so "unsigned long" should be good enough.
>>Having u64 for resource handling is mainly an issue for RAM and
>>memory-mapped IO (right now the 32-bit limit means that we throw away
>>information about stuff above the 4GB mark from the e820 interfaces on
>>x86, for example - that _happens_ to work because we never see anything 
>>but RAM there anyway, but it means that /proc/iomem doesn't show all of 
>>the system RAM, and it does mean that our resource management doesn't 
>>actually handle 64-bit addresses correctly. 
>>See drivers/pci/probe.c for the result:
>>	"PCI: Unable to handle 64-bit address for device xxxx"
>>(and I do not actually think this has _ever_ happened in real life, which 
>>makes me suspect that Windows doesn't handle them either - but it 
>>inevitably will happen some day).
> 
> 
> I have a vague recollection of seeing a report of an ia32 device and/or
> machine with this property from John Fusco but am having a tough time
> searching the archives properly for it. I do recall it being around the
> time the remap_pfn_range() work was started, and I also claimed it as
> one of the motivators of it in one of my posts. I'm unaware of whether
> there are more general resources in John Fusco's situation.
> 
> My follow-ups began with:
> Message-ID: <20040924021735.GL9106@holomorphy.com>
> References: <41535AAE.6090700@yahoo.com>

http://marc.theaimsgroup.com/?l=linux-mm&m=109598180125156&w=2

-- 
~Randy
