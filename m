Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUHDNQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUHDNQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUHDNQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:16:41 -0400
Received: from ppp1-isdn-164.the.forthnet.gr ([213.16.246.164]:14977 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S265214AbUHDNQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:16:39 -0400
From: V13 <v13@priest.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: secure computing for 2.6.7
Date: Wed, 4 Aug 2004 16:18:39 +0300
User-Agent: KMail/1.6.82
Cc: Andrea Arcangeli <andrea@cpushare.com>, linux-kernel@vger.kernel.org
References: <2ejhQ-4lc-5@gated-at.bofh.it> <2olLt-4wI-5@gated-at.bofh.it> <m3ekmq2ym7.fsf@averell.firstfloor.org>
In-Reply-To: <m3ekmq2ym7.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408041618.42630.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2004 03:05, Andi Kleen wrote:
> I don't think a sequence number is a good idea. Consider a
> vendor/third party kernel fixing a security bug, but mainline hasn't
> taken the patch yet for some reason.
>
> The vendor kernel could not safely increase this number, because it
> could conflict with some other security bug fixed in mainline at the
> same time.
>
> The end result would be that the kernel would be fixed, but
> the application has no way to tell.
>
> Better may be a bitmap, but even there you still have an problem
> with allocating these bits.
>
> A safe solution would be a file in /proc that lists CAN idenitifiers of
> fixed bugs or similar, but that may be quite some overhead to maintain
> and parse.

What about using the kernel version (instead of a seq #) plus a /proc file 
which lists the fixed CAN ids? This way a patch to a kernel will add an entry 
to /proc/koko and the program whould check the kernel version. If the kernel 
version is less or equal to X then it will read the /proc/koko for applied 
patches.

When a new version of the kernel is released then the /proc/koko file will be 
cleared a bit since version X.Y.Z means that the patches were added.

This leads to a hole between releasing a new version of the program and 
releasing a new kernel version, since the author will not be able to know if 
the next version of the kernel will have this bug fixed or not, so he cannot 
safely check the kernel version for a >X.Y.Z.

This can be solved in combination with a user space library that maintains a 
list of known kernel fixes and an API like: int can_is_fixed(...); which will 
combine the /proc information with the kernel version. The library (i.e 
an /etc file) will maintain a list of known fixes and the kernel version it 
was applied and will read the /proc/koko file for extra information. This may 
lead to false positives in case the library is an older version and the 
kernel is upgraded (since the lib will not know about the applied patch) but:

a) This is acceptable by the conditions you've set
b) Can be partialy solved by keeping CAN ids in /proc/koko for N versions of 
kernel (or for N months)

> -Andi
<<V13>>
