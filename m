Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTEDWRc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 18:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTEDWRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 18:17:32 -0400
Received: from ee.oulu.fi ([130.231.61.23]:52872 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261808AbTEDWRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 18:17:31 -0400
Date: Mon, 5 May 2003 01:29:58 +0300 (EEST)
From: Ville Voutilainen <vjv@ee.oulu.fi>
Message-Id: <200305042229.h44MTwTf012142@stekt2.oulu.fi>
To: meshko@cs.brandeis.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: fcntl file locking and pthreads
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> actually what I have is:
> thread 0:
> pthread_create() (1)
> pthread_create() (2)
> thread 1:
> open()
> fcntl()
> thread 2:
> open()
> fcntl()
> and they all succeed. Even though the file descriptors are different. 

Which shows us that fcntl cannot detect a file lock held by
the current process, no matter how many times we open the same
file in order to get different file descriptors. Bloody POSIX,
might I say. :) I wonder if POSIX even says anything non-vague
wrt. to this. As in, if Linux would enable detecting
two locks on two different fds (pointing to the same file)
within one process, would Linux violate POSIX? Moreover, is
this simply so that kernel detects the situation just fine,
but the info is not carried to user space because good ole
fcntl behaviour doesn't really take threads into account?
In the marvellous scheme of things (user app -> glibc -> kernel
and back), at what point (if any) is it possible to detect
multiple locks within one process? And can it be done so that
fcntl can still be claimed to be even remotely compatible
with anything on the planet?

> You digress, but I feel like I have to justify myself now :)
> Those threads used to be processes and now want be threads with minimal 
> modifications. The files that are locked are still used by other processes 
> too.

Then, logically (I suppose you already know this, but..) you
need both the file locks and mutexes to sync with both other
threads and other processes. There, one more example of how
going multi-threaded sometimes adds (mostly locking) code.

I'll shut up now, we are only at the borderline of kernel-land
and if we aim for portability, we are probably solely and
firmly on the user-land side of the big picture.

-VJV-
