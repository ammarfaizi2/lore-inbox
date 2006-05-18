Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWERSGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWERSGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWERSGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:06:14 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:61825 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932109AbWERSGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:06:12 -0400
Message-ID: <446CB791.5030304@vc.cvut.cz>
Date: Thu, 18 May 2006 20:06:09 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: Konrad Rzeszutek <konradr@us.ibm.com>, linux-kernel@vger.kernel.org,
       konradr@redhat.com
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the
 e820 table.
References: <200605172153.35878.konradr@us.ibm.com> <446C70A8.5050909@linux.intel.com> <20060518155642.GC7617@andromeda.dapyr.net> <446CA4D3.80105@linux.intel.com>
In-Reply-To: <446CA4D3.80105@linux.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Konrad Rzeszutek wrote:
> 
>> That is definitely a problem - and the "sanity-check" can definitly bail
>> out on those BIOSes and not crash Linux. The other side of the coin is 
>> that BIOSes that do implement the MCFG/E820 correctly are penalized:
> 
> I hereby contest that it's implemented correctly if it's not marked 
> reserved...

PCI Firmware Specification 3.0 
(http://www.pcisig.com/members/downloads/specifications/conventional/pcifw_r3.0.pdf), 
page 42, notes for table 4-2, paragraph 2 says that firmware must report MCFG as 
reserved region.  Last sentence of same paragraph says that resources may be 
optionally marked reserved by E820 or EFIGetMemoryMap, but must be always 
reported as motherboard resources through ACPI  (for exact citation please see 
document itself, it is not freely available so I'm not going to copy-paste text 
from it without written permission from pcisig...).

So it seems to me that BIOS not reporting MMCONFIG as reserved through E820 is 
compliant, and what matters is that MMCONFIG must be reported as ACPI 
motherboard resource.
								Petr

