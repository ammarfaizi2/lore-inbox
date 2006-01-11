Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbWAKHWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWAKHWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 02:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWAKHWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 02:22:17 -0500
Received: from main.gmane.org ([80.91.229.2]:61331 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750864AbWAKHWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 02:22:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: 2.6.15 and CONFIG_PRINTK_TIME
Date: Wed, 11 Jan 2006 16:21:58 +0900
Message-ID: <dq2bmo$fdj$1@sea.gmane.org>
References: <dq28uj$96q$1@sea.gmane.org> <200601110901.57718.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060110)
X-Accept-Language: en-us, en
In-Reply-To: <200601110901.57718.vda@ilport.com.ua>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Wednesday 11 January 2006 08:34, Kalin KOZHUHAROV wrote:
> 
>>I remember there was some talk about resetting the time on printk during the
>>boot to zero... Is that gone for 2.6.15?
>>
>>I recently turned CONFIG_PRINTK_TIME on two machines and they identically
>>print things like this:
>>
>>[17179569.184000] Linux version 2.6.15-K01_PIII_laptop (kalin@ss) (gcc
>>version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #2 PREEMPT Wed
>>Jan 11 09:56:21 JST 2006
>>[17179569.184000] BIOS-provided physical RAM map:
>>[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>>[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>>[17179569.184000]  BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
>>[17179569.184000]  BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
>>[17179569.184000]  BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
>>
>>...
>>
>>[17179591.768000] ReiserFS: hda5: checking transaction log (hda5)
>>[17179591.836000] ReiserFS: hda5: Using r5 hash to sort names
>>[17179605.172000] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
>>
>>That is about t0 + 200 days :-) No, the box is not THAT slow :-D
>>
>>Now, on two different boxen, the initial time is the same: 17179569.184000
>>
>>What is this number?
> 
> 
> I guess time sybsystem is not up until that line.

???

The last MSG was just before the console gets started, so I don't think this
is the cas unles there is something totally borked.

Another check:

# grep -i time /var/log/dmesg
[17179569.184000] ACPI: PM-Timer IO Port: 0xee08
[17179569.184000] Using pmtmr for high-res timesource
[17179570.672000] Calibrating delay using timer specific routine.. 1595.33
BogoMIPS (lpj=3190662)
[17179570.772000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[17179570.776000] Machine check exception polling timer started.
[17179570.836000] Real Time Clock Driver v1.12
[17179570.836000] Software Watchdog Timer: 0.07 initialized. soft_noboot=0
soft_margin=60 sec (nowayout= 0)
[17179570.848000] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180
seconds, margin is 60 seconds).


This is something new, I think:

[17179569.184000] ACPI: PM-Timer IO Port: 0xee08

or at least I don't remember seeing it before.

What is "time system" and how to check if it is up or not?

.config:
	http://linux.tar.bz/reports/misc/ss/2.6.15-K01_PIII_laptop.config
full dmesg:
	http://linux.tar.bz/reports/misc/ss/2.6.15-K01_PIII_laptop.dmesg
patches (sk98lin + cosmetic):
	http://linux.tar.bz/patches/2.6.15-K01/

Kalin.

P.S. I am subscribed to LKML.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

