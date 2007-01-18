Return-Path: <linux-kernel-owner+w=401wt.eu-S932758AbXARXlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbXARXlP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 18:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbXARXlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 18:41:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58660 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758AbXARXlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 18:41:15 -0500
Message-ID: <45B00588.3010207@zytor.com>
Date: Thu, 18 Jan 2007 15:40:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alexey Dobriyan <adobriyan@openvz.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       devel@vger.kernel.org
Subject: Re: [PATCH] rdmsr_on_cpu, wrmsr_on_cpu
References: <20070118144527.GA6021@localhost.sw.ru> <45AFF12D.2070901@zytor.com> <200701191021.16706.ak@suse.de>
In-Reply-To: <200701191021.16706.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> HOWEVER -- and this is where things get gnarly -- the CPUID and MSR
>> drivers would really like to be able to execute CPUID, WRMSR and RDMSR
>> with the entire GPR register set (except the stack pointer) pre-set and
>> post-captured, since it's highly likely that there are going to be
>> nonstandard MSRs and CPUID levels (already witness Intel breaking the
>> CPUID architecture by introducing %ecx dependencies.)
> 
> That looks like such a specialized requirement that I would suggest 
> you keep that in the drivers. The interface for most users would be just
> too ugly
> 

It would, but rather than having the paravirtualization interfaces 
duplicate out of control, we could/should implement the less generic 
features in terms of the more generic, above the pvz layer.

	-hpa
