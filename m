Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUJVSCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUJVSCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUJVSCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:02:31 -0400
Received: from mail3.utc.com ([192.249.46.192]:739 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S267743AbUJVRo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:44:56 -0400
Message-ID: <41794709.1080404@cybsft.com>
Date: Fri, 22 Oct 2004 12:44:41 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>	 <20041021132717.GA29153@elte.hu>  <4177FADC.6030905@cybsft.com>	 <1098384016.27089.42.camel@thomas>  <41780687.8030408@cybsft.com>	 <1098385049.27089.51.camel@thomas>  <41791564.20200@cybsft.com>	 <1098456218.8955.373.camel@thomas>  <41792427.8020100@cybsft.com> <1098460673.8955.387.camel@thomas>
In-Reply-To: <1098460673.8955.387.camel@thomas>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2004-10-22 at 17:15, K.R. Foley wrote:
> 
>>Thomas Gleixner wrote:
>>
>>>On Fri, 2004-10-22 at 16:12, K.R. Foley wrote:
>>>
>>>
>>>>I am not sure why the tulip driver is being loaded,unloaded,reloaded 
>>>>every time on boot? Anyway, I wanted to check to see if I could generate 
>>>>the above bug on subsequent unloads of the module. I downed the network 
>>>>and the unloaded the tulip module. I did get the message below when 
>>>>unloading the module but no "BUG: atomic counter underflow" message.
>>>>
>>>>Oct 22 05:43:33 porky kernel: tulip 0000:04:0a.0: Device was removed 
>>>>without properly calling pci_disable_device(). This may need fixing.
>>>>Oct 22 05:43:33 porky net.agent[921]: remove event not handled
>>>
>>>
>>>Can you please verify this against vanilla 2.6.9 and 2.6.9-mm1 ?
>>>
>>>tglx
>>>
>>
>>I will verify it against 2.6.9 when I get time. I did verify the "Device 
>>was removed without properly calling pci_disable_device(). This may need 
>>fixing." message is generated with 2.6.9-rc3-mm3 without preempt 
>>patches. Also thanks to Mark Johnson's suggestion I verified that the 
>>reason the driver is being loaded twice is because kudzu is loading it 
>>once then unloading it.
>>
>>kr
> 
> 
> --- 2.6.9-rc4-mm1/drivers/net/tulip/tulip_core.c	2004-10-12
> 09:41:27.000000000 +0200
> +++ 2.6.9-rc4-mm1-U9-E0/drivers/net/tulip/tulip_core.c	2004-10-22
> 17:54:31.000000000 +0200
> @@ -1784,6 +1784,7 @@
>  #endif
>  	free_netdev (dev);
>  	pci_release_regions (pdev);
> +	pci_disable_device (pdev);
>  	pci_set_drvdata (pdev, NULL);
>  
>  	/* pci_power_off (pdev, -1); */
> 
> 
> 

This does fix this error:

porky kernel: tulip 0000:04:0a.0: Device was removed without properly 
calling pci_disable_device(). This may need fixing.

thanks,

kr
