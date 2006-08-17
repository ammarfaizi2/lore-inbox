Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWHQOOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWHQOOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWHQOOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:14:04 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:33218 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S965013AbWHQOOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:14:03 -0400
Message-ID: <44E479FB.7030505@acm.org>
Date: Thu, 17 Aug 2006 09:15:23 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>
CC: Matt Domsch <Matt_Domsch@dell.com>,
       openipmi-developer@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Soft lockup (and reboot): IPMI
References: <44E0A176.8070907@svs.Informatik.Uni-Oldenburg.de>	<20060814210231.GB3637@lists.us.dell.com> <44E16ECF.3060206@svs.Informatik.Uni-Oldenburg.de>
In-Reply-To: <44E16ECF.3060206@svs.Informatik.Uni-Oldenburg.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Matthias Hahn wrote:
> Matt Domsch wrote:
>
>   
>> On Mon, Aug 14, 2006 at 06:14:46PM +0200, Philipp Matthias Hahn wrote:
>>
>>     
>>> While playing with "openipmigui", the server just rebooted with the
>>> following last message:
>>>
>>> BUG: soft lockup detected on CPU#0!
>>> <c0103416> show_trace+0xd/0xf
>>> <c01034e5> dump_stack+0x15/0x17
>>> <c01382b0> softlockup_tick+0x9d/0xae
>>> <c012190a> run_local_timers+0x12/0x14
>>> <c0121748> update_process_times+0x3c/0x61
>>> <c010e1d9> smp_apic_timer_interrupt+0x57/0x5f
>>> <c010307c> apic_timer_interrupt+0x1c/0x24
>>> <f8aa8783> ipmi_thread+0x43/0x71 [ipmi_si]
>>> <c0129e62> kthread+0x78/0xa0
>>> <c0100e31> kernel_thread_helper+0x5/0xb
>>>
>>> Any idea on what went wrong?
>>>       
>> What kernel please?  If 2.6.17 or higher, this is new.  If < 2.6.17,
>> this is most likely due to the udelay(1) call in ipmi_thread() which
>> in 2.6.17 was replaced with a schedule().
>>     
>
> Sorry for omitting that information, it's a plain 2.6.17.8 kernel.
> model name      : Intel(R) Xeon(TM) CPU 2.66GHz
>
> ipmi message handler version 39.0
> IPMI Watchdog: driver initialized
> ipmi device interface
> IPMI System Interface driver.
> ipmi_si: Trying SMBIOS-specified KCS state machine at I/O address 0xca2,
> slave address 0x24, irq 0
> ipmi: Found new BMC (man_id: 0x002880,  prod_id: 0x0000, dev_id: 0x00)
>  IPMI KCS interface initialized
>   
The only way I can see this would happen is if the BMC is misbehaving
somehow, like leaving the "ready" bit set for a long time (not clearing
it when it is supposed to) and always signalling that there is some
event ready.  I guess if the BMC was so fast that it was alway ready
that could cause this problem, but that doesn't really seem very likely
as userland would have to run to feed it to do that.

This is apparently a Fujitsu device, right?  The fact that the product
id is 0x0000 leads me to believe that this device is not completely
cooked yet.

-Corey
