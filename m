Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbTLFUFr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 15:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbTLFUFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 15:05:47 -0500
Received: from stinkfoot.org ([65.75.25.34]:17044 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S265241AbTLFUFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 15:05:43 -0500
Message-ID: <3FD23745.3040603@stinkfoot.org>
Date: Sat, 06 Dec 2003 15:08:37 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: colin@coesta.com
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>    <20031206024251.GG8039@holomorphy.com>    <3FD14396.5070205@cyberone.com.au>    <20031206030755.GI8039@holomorphy.com> <3704.192.168.1.3.1070694142.squirrel@www.coesta.com>
In-Reply-To: <3704.192.168.1.3.1070694142.squirrel@www.coesta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Coe wrote:
> Sorry about the delay.
> 
> Booted with noirqbalance.
> 
> [root@host root]# cat /proc/interrupts
>            CPU0       CPU1
>   0:    7411777    5971987    IO-APIC-edge  timer
>   1:          7          4    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   4:         16         42    IO-APIC-edge  serial
>   5:       4915       4820   IO-APIC-level  eth1
>  10:         67         69   IO-APIC-level  aic7xxx
>  11:        325        266   IO-APIC-level  eth0
>  12:         47        109    IO-APIC-edge  i8042
>  14:          0          0   IO-APIC-level  CS46XX
>  15:       6398       6401   IO-APIC-level  megaraid
> NMI:          0          0
> LOC:   13383659   13383658
> ERR:          0
> MIS:          0
> 
> That looks a lot better...
> 
> Thanks!
> 
> --
> "Obnoxious frog..." Spike, 2071AD
> 
> William Lee Irwin III said:
> 
>>On Sat, Dec 06, 2003 at 01:48:54PM +1100, Nick Piggin wrote:
>>
>>>Although in this case Colin has 2 PPro 200s.
>>>Colin - process load should be evenly distributed between CPUs, and this
>>>is generally the most important thing. Big networking loads (most
>>>commonly)
>>>can put a lot of time into processing interrupts though.
>>
>>That is rather busted, then.
>>
>>Colin, could you try booting with noirqbalance on the kernel command
>>line?
>>
>>
>>-- wli
>>
> 

I'll throw my hat in here as well.  This is an old compaq proliant I 
have at the office- dual 400 PII, booted with "noirqbalance" 2.6.0-test11:

            CPU0       CPU1
   0:    2580383    1920931    IO-APIC-edge  timer
   1:          6          3    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   5:        467        423   IO-APIC-level  TLAN
   8:          1          0    IO-APIC-edge  rtc
   9:         15         15   IO-APIC-level  sym53c8xx
  10:         17         17   IO-APIC-level  sym53c8xx
  11:       1602       1593   IO-APIC-level  ida0
  14:          8          2    IO-APIC-edge  ide0
NMI:          0          0
LOC:    4501366    4501354
ERR:          0
MIS:          0

witout "noirqbalance" we interrupt on CPU0 solely.

-E
