Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUG0Rnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUG0Rnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUG0Rnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:43:42 -0400
Received: from zero.aec.at ([193.170.194.10]:13836 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266492AbUG0RnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:43:16 -0400
To: Balint Marton <cus@fazekas.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_random_bytes returns the same on every boot
References: <2kUHO-6hJ-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 27 Jul 2004 19:43:13 +0200
In-Reply-To: <2kUHO-6hJ-15@gated-at.bofh.it> (Balint Marton's message of
 "Fri, 23 Jul 2004 01:00:12 +0200")
Message-ID: <m3ekmxmjm6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balint Marton <cus@fazekas.hu> writes:
> Therefore all random data will come from the secondary pool, and the
> kernel cannot reseed the secondary pool, because there is no real 
> randomness in the primary one.
>
> The solution is simple: Initialize not just the primary, but also the 
> secondary pool with the system time. My patch worked for me with 
> 2.6.8-rc2, but it was not tested too long. 

That still is an easily predictible value and may not even be 
unique when lots of systems are powered up at the same time
(e.g. after a power failure) 

It would be better to use the hardware random generators that
are available in some southbridges and some CPUs now. I did a patch
a long time ago to automatically seed random from the intel/amd
random driver. Maybe that would be a better solution here? 

Also BTW your problem presents a strong case why compiling in
DHCP probes is bad and such stuff should run from initrd/initramfs.

-Andi

