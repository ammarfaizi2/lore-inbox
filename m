Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVCXPul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVCXPul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVCXPsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:48:11 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:1938 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S262805AbVCXPqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:46:53 -0500
Message-ID: <4242E0E2.4050407@is-teledata.com>
Date: Thu, 24 Mar 2005 16:46:42 +0100
From: Lutz Vieweg <lutz.vieweg@is-teledata.com>
Organization: Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040322 wamcom.org
X-Accept-Language: de, German, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: select() not returning though pipe became readable
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm currently investigating the following problem, which seems to indicate
a misbehaviour of the kernel:

A server software we implemented is sporadically "hanging" in a select()
call since we upgraded from kernel 2.4 to (currently) 2.6.9 (we have to wait
for 2.6.12 before we can upgrade again due to the shared-mem-not-dumped-into-
core-files problem addressed there).

What's suspicious is that whenever we attach with gdb to such a hanging process,
we can see that a pipe, whose file-descriptor is definitely included in the
fd_set "readfds" (and "n" is also high enough) has a byte in it available for
reading - and just leaving gdb again is enough to let the server continue just
fine.

We are using that pipe, which is known only to the same one process, to cause
select() to return immediately if a signal (SIGUSR1) had been delivered to the
process (by another process), there's a signal handler installed that does
nothing but a (non-blocking) write of 1 byte to the writing end of the pipe.

This mechanism worked fine before kernel 2.6, and it is still working in 99.99% of
the cases, but under heavy load, every few hours, we'll see the hanging select()
as mentioned above.

I noticed a recent thread at lkml about poll() and pipes, but that seems to address a
different issue, where there are more events reported than occured, what we
see is quite the opposite, we want select() to return on that pipe becoming readable...

Any ideas?
Any hints on what to do to investigate the problem further?

Regards,

Lutz Vieweg


