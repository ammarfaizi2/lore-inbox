Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424137AbWKIWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424137AbWKIWOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161863AbWKIWOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:14:35 -0500
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:32217 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1161862AbWKIWOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:14:35 -0500
Message-ID: <4553A84B.9050706@atipa.com>
Date: Thu, 09 Nov 2006 16:14:35 -0600
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com> <45539699.40105@scientia.net> <45539753.7060906@atipa.com> <4553A461.4080002@scientia.net> <4553A57C.5070503@atipa.com> <4553A6C9.4010906@scientia.net>
In-Reply-To: <4553A6C9.4010906@scientia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 22:15:33.0156 (UTC) FILETIME=[92E07E40:01C7044C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:
> Roger Heflin wrote:
>> The mc part does pci parity, it is separate from the
>> chipset driver,
> What? I thought the MC part does ECC and the pci part the parity stuff?
> 

mc does pci parity all by itself, it is also the main module
holding the ecc stuff together, but you get no ecc without the
chipset/cpu specific module.

>> I have even used the _mc part on a
>> Itanium with no chipset driver at all and had it report
>> parity errors properly, so I expect just the mc driver
>> to work.
>>
>> You would need the k8 module for the cpu, but that is
>> only if you want ECC checking also.
>>   
> Where do I get this only when patching from CVS?

I don't know the status is of the k8 modules, some
distro kernels include it, I don't know if vanilla has
it yet.

mcelog should also report ecc errors, but you would need
to be running the mcelog userspace program every so often
to realize that errors where happening.

> 
>> If you got the _mc loaded do a "sysctl -a | grep mc" and
>> see what things are set how, and reset if necessary
>> check_pci_parity to 1.
> Well ok,.. module is loaded now:
> I've set check_pci_parity to 1 everything else is 0 in sysfs...
> 
> 
> # sysctl -a | grep mc
> error: "Operation not permitted" reading key "net.ipv6.route.flush"
> net.ipv6.neigh.eth1.mcast_solicit = 3
> net.ipv6.neigh.eth0.mcast_solicit = 3
> net.ipv6.neigh.lo.mcast_solicit = 3
> net.ipv6.neigh.default.mcast_solicit = 3
> net.ipv4.conf.ppp0.mc_forwarding = 0
> net.ipv4.conf.eth1.mc_forwarding = 0
> net.ipv4.conf.eth0.mc_forwarding = 0
> net.ipv4.conf.lo.mc_forwarding = 0
> net.ipv4.conf.default.mc_forwarding = 0
> net.ipv4.conf.all.mc_forwarding = 0
> net.ipv4.neigh.ppp0.mcast_solicit = 3
> net.ipv4.neigh.eth1.mcast_solicit = 3
> net.ipv4.neigh.eth0.mcast_solicit = 3
> net.ipv4.neigh.lo.mcast_solicit = 3
> net.ipv4.neigh.default.mcast_solicit = 3
> error: "Operation not permitted" reading key "net.ipv4.route.flush"
> error: "Invalid argument" reading key "fs.binfmt_misc.register"
> 
> 
> But this has nothing to do with edac, has it?
> 
> And I've already had diff errors again,..
> so if there had been some parity issue it should have been logged, right?

The names and locations may have change, I am more
familiar with the older versions that had the sysctl stuff
in them, the new parts may not have the sysctl stuff,
but if you make the adjustment with the /sys filesystem,
that should work just fine.

                        Roger
