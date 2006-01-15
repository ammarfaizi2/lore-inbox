Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWAOXDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWAOXDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 18:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWAOXDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 18:03:16 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:52206 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750964AbWAOXDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 18:03:15 -0500
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com>
	<43C94464.4040500@cfl.rr.com> <m3hd861o2r.fsf@telia.com>
	<43C982C0.1070605@cfl.rr.com> <m3r779z9on.fsf@telia.com>
	<43CA89A4.3010000@cfl.rr.com> <m3k6d1z87g.fsf@telia.com>
	<43CACC34.504@cfl.rr.com>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Jan 2006 00:03:10 +0100
In-Reply-To: <43CACC34.504@cfl.rr.com>
Message-ID: <m3vewlxff5.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> >>Ahh, excellent.  Also, is the memory currently non pagable?  Is there
> >>a reason for that?
> >
> >Yes the memory is non pagable. The linux kernel doesn't support
> >pagable kernel memory, only user space memory can be swapped out.
> 
> Surely the kernel can allocate pagable memory if it chooses to?

No, not unless you make large changes in the VM subsystem.

But there is another issue here as well. Even if the kernel could
allocate pagable memory, it would be non-trivial to use it in a block
device driver. A block driver can be asked by the kernel to write out
memory to disc *because* there is memory pressure in the system. If
the block driver needs to make additional memory allocations before it
can write data (for example, to page in swapped out memory), the
system could deadlock.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
