Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUKSEJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUKSEJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 23:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUKSEJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 23:09:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40419 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261251AbUKSEJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 23:09:34 -0500
Message-ID: <419D71EF.9030508@pobox.com>
Date: Thu, 18 Nov 2004 23:09:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yasushi SHOJI <yashi@atmark-techno.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: readl/writel: swap or not to swap
References: <200411080521.iA85LbG6025914@hera.kernel.org>	<1099893447.10262.154.camel@gaston>	<200411081706.55261.adaplas@hotpop.com>	<Pine.LNX.4.58.0411080719460.24286@ppc970.osdl.org>	<20041113122003.0CA8A3E90C@dns1.atmark-techno.com> <20041119014829.DEE333E6F5@dns1.atmark-techno.com>
In-Reply-To: <20041119014829.DEE333E6F5@dns1.atmark-techno.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasushi SHOJI wrote:
> At Sat, 13 Nov 2004 21:20:03 +0900,
> yashi wrote:
> [...]
> 
>>>Why not just use __raw_readl/__raw_writel?
>>>
>>>That's what they exist for, and they still do any IO accesses correctly, 
>>>which a direct store does not do (it would seriously break on older 
>>>alphas, for example).
>>
>>sorry for a dumb question but should readl/writel on big endian system
>>swap like ppc does?
> 
> 
> I guess everyone is busy hacking.  but can at least someone give me a
> hit?
> 
> I'm worring about this issue because I'm about to use two deferent
> linux arch on same board.  it's based on reconfigurable device so I
> can configure to have deferent cpu on it.
> 
> if you are using two deferent arch of linux, it's natual to think you
> want to share all device drivers.  but if one arch swap with readl and
> the other doesn't, I have to abstruct these low level access
> methods. (given that those to arch are same endian and connected with
> same bus and to the same devices)
> 
> is there any rule we should follow?  Is the ppc way the right
> direction to follow? I can ifdef anytime for my own use but I just
> want to know what _should_ be done.


readl()/writel() are defined as being for the PCI bus (little endian). 
As such, they should swap on big endian platforms.

	Jeff


