Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVAKCJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVAKCJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVAKCGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:06:50 -0500
Received: from holomorphy.com ([207.189.100.168]:28302 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262608AbVAKCGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:06:02 -0500
Date: Mon, 10 Jan 2005 18:05:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Dave <dave.jiang@gmail.com>,
       linux-kernel@vger.kernel.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
Message-ID: <20050111020550.GE2696@holomorphy.com>
References: <8746466a050110153479954fd2@mail.gmail.com> <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org> <41E31D95.50205@osdl.org> <Pine.LNX.4.58.0501101722200.2373@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501101722200.2373@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:30:25PM -0800, Linus Torvalds wrote:
> I don't think ioaddr_t needs to match resources. None of the IO accessor
> functions take "u64"s anyway - and aren't likely to do so in the future
> either - so "unsigned long" should be good enough.
> Having u64 for resource handling is mainly an issue for RAM and
> memory-mapped IO (right now the 32-bit limit means that we throw away
> information about stuff above the 4GB mark from the e820 interfaces on
> x86, for example - that _happens_ to work because we never see anything 
> but RAM there anyway, but it means that /proc/iomem doesn't show all of 
> the system RAM, and it does mean that our resource management doesn't 
> actually handle 64-bit addresses correctly. 
> See drivers/pci/probe.c for the result:
> 	"PCI: Unable to handle 64-bit address for device xxxx"
> (and I do not actually think this has _ever_ happened in real life, which 
> makes me suspect that Windows doesn't handle them either - but it 
> inevitably will happen some day).

I have a vague recollection of seeing a report of an ia32 device and/or
machine with this property from John Fusco but am having a tough time
searching the archives properly for it. I do recall it being around the
time the remap_pfn_range() work was started, and I also claimed it as
one of the motivators of it in one of my posts. I'm unaware of whether
there are more general resources in John Fusco's situation.

My follow-ups began with:
Message-ID: <20040924021735.GL9106@holomorphy.com>
References: <41535AAE.6090700@yahoo.com>



-- wli
