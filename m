Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWAIC6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWAIC6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWAIC6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:58:53 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:52381 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750866AbWAIC6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:58:53 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Mon, 09 Jan 2006 13:59:01 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <icj3s110dltnt6hh5tt1etrfomhvr8a7v4@4ax.com>
References: <20060108095741.GH7142@w.ods.org> <E1EvXi5-0000kv-00@calista.inka.de> <igs1s1lje7b7kkbmb9t6d06n8425i1b1i4@4ax.com> <4807377b0601081837u2c1d50b3w218d5ef9e3dc662@mail.gmail.com>
In-Reply-To: <4807377b0601081837u2c1d50b3w218d5ef9e3dc662@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 18:37:52 -0800, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

>On 1/8/06, Grant Coady <gcoady@gmail.com> wrote:
>> On Sun, 08 Jan 2006 11:23:37 +0100, be-news06@lina.inka.de (Bernd Eckenfels) wrote:
>>
>> >Willy Tarreau <willy@w.ods.org> wrote:
>> >> It's rather strange that 2.6 *eats* CPU apparently doing nothing !
>> >
>> >it eats it in high interrupt load. And it is caused by the pty-ssh-tcp
>> >output, so most likely those are eepro100 interrupts.
>>
>> That would be true for either 2.4 or 2.6, no?  Also it runs e100
>> driver, but...
>>
>> 2.4 dmesg:
>> Intel(R) PRO/100 Network Driver - version 2.3.43-k1
>> Copyright (c) 2004 Intel Corporation
>>
>> e100: selftest OK.
>> e100: eth0: Intel(R) PRO/100 Network Connection
>>   Hardware receive checksums enabled
>>   cpu cycle saver enabled
>>
>> 2.6 dmesg:
>> [   31.977945] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
>> [   31.978007] e100: Copyright(c) 1999-2005 Intel Corporation
>> [   32.002928] e100: eth0: e100_probe: addr 0xfd201000, irq 11, MAC addr 00:90:27:42:AA:77
>> [   32.026992] e100: eth1: e100_probe: addr 0xfd200000, irq 12, MAC addr 00:90:27:58:32:D4
>> [   32.186941] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
>>
>> Are rx checksums not turned on in 2.6' e100 driver?
>> CPU is only pentium/mmx 233
>
>Hey Grant, to answer your question, checksums are not offloaded with
>the current e100 driver but that really shouldn't make that much of a
>difference.  I'm actually going to go with interrupt load due to e100
>being at least related to the problem.

Okay, that may make a difference with a slow CPU.

>BTW I get access denied when hitting
>http://bugsplatter.mine.nu/test/boxen/deltree/

OMG!  Not the red screen?  Hmmm, collateral damage ;)  Just turned it 
off, unless you're masquerading as a web crawler :p

>The netdev-2.6 git tree currently has a driver that supports microcode
>loading for your rev 8 PRO/100 and that microcode may help your
>interrupt load due to e100.  however, it may already be loading. 

>Also, what do you have HZ set to? (250 is default in 2.6, 1000 in 2.4)
>so you could try running your 2.6 kernel with HZ=1000

Running it with 100Hz, isn't 2.4 == 100Hz?  I can try 1000Hz,
but not for some hours now, other stuff on.

>while you're running your test you could try (if you have sysstat)
>sar -I <e100 interrupt> 1 10
>
>or a simpler version, 10 loops of cat /proc/interrupts; sleep 1;
>
>Lets see if its e100,

Yes, lets.  More later.

Cheers,
Grant.
