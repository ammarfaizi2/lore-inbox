Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTL1BX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 20:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTL1BX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 20:23:29 -0500
Received: from agminet04.oracle.com ([141.146.126.231]:26601 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S264905AbTL1BXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 20:23:16 -0500
Message-ID: <3FEE30C9.7070805@oracle.com>
Date: Sun, 28 Dec 2003 02:24:25 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1 oops on boot (cpufreq related)
References: <3FEDEA78.1090301@oracle.com> <20031227163253.6f612adc.akpm@osdl.org>
In-Reply-To: <20031227163253.6f612adc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
> 
>>pufreq: CPU0 - ACPI performance management activated
>> cpufreq: *P0: 1Mhz, 0 mW, 0 uS
>> cpufreq:  P1: 0Mhz, 0 mW, 0 uS
>> divide error: 0000 [#1]
>> PREEMPT
>> CPU:   0
>> EIP:   0060:[<c02cb03f>]   Not tainted VLI
>> EFLAGS: 00010246
>> EIP is at cpufreq_notify_transition+0xb2/0x17a
>> eax: 001b1000   ebx: 001b1000   ecx: 00000000   edx: 00000000
>> esi: c1a37f70   edi: 00000000   ebp: 0000008b   esp: c1a37fa8
>> ds: 007b   es: 007b   ss:0068
>> Process swapper (pid: 1, threadinfo=c1a36000 task=f7f9f980)
>> Stack: ffffff00 c01164d9 00000060 00000086 f7dab860 f7dab800 0000008b c01156d3
>>         c1a37f70 00000001 c1a37f60 c037b940 00000000 00000086 f7dab860 00000064
>>         01000000 c037b8e0 c037d37e 00000000 00000000 00000001 00000000 c1a37fa8
>> Call Trace:
>>   [<c01164d9>] delay_tsc+0xb/0x15
>>   [<c01156d3>] acpi_processor_set_performance+0x1e0/0x3e6
>>   [<c04652c1>] acpi_cpufreq_init+0x243/0x2a3
>>   [<c045e6e6>] do_initcalls+0x27/0x93
>>   [<c012c9e7>] init_workqueues+0xf/0x28
>>   [<c01070bd>] init+0x30/0x133
>>   [<c010708d>] init+0x0/0x133
>>   [<c0108f59>] kernel_thread_helper+0x5/0xb
> 
> 
> hmm, I don't think there's much in the way of cpufreq changes in -mm.
> 
> Would you be able to try just 2.6.0 plus
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/acpi-20031203.patch
> 
> Thanks.

Of course :)

2.6.0 plus your above patch yields a very similar panic, though not
  100% identical.

* EIP is at the same place
* Call trace is missing delay_tsc, otherwise identical, offsets included
* First three blocks of the stack differ (all the rest looked identical)
* There is no "VLI" string after "Not Tainted" (I assume it's another
    part of the -mm1 patch)

So yup, you got the part that makes -mm1 unbootable here :)

Here's my ACPI options:

[asuardi@incident linux]$ grep -i acpi .config
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_SERIAL_8250_ACPI is not set

Available for any fiddling. Ah, holidays ;)


Thanks, ciao,

--alessandro

  "Immagina intensamente e vedrai
    dove gli altri pensano che non ci sia niente"
       (Cristina Dona', "Salti nell'aria")

