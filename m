Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWG0Ec0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWG0Ec0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 00:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWG0Ec0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 00:32:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:26028 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751271AbWG0EcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 00:32:25 -0400
Message-ID: <44C841B5.40806@tw.ibm.com>
Date: Thu, 27 Jul 2006 12:31:49 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, alan@redhat.com,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@enoyolf.org>
Subject: Re: libata pata_pdc2027x success on sparc64
References: <200607172358.k6HNwYhF002052@harpo.it.uu.se> <44BD2370.8090506@ru.mvista.com>
In-Reply-To: <44BD2370.8090506@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
> 
> Mikael Pettersson wrote:
> 
>> In contrast, the old IDE pdc202xx_new driver had lots
>> of problems with CRC errors causing it to disable DMA.
> 
> 
>    Hm, from my experience it usually falls back to UltraDMA/44 and then
> the thing startrt working...
> 
>> I wasn't able to manually tune it above udma3 without
>> getting more errors. This isn't sparc64-specific: I've
>> had similar negative experience with the old IDE Promise
>> drivers in a PowerMac.
> 
> 
>    This happens because the "old" driver misses the PLL calibration code.
>    You may want to try these Albert's patches:
> 
> http://marc.theaimsgroup.com/?t=110992452800002&r=1&w=2
> http://marc.theaimsgroup.com/?t=110992471500002&r=1&w=2
> http://marc.theaimsgroup.com/?t=110992490100002&r=1&w=2
> http://marc.theaimsgroup.com/?t=111019238400003&r=1&w=2
> 
>    It looks like they were never considered for accepting into the kernel
> while they succesfully solve this issue. Maybe Albert could try pushing
> them into -mm tree once more?
> 

Hi,

The libata version has three improvements compared to the IDE version.

1. The PLL calibration patches in the above URLs (for IDE)
still need more improvement as done in the pdc_read_counter()
of the libata version.

2. The Promise 2027x adapters check the "set features - xfer mode"
   and set the timing register automatically. However, the automatically
   set values are not correct under 133MHz. Libata has a hook
   pdc2027x_post_set_mode() to set the values back by software.

3. ATAPI DMA is supported (please see pdc2027x_check_atapi_dma()).
   Maybe we also need to add this to the IDE version.

Currently I have no time to update the IDE pdc202xx_new driver.
Also as Alan said, we have no maintainer for the IDE layer at this time.
So, if ok, please try to use the libata-based driver.

Thanks,

Albert




