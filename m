Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbUKMX3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUKMX3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUKMX1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:27:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:35248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbUKMXZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:25:15 -0500
Date: Sat, 13 Nov 2004 15:24:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: 2.6.10-rc1-mm5 [u]
Message-Id: <20041113152457.6cb0fedb.akpm@osdl.org>
In-Reply-To: <1100384533.12195.3.camel@nosferatu.lan>
References: <20041111012333.1b529478.akpm@osdl.org>
	<1100368553.12239.3.camel@nosferatu.lan>
	<1100380593.12663.1.camel@nosferatu.lan>
	<20041113132232.5c201000.akpm@osdl.org>
	<1100384533.12195.3.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Schlemmer [c]" <azarah@nosferatu.za.org> wrote:
>
>  > Could you please try:
>  > 
>  > wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/futex_wait-fix.patch
>  > patch -R -p1 < futex_wait-fix.patch
>  > 
>  > the retest?
> 
>  Yep, this seems to fix it (usually one thread at least have already hung
>  at start for evo, now fine after a few mail fetches).

OK, thanks.

>  Is this a regression, or as in the other thread an issue with evolution
>  that should be fixed ?  (Note:  gnome-btdownload also seemed to hang
>  overnight with -mm[45], but I do not know if its related)

Don't know.  It's hard to see why that patch would cause gross misbehaviour
in evolution and apache.  We may have to just revert it and take another
look at the problem which it fixes.

One thing I do note which is unrelated to this problem is that futex_wait()
does get_user() inside down_read(mmap_sem).  But a fault will do a second
down_read().  And doing down_read() twice from within the same thread is a
bug, because an intervening down_write() from another thread will cause
deadlock.

