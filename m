Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUA1UbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUA1UbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:31:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:34509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266173AbUA1Uaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:30:55 -0500
Date: Wed, 28 Jan 2004 12:30:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
In-Reply-To: <Pine.LNX.4.58.0401281221320.28145@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0401281229150.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
 <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
 <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401281129570.28145@home.osdl.org> <20040128204049.627e6312.ak@suse.de>
 <Pine.LNX.4.58.0401281205250.28145@home.osdl.org> <20040128211554.0cc890fb.ak@suse.de>
 <Pine.LNX.4.58.0401281221320.28145@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Linus Torvalds wrote:
> 
> If the real error is on the bridge somewhere but you don't even know which
> CPU did the access (and just "somebody" gets an MCE), just set a global
> flag, and have "read_pcix_error()" check the bridge (since it doesn't need
> to look anything up - it already knows the device).
> 
> And in that case then you need to take the proper locks (per-bridge, or
> global, depending on just how much you care) in "clear_pcix_error()" and
> release them in "read_pcix_error()".

Note, in case this wasn't clear already: in this case, the "MCE flag" is 
just a lazy flag saying "you need to check more deeply". It wouldn't cause 
false positives, simply because the _real_ check ends up being 
"read_pcix_error()" actually reading the error status from the bridge or 
the device.

It's just that 99% of the time, you don't want to do even that.

		Linus
