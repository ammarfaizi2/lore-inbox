Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUEPEw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUEPEw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 00:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUEPEw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 00:52:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:49364 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263095AbUEPEwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 00:52:55 -0400
Date: Sat, 15 May 2004 21:52:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
cc: Andrew Morton <akpm@osdl.org>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <200405152231.15099.elenstev@mesatop.com>
Message-ID: <Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
 <Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org>
 <Pine.LNX.4.58.0405152029110.10718@ppc970.osdl.org> <200405152231.15099.elenstev@mesatop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 May 2004, Steven Cole wrote:
> 
> OK, will do.  I ran the bk exerciser script for over an hour with 2.6.6-current
> and no CONFIG_PREEMPT and no errors.  The script only reported one
> iteration finished, while I got it to do 36 iterations over several hours earlier
> today (with a 2.6.3-4mdk vendor kernel)

Hmm.. Th ecurrent BK tree contains much of the anonvma stuff, so this 
might actually be a serious VM performance regression. That could 
effectively be hiding whatever problem you saw.

Andrea: have you tested under low memory and high fs load? Steven has 384M
or RAM, which _will_ cause a lot of VM activity when doing a full kernel
BK clone + undo + pull, which is what his test script ends up doing...

It would be good to test going back to the kernel that saw the "immediate 
problem", and try that version without CONFIG_PREEMPT. 

		Linus
