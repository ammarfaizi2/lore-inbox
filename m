Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVFSBdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVFSBdu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 21:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVFSBdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 21:33:50 -0400
Received: from colin.muc.de ([193.149.48.1]:18193 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262215AbVFSBds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 21:33:48 -0400
Date: 19 Jun 2005 03:33:47 +0200
Date: Sun, 19 Jun 2005 03:33:47 +0200
From: Andi Kleen <ak@muc.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, ACurrid@nvidia.com,
       venkatesh.pallipadi@intel.com
Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work
Message-ID: <20050619013347.GA69034@muc.de>
References: <200506181452.52921.s0348365@sms.ed.ac.uk> <20050618190921.GA59126@muc.de> <200506190121.13253.s0348365@sms.ed.ac.uk> <200506190157.28997.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506190157.28997.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Despite the fact that this wasn't documented in the BIOS update, an update for 
> my board (MS-7030 Neo Platinum by MSI) supposedly fixing "Fan Function" 
> actually corrects the IO-APIC and NMI bugs. I now get the following in dmesg 
> instead:
> 
> Calibrating delay loop... 3973.12 BogoMIPS (lpj=1986560)
> Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 512K (64 bytes/line)
> CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
> Using local APIC timer interrupts.
> Detected 12.561 MHz APIC timer.
> testing NMI watchdog ... OK.
> 
> So I'm a happy man. Whether this is at all related to the problems I was 
> having before, I don't really know. If the problem doesn't reoccur, I could 
> very well have wasted your time.

Hmm - I suspect I know what's happening. The older BIOS probably had some long
running SMM code that breaks the BogoMips computation occasionally
and that breaks the timer check later which relies on usable BogoMips.

There was a patch for that from Venkatesh (because it showed on some
other machines too), but it didn't seem to have made it into 2.6.12 

Venkatesh, can you push your calibrate_delay patch please? ? 


-Andi
