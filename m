Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271042AbTHLTpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 15:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271073AbTHLTpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 15:45:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41670 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271042AbTHLTpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 15:45:20 -0400
Message-ID: <3F3943B8.1040404@pobox.com>
Date: Tue, 12 Aug 2003 15:44:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: Re: Updated MSI Patches
References: <7F740D512C7C1046AB53446D3720017304AE94@scsmsx402.sc.intel.com> <3F393697.8000508@pobox.com> <Pine.LNX.4.53.0308121512040.2373@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.53.0308121512040.2373@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Tue, 12 Aug 2003, Jeff Garzik wrote:
> 
> 
>>So, IMO, do_IRQ is one special case where copying code may be preferred 
>>over common code.
>>
>>And I also feel the same way about do_MSI().  However, I have not looked 
>>at non-ia32 MSI implementations to know what sort of issues exist.
> 
> 
> The main reason i have a preference for a seperate MSI handling path is so 
> that we don't have to do the platform_irq thing in do_IRQ and we know 
> what to expect wrt irq or vector. If platform_irq stays we should at 
> least try and pick up on what the IA64 folks have done, But that would be 
> even harder to get done right now.


Oh, I definitely prefer a separate MSI handling path too.

In the future we'll be writing drivers that _require_ MSI interrupt 
handling, and we'll be optimizing the various MSI hot paths to reclaim 
even the most minute amount of CPU cycles.  And we want to escape any 
shackles the evil phrase "legacy interrupts" dares to try to lay upon us.

But there is a flip side to that:  do_IRQ is not solely hardware 
interrupts.  That area of code is central dispatcher for 
softirq/tasklet/timer delivery as well.  So a separate do_MSI() needs to 
take that stuff into account.

Overall, I'm pretty happy with how Tom's MSI patches are going so far, 
and he seems to be responding to feedback.  So, we'll get there.

	Jeff



