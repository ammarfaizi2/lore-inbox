Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUHFMwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUHFMwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 08:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUHFMwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 08:52:41 -0400
Received: from science.horizon.com ([192.35.100.1]:64807 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S265489AbUHFMwh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 08:52:37 -0400
Date: 6 Aug 2004 12:52:36 -0000
Message-ID: <20040806125236.24348.qmail@science.horizon.com>
From: linux@horizon.com
To: mbligh@aracnet.com
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend because my fingers STILL type "@vger.rutgers.edu" if I'm not
paying attention...]

> In practice, I suspect 2/2 will do exactly what you want ... and what 
> 99.9% of people want actually ;-) We could add more options, but be sure
> to mark anything that's not 1GB aligned as not suitable for PAE (as the
> 0.5 split was).

But if you're using PAE, you've got > 4G of RAM, so there's no need to
be clever trying to avoid HIGHMEM options.

Unfortunately, I just had a server with Con's patch detonate overnight
(Oops in interrupt -> panic; details in separate e-mail), and wli tells
me that there are additional places in the code that need fixing.

I notice that all previous patches had the kernel range a power of 2 in size.
Is this required somewhere?  I thought it was just that the kernel
had to start at a PGD boundary (4M on normal x86, 1G on PAE).

If 128M is always enough, a split at 0xb800000 seems possible, but
giving it an extra 128M seems like a nice bit of safety for PCI devices.

