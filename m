Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVKAWrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVKAWrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVKAWrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:47:13 -0500
Received: from mail.gmx.de ([213.165.64.20]:55533 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751377AbVKAWrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:47:13 -0500
X-Authenticated: #527675
Message-ID: <4367F06D.2080405@gmx.de>
Date: Tue, 01 Nov 2005 23:47:09 +0100
From: Reinhard Nissl <rnissl@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: processor module locks up hyperthreading enabled machine
References: <88056F38E9E48644A0F562A38C64FB6005FDFBEA@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6005FDFBEA@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry for the delay. Here are the results:

Pallipadi, Venkatesh wrote:

> 1) Does this problem go way if you boot with maxcpus=1?

No.

The modules are loaded via initrd and SuSE prints the name of the module 
before loading it. So I get on console

Loading processor
ACPI: CPU0 (power states:C1[C1])
ACPI: CPU0 (power states:C1[C1])
Loading thermal
Loading fan
Waiting for device /dev/sda1 to appear: ok
Attempting manual resume
Loading jdb
Loading ext
Waiting for device /dev/sda2 to appear: ok
rootfs: major=8 minor=2 devn=2050

Then the system freezes.

Without the maxcpus argument the freeze happens already in front of the 
above "Loading thermal" line.

> 2) Does the problem go away if you not load the acpi processor module?

Yes.

When I remove processor (and thermal as it has a dependency on 
processor) to be loaded by initrd then the freeze happens at some time 
later when acpid gets started, as SuSE loads these modules at that time 
again in case they were not loaded already.

When I remove loading the processor (and thermal) module at this 
location too, then the system is running ok so far besides the 
restrictions which result from not loading these modules.

What should I try next?

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
