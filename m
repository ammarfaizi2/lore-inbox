Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbTCRKBM>; Tue, 18 Mar 2003 05:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTCRKBM>; Tue, 18 Mar 2003 05:01:12 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:63127 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S262276AbTCRKBK>; Tue, 18 Mar 2003 05:01:10 -0500
Date: Tue, 18 Mar 2003 22:09:48 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] Faster SWSUSP free page counting
In-reply-to: <20030318082008.GC10472@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047982188.2204.8.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1047944582.1713.5.camel@laptop-linux.cunninghams>
 <20030318082008.GC10472@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The speed difference depends of course upon the number of pages free and
the degree of fragmentation. I guess the easy answer is that it was
written and kept because it helped. Having talked to Andrew about the
use of page flags, I'll do some more changes before we put it to Linus -
I'll use a dynamically allocated bitmap instead of pageflags.

Regards,

Nigel

On Tue, 2003-03-18 at 20:20, Pavel Machek wrote:
> Hi!
> 
> > This patch improves the speed of SWSUSP's count_and_copy_data_pages
> > function by generating a map of the free pages before iterating through
> > the list of pages. The net result is to go from O(n^2) to O(n), if I
> > remember my computer science correctly.
> 
> Is the speed difference noticable?
> 
> If yes than okay, but generate_free_page_map() should still be moved
> into kernel/suspend.c.
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

