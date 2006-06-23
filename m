Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWFWQ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWFWQ1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWFWQ1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:27:12 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:39372 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S1751722AbWFWQ1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:27:12 -0400
Date: Fri, 23 Jun 2006 09:27:07 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, ccb@acm.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
Message-ID: <Pine.LNX.4.61.0606230924520.2255@osa.unixfolk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, Ingo Molnar wrote:
| we really need to figure out what's happening here! Could you re-enable 
| spinlock debugging and try the patch below - do the stalls/lockups still 
| happen?

I'll do that, but the 2.6.16 FC4 kernel already has cpu_relax()
rather than __delay(1), so I'm about 95% certain that this patch
isn't going to help anything.   The NMI watchdog will still fire,
because all we are going to do is wait even longer, etc.

| ===================================================================
| --- linux.orig/lib/spinlock_debug.c
| +++ linux/lib/spinlock_debug.c
| @@ -104,10 +104,10 @@ static void __spin_lock_debug(spinlock_t
|  	u64 i;
|  
|  	for (;;) {
| -		for (i = 0; i < loops_per_jiffy * HZ; i++) {
| +		for (;;) {
|  			if (__raw_spin_trylock(&lock->raw_lock))
|  				return;
| -			__delay(1);
| +			cpu_relax();
|  		}

etc.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
