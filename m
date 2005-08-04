Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVHDNTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVHDNTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVHDNTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:19:16 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:44513 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262526AbVHDNTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:19:12 -0400
Subject: Re: [PATCH] pmtmr and PRINTK_TIME timings display
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200508041459.43500.petkov@uni-muenster.de>
References: <200508041459.43500.petkov@uni-muenster.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 04 Aug 2005 09:19:05 -0400
Message-Id: <1123161545.12009.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 14:59 +0200, Borislav Petkov wrote:

> 
> where you see the deltas between the printk's printed once the tsc timer is 
> initialized as opposed to the first bootlog where you see all times relative 
> to a single point in time. The python script <scripts/show_delta> in the 
> kernel source converts between these two representations but there's a pretty 
> simple solution IMHO to make PRINTK_TIME uniform and independent from the 
> used timer. The one liner is against 2.6.12.3.
> 
> After applying it, printk timing looks like this:
> 
> <snip>
> [    0.000000] Detected 1500.132 MHz processor.
> [    0.000000] Using pmtmr for high-res timesource
> [    0.000000] Console: colour VGA+ 80x25
> [    1.890000] Dentry cache hash table entries: 131072 (order: 7, 524288 
> bytes)
> [    1.891000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    1.906000] Memory: 513756k/523520k available (2839k kernel code, 9276k 
> reserved, 1148k data, 152k init, 0k highmem)
> [    1.906000] Checking if this processor honours the WP bit even in 
> supervisor mode... Ok.
> [    1.906000] Calibrating delay loop... 2973.69 BogoMIPS (lpj=1486848)
> [    1.928000] Security Framework v1.0.0 initialized
> </snip>
> 

But if you are debugging problems with jiffies wrapping, wouldn't you
want to see the jiffies unmodified?  I understand your point, but the
tsc output (which I do prefer) seems to only be for the tsc (on x86),
and all else use jiffies (haven't looked at other archs). So debugging a
problem with jiffy wrap*, one would need to use something other than the
tsc, and then they would see the time the wrap occurred.

Also, the big number stands out more than the 3 zeros, so when I see
that, I know right away to go and change it back to use the tsc (since
my debugging usually needs higher resolutions).

* new product from Renolds ;-)

-- Steve


