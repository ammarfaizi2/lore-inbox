Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266272AbUAIAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbUAIARX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:17:23 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:38283 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265880AbUAIAOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:14:09 -0500
Subject: Re: [2.6.1-rc2-mm1][BUG] Badness in unblank_screen at
	drivers/char/vt.c:2793
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ramon.rey@hispalinux.es, ramon.rey@augcyl.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040108155940.68ab047a.akpm@osdl.org>
References: <1073605532.1070.6.camel@debian>
	 <20040108155940.68ab047a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1073607026.4067.178.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 11:10:28 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ben, your debug stuff tripped up when we were oopsing.  bust_spinlocks()
> calls unblank_screen() without console_sem.  I'll change it to
> 
> 	WARN_ON(!is_console_locked() && !oops_in_progress);
> 
> (Weren't you going to update that patch anyway?)

I don't have an update ready at the moment, nothing critical need
updating and I was waiting to see if the WARN_ON would catch some
stuffs :)

It's probably worth adding a WARN_CONSOLE_UNLOCKED() macro that
does the above rather than fixing all the WARN_ON's don't you
think ? If yes, then I'll do a new patch.

> As for the oops itself: 2.6.1-rc2-mm1 VM is kaput, sorry.  It works OK here
> without the fremap changes.

Ok.


