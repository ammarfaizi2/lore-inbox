Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVCYBI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVCYBI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVCYBIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:08:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:1470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261365AbVCYBHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:07:40 -0500
Date: Thu, 24 Mar 2005 17:07:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lutz Vieweg <lutz.vieweg@is-teledata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() not returning though pipe became readable
Message-Id: <20050324170731.70a31f99.akpm@osdl.org>
In-Reply-To: <4242E0E2.4050407@is-teledata.com>
References: <4242E0E2.4050407@is-teledata.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lutz Vieweg <lutz.vieweg@is-teledata.com> wrote:
>
> I'm currently investigating the following problem, which seems to indicate
> a misbehaviour of the kernel:
> 
> A server software we implemented is sporadically "hanging" in a select()
> call since we upgraded from kernel 2.4 to (currently) 2.6.9 (we have to wait
> for 2.6.12 before we can upgrade again due to the shared-mem-not-dumped-into-
> core-files problem addressed there).
> 
> What's suspicious is that whenever we attach with gdb to such a hanging process,
> we can see that a pipe, whose file-descriptor is definitely included in the
> fd_set "readfds" (and "n" is also high enough) has a byte in it available for
> reading - and just leaving gdb again is enough to let the server continue just
> fine.
> 
> We are using that pipe, which is known only to the same one process, to cause
> select() to return immediately if a signal (SIGUSR1) had been delivered to the
> process (by another process), there's a signal handler installed that does
> nothing but a (non-blocking) write of 1 byte to the writing end of the pipe.
> 
> This mechanism worked fine before kernel 2.6, and it is still working in 99.99% of
> the cases, but under heavy load, every few hours, we'll see the hanging select()
> as mentioned above.
> 
> I noticed a recent thread at lkml about poll() and pipes, but that seems to address a
> different issue, where there are more events reported than occured, what we
> see is quite the opposite, we want select() to return on that pipe becoming readable...
> 
> Any ideas?
> Any hints on what to do to investigate the problem further?

Could you at least test 2.6.12-rc1?  Otherwise we might be looking for a
bug whicj isn't there.

