Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbUKNO3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUKNO3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 09:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUKNO3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 09:29:16 -0500
Received: from alog0162.analogic.com ([208.224.220.177]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261311AbUKNO3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 09:29:12 -0500
Date: Sun, 14 Nov 2004 09:28:36 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Florian Schmidt <mista.tapas@gmx.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTC Chip and IRQ8 on 2.6.9
In-Reply-To: <20041114132710.09533649@mango.fruits.de>
Message-ID: <Pine.LNX.4.61.0411140926050.13939@chaos.analogic.com>
References: <Pine.LNX.4.61.0411121145520.14827@chaos.analogic.com>
 <20041114132710.09533649@mango.fruits.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004, Florian Schmidt wrote:

> On Fri, 12 Nov 2004 11:47:10 -0500 (EST)
> linux-os <linux-os@chaos.analogic.com> wrote:
>
>>
>> I must use the RTC and IRQ8 in a driver being ported from
>> 2.4.20 to 2.6.9. When I attempt request_irq(8,...), it
>> returns -EBUSY. I have disabled everything in .config
>> that has "RTC" in it.
>>
>> The RTC interrupt is used to precisely time the sequencing
>> of a precision A/D converter. It is mandatory that I use
>> it because the precise interval is essential for its
>> IIR filter that produces 20 bits of resolution from a
>> 16 bit A/D.
>>
>>    8:          1    IO-APIC-edge  rtc
>
> maybe it's the HPET timer providing rtc emulation?
>
> flo
>
It turned out to be RTC timer software that, when built-in,
grabbed IRQ8 even though it didn't use it. I reconfigured
it as a module. Then, when I unload the module, the IRQ gets
freed up. (Fedora loads, I guess, everything...).


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
