Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031243AbWLAMjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031243AbWLAMjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 07:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031247AbWLAMjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 07:39:44 -0500
Received: from [139.30.44.39] ([139.30.44.39]:6748 "EHLO
	fink.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1031243AbWLAMjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 07:39:43 -0500
Date: Fri, 1 Dec 2006 13:41:18 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: please pull from the trivial tree
In-Reply-To: <20061201113740.GP11084@stusta.de>
Message-ID: <Pine.LNX.4.63.0612011329130.3090@fink.physik3.uni-rostock.de>
References: <20061201113740.GP11084@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Chase Venters (1):
>       Fix jiffies.h comment

This one actually obscures the comment rather than fixing it.

>From jiffies.h:
> 76 /*
> 77  * The 64-bit value is not volatile - you MUST NOT read it
> 78  * without sampling the sequence number in xtime_lock.
> 79  * get_jiffies_64() will do this for you as appropriate.
> 80  */
> 81  extern u64 __jiffy_data jiffies_64;
> 82  extern unsigned long volatile __jiffy_data jiffies;

Note that jiffies is volatile, while jiffies_64 is not; the comment 
currently explains that. The proposed patch

> Fix jiffies.h comment
> jiffies.h includes a comment informing that jiffies_64 must be read with the
> assistance of the xtime_lock seqlock. The comment text, however, calls
> jiffies_64 "not volatile", which should probably read "not atomic".
> 
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -74,7 +74,7 @@
> #define __jiffy_data __attribute__((section(".data")))
> /*
> - * The 64-bit value is not volatile - you MUST NOT read it
> + * The 64-bit value is not atomic - you MUST NOT read it
> * without sampling the sequence number in xtime_lock.
> * get_jiffies_64() will do this for you as appropriate.
> */

would leave a comment that is correct, but less useful (I'd expect any 
kernel hacker to know that u64 is non-atomic on many platforms).

Tim
