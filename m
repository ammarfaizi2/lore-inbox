Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277905AbRJRS2L>; Thu, 18 Oct 2001 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277924AbRJRS2B>; Thu, 18 Oct 2001 14:28:01 -0400
Received: from domino1.resilience.com ([209.245.157.33]:11948 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S277905AbRJRS1l>; Thu, 18 Oct 2001 14:27:41 -0400
Mime-Version: 1.0
Message-Id: <p05100309b7f4cd5976f7@[10.128.7.49]>
In-Reply-To: <Pine.LNX.4.21.0110181034050.16868-100000@marty.infinity.powertie.org>
In-Reply-To: <Pine.LNX.4.21.0110181034050.16868-100000@marty.infinity.powertie.org>
Date: Thu, 18 Oct 2001 11:28:06 -0700
To: Patrick Mochel <mochelp@infinity.powertie.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:38 AM -0700 10/18/01, Patrick Mochel wrote:
>On Thu, 18 Oct 2001, Jonathan Lundell wrote:
>
>>  At 11:08 AM -0500 10/18/01, Taral wrote:
>>  >On Wed, Oct 17, 2001 at 04:52:29PM -0700, Patrick Mochel wrote:
>>  >>  When a suspend transition is triggered, the device tree is 
>>walked first to
>>  >>  save the state of all the devices in the system. Once this is 
>>complete, the
>>  >>  saved state, now residing in memory, can be written to some non-volatile
>>  >>  location, like a disk partition or network location.
>  > >>...
>  > What happens to state changes between the first and second traversal
>>  of the device tree?
>
>State changes of what?
>
>After the first walk (save_state), you essentially have a snapshot of the
>system in memory which can be written to disk, memory, etc.
>
>Once that is done, you disable interrupts and walk the tree again to power
>off devices.

The "state of all the devices in the system". Presumably, while you 
walk the tree the first time (to save state) interrupts are enabled, 
and devices are active. Operations (including interrupts) on the 
device can, presumably, change the state of the device after its 
state has been saved.

To take a crude example, suppose you save the state of an Ethernet 
NIC, then change its MAC address, and then suspend the device. The 
saved state now has the wrong MAC address.

In this particular case, of course, the driver can keep a soft copy 
of the current MAC address and and restore from that, but that means 
making special cases of special things.

Look at it another way. Why not save the state at the beginning of 
time (say when the device is first initialized) instead of walking 
the tree at suspend time? Presumably because there's some difference 
between the state then, and the state at suspend time. How did that 
difference happen, and why couldn't it happen after the save-state 
tree-walk but before the actual device suspend?
-- 
/Jonathan Lundell.
