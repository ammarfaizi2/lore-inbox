Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUDNSg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUDNSg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:36:59 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:5373 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261358AbUDNSgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:36:55 -0400
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
From: john stultz <johnstul@us.ibm.com>
To: Niclas Gustafsson <niclas.gustafsson@codesense.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Patricia Gaughen <gone@us.ibm.com>
In-Reply-To: <1081932857.17234.37.camel@gmg.codesense.com>
References: <1081416100.6425.45.camel@gmg.codesense.com>
	 <1081465114.4705.4.camel@cog.beaverton.ibm.com>
	 <1081932857.17234.37.camel@gmg.codesense.com>
Content-Type: text/plain
Message-Id: <1081967804.4705.105.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Apr 2004 11:36:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 01:54, Niclas Gustafsson wrote:
> Now it happened again, with my newly compiled kernel, I've attached the
> config file and dmesg for this kernel.
> 
> Watching the /proc/interrupts with 10s apart after the "stop".
> 
> [root@s151 root]# more /proc/interrupts
>            CPU0
>   0:   66413955  local-APIC-edge  timer
>   2:          0          XT-PIC  cascade
>   9:          1   IO-APIC-level  acpi
>  10:          0   IO-APIC-level  ohci_hcd
>  14:         24    IO-APIC-edge  ide0
>  20:      31244   IO-APIC-level  aic7xxx
>  22:   19652139   IO-APIC-level  eth0
> NMI:          0
> LOC:   67379568
> ERR:          0
> MIS:          0
> 
> And some 10-15 min later:
> 
> [root@s151 root]# cat /proc/interrupts
>            CPU0
>   0:   66413964  local-APIC-edge  timer
>   2:          0          XT-PIC  cascade
>   9:          1   IO-APIC-level  acpi
>  10:          0   IO-APIC-level  ohci_hcd
>  14:         24    IO-APIC-edge  ide0
>  20:      31245   IO-APIC-level  aic7xxx
>  22:   19754446   IO-APIC-level  eth0
> NMI:          0
> LOC:   68366976
> ERR:          0
> MIS:          0

Wow, clearly something is going wrong with interrupt delivery. You only
received 9 timer interrupts in 10 seconds!

> Worth noticing is the extreme increase in interrupts and context
> switches on the last output line from vmstat, however if this is a true
> picture of what happened or not I cannot say. Maybe this is just a
> result of timing problems?
> 
> However I see an increase in network activity just before the stop, the
> system goes from 2 Mbps output to about 55 Mbps on the last read. (Also
> read from this machine so I don't know about it's validity)

Yea, those values are both junk as the X/sec ratio is totally skewed. 

> Where can I see what the system is currently using as a timing source
> (TSC/HPET/PIT etc.)?

Note the "Using tsc for high-res timesource" in your dmesg. 

I'm working now to reproduce this w/ a 2G system here in our lab, and
just for completeness, could you also send me your BIOS revision number?

thanks
-john


