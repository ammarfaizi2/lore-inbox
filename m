Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbUBGOzu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 09:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbUBGOzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 09:55:50 -0500
Received: from mail.shareable.org ([81.29.64.88]:62672 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266921AbUBGOzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 09:55:48 -0500
Date: Sat, 7 Feb 2004 14:55:44 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ross Dickson <ross@datscreative.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Nforce2 apic timer ack delay
Message-ID: <20040207145544.GC17015@mail.shareable.org>
References: <200312211917.05928.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312211917.05928.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> a) The Nforce2 DASP speculates and gets it right, pre-fetching the
> code for the local apic timer interrupt, so the interrupt code
> executes sooner after activation than it does with other chipsets
> for AMD.
> 
> b) The AMD cpu may not be over its timing and stability issues when
> coming out of C1 disconnect. Plenty stable soon enough for other
> chipsets and other codepaths in linux which pull the cpu out of C1
> disconnect, but not quite soon enough for the "cached" short code
> path to the local apic timer ack. So most of the time any latent
> lockup potential is not realised, but on occasion we hit it.

Ross,

Is the AMD C1 Disconnect state only entered when the CPU is idle, as in a
"hlt" instruction?

If it is, we could set a flag just before the "hlt" instruction in the
idle task and clear it afterwards.  If the flag is set, the interrupt
path could clear the flag and do the delay thing.  Then you could use
a longer, safe delay, and have it in the generic intrrupt path not
just the local apic timer.  A delay coming out of the idle state is no
big deal.

-- Jamie
