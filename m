Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWJTR7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWJTR7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWJTR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:59:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:9135 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030310AbWJTR7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:59:33 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,336,1157353200"; 
   d="scan'208"; a="149600490:sNHT19955257"
Message-ID: <45390E09.7050508@intel.com>
Date: Fri, 20 Oct 2006 10:57:29 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Ryan Richter <ryan@tau.solarneutrino.net>
CC: Aleksey Gorelov <dared1st@yahoo.com>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
References: <20061017180003.GB24789@tau.solarneutrino.net> <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com> <20061017222727.GB24891@tau.solarneutrino.net>
In-Reply-To: <20061017222727.GB24891@tau.solarneutrino.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2006 17:59:32.0562 (UTC) FILETIME=[7EFCDB20:01C6F471]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
> On Tue, Oct 17, 2006 at 01:53:15PM -0700, Aleksey Gorelov wrote:
>>
>> --- Ryan Richter <ryan@tau.solarneutrino.net> wrote:
>>> 2.6.19-rc1-git9 doesn't work any better for me.  I haven't tried
>>> unloading the e1000 module yet.  Since I run the machine off an nfsroot,
>>> it will require some creativity to test that.
>>>
>>> -ryan
>> You may try the following patch instead if it's easier for you. It'll
>> likely break suspend stuff,
>> but you won't need to play around with modules.
>>
>> Aleks.
>>
>> --- linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c.orig	2006-10-17 13:36:06.000000000 -0700
>> +++ linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c	2006-10-17 13:36:50.000000000 -0700
>> @@ -4847,6 +4847,7 @@
>>  static void e1000_shutdown(struct pci_dev *pdev)
>>  {
>>  	e1000_suspend(pdev, PMSG_SUSPEND);
>> +	pci_set_power_state(pdev, PCI_D0);
>>  }
>>  
>>  #ifdef CONFIG_NET_POLL_CONTROLLER
> 
> 
> This patch allows the machine to reboot normally.

To all that are seeing this problem:

can you send me (off-list is OK) the motherboard number+name, the BIOS versions (+ where 
you downloaded them from) that you have tried and for each version, whether it worked 
without this workaround or not?

Thanks,

Auke

