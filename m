Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUCSTXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUCSTXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:23:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:45288 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263161AbUCSTXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:23:08 -0500
X-Authenticated: #4512188
Message-ID: <405B4893.70701@gmx.de>
Date: Fri, 19 Mar 2004 20:22:59 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Schlichter <thomas.schlichter@web.de>
CC: ross@datscreative.com.au, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
References: <200403181019.02636.ross@datscreative.com.au> <200403191955.38059.thomas.schlichter@web.de>
In-Reply-To: <200403191955.38059.thomas.schlichter@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > OK, now I had the time to test if different C states are working with
 > following three kernels:
 >
 > 1. 2.6.4-mm2 without the 8259-timer-ack-fix.patch and without the 
C1halt idle
 > function.
 > 2. 2.6.4-mm2 with the 8259-timer-ack-fix.patch and without the C1 
halt idle
 > function enabled.
 > 3. 2.6.4-mm2 with the 8259-timer-ack-fix.patch and with the C1 halt idle
 > function enabled.
 >
 > I used following script to print the C-state counters on an complete 
idle
 > machine before and after a 10second interval:
 >
 > # /bin/sh
 > cat /proc/acpi/processor/CPU0/power
 > sleep 10
 > cat /proc/acpi/processor/CPU0/power
 >
 > Now the results:

[snip]

> 3.:
> active state:            C1
> default state:           C1
> bus master activity:     00000000
> states:
>    *C1:                  promotion[C2] demotion[--] latency[000] 
> usage[00000000]
>     C2:                  promotion[--] demotion[C1] latency[100] 
> usage[00000000]
>     C3:                  <not supported>
> active state:            C1
> default state:           C1
> bus master activity:     00000000
> states:
>    *C1:                  promotion[C2] demotion[--] latency[000] 
> usage[00000000]
>     C2:                  promotion[--] demotion[C1] latency[100] 
> usage[00000000]
>     C3:                  <not supported>
> 
> So, as you can see, the C1halt patch does not help here... ;-(

Hmm, I just did a cat /proc/acpi/processor/CPU0/power:
active state:            C1
default state:           C1
bus master activity:     00000000
states:
    *C1:                  promotion[--] demotion[--] latency[000] 
usage[00000000]
     C2:                  <not supported>
     C3:                  <not supported>

I am currently NOT using APIC mode (nforce2, as well) and using vanilla 
2.6.4. It seems C1 halt state isn't used, which exlains why I am having 
trouble to keep my CPU cooler these day. I once started a thread 
suspecting acpi timer, but it is not the case. It seems to be something 
else. As I don't use PIC, it cannot be that  8259-timer-ack-fix.patch 
causin git, or can it? Maybe something broken in ACPI? I might try out 
older kernels to find out...

Prakash
