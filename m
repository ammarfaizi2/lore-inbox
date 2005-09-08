Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVIHS4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVIHS4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 14:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVIHS4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 14:56:33 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:18575 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S964918AbVIHS4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 14:56:32 -0400
In-Reply-To: <Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de>
References: <200509080125.j881PcL9015847@hera.kernel.org>  <431F9899.4060602@pobox.com> <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de>  <1126184700.4805.32.camel@tsc-6.cph.tpack.net>  <Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de> <1126190554.4805.68.camel@tsc-6.cph.tpack.net> <Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <62AA8EFA-7D65-4E87-B71F-55A07321011E@freescale.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] 3c59x: read current link status from phy
Date: Thu, 8 Sep 2005 13:56:16 -0500
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 8, 2005, at 10:42, Bogdan Costescu wrote:

> On Thu, 8 Sep 2005, Tommy Christensen wrote:
>
>> Personally, I'd prefer the delay to be < 10 seconds.
>>
>
> If you sample every 60 seconds ? Teach Shannon how to do it ;-)
>
> If you mean to reduce the sampling period, there is a very good  
> reason not to do it: these MDIO operations are expensive - it's a  
> serial protocol. vortex_timer() might do 2 (and with the discussed  
> change - 3) of them - there are better things to do for the CPU  
> than wait for these I/O operations. Plus, vortex_timer() also  
> disables the interrupt...
>
> The Tornado and at least some Cyclone chips support generating an  
> interrupt whenever the link changes, which can be used instead of  
> polling for link state. This feature is not used in the 3c59x  
> driver and could give you much less than 10 seconds accuracy - but  
> you have to code it. ;-)


The new PHY Layer (drivers/net/phy/*) can provide all these features  
for you without much difficulty, I suspect.  The layer supports  
handling the interrupts for you, or (if it's shared with your  
controller's interrupt) provides simple hooks to make supporting  
interrupts easy.

Is the cost of an extra read every minute really too high?  It's such  
a small fraction of the CPU time, and provides a better user experience.
