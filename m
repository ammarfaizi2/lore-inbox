Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRJAWuv>; Mon, 1 Oct 2001 18:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275686AbRJAWul>; Mon, 1 Oct 2001 18:50:41 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:20389 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S275685AbRJAWua>;
	Mon, 1 Oct 2001 18:50:30 -0400
Message-ID: <3BB8F346.B7B9CD96@candelatech.com>
Date: Mon, 01 Oct 2001 15:50:46 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110012305350.3280-200000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> (note that in case of shared interrupts, another 'innocent' device might
> stay disabled for some short amount of time as well - but this is not an
> issue because this mitigation does not make that device inoperable, it
> just delays its interrupt by up to 10 msecs. Plus, modern systems have
> properly distributed interrupts.)

I'm all for anything that speeds up (and makes more reliable) high network
speeds, but I often run with 8+ ethernet devices, so IRQs have to be shared,
and a 10ms lockdown on an interface could lose lots of packets.  Although
it's not a perfect solution, maybe you could (in the kernel) multiple the
max by the number of things using that IRQ?  For example, if you have four
ethernet drivers on one IRQ, then let that IRQ fire 4 times faster than
normal before putting it in lockdown...

Do you have any idea how many packets-per-second you can get out of a
system (obviously, your system of choice) using your updated code?

(I'm running about 7k packets-per-second tx, and 7k rx, on 3 EEPRO ports
simultaneously on a 1Ghz PIII and 2.4.9-pre10...  This is from user-space,
so much of the CPU is spent hauling my packets to and from the device..)

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
