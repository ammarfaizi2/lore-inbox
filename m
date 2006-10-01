Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWJARSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWJARSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWJARSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:18:43 -0400
Received: from pat.uio.no ([129.240.10.4]:2495 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751305AbWJARSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:18:42 -0400
Subject: RE: Postal 56% waits for flock_lock_file_wait
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411>
Content-Type: text/plain
Date: Sun, 01 Oct 2006 13:18:12 -0400
Message-Id: <1159723092.5645.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.305, required 12,
	autolearn=disabled, AWL 1.56, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 20:53 +0400, Ananiev, Leonid I wrote:
> > The kernel would appear to be doing exactly what is expected of it.
> 
> Each of 16 user threads calls to open() one of 1000 files each 20 sec.
> 3000 calls per minute in sum.
> The open() sleeps.

According to your numbers, the call to flock() sleeps. Where do they
show a measurable sleep in open()?

> I'm not sure that users expected just of sleeping.

I still don't get it. The job of the flock() system call is to sleep if
someone already holds the lock, and then grab the lock when it is
released. If that is not what the user expects, then the user has the
option of not calling flock(). This has nothing to do with open().

Trond


> Leonid
> 
> -----Original Message-----
> From: Trond Myklebust [mailto:trond.myklebust@fys.uio.no] 
> Sent: Sunday, October 01, 2006 8:05 AM
> To: Ananiev, Leonid I
> Cc: Linux Kernel Mailing List
> Subject: RE: Postal 56% waits for flock_lock_file_wait
> 
> On Sat, 2006-09-30 at 21:26 +0400, Ananiev, Leonid I wrote:
> > > On which filesystem were the above results obtained if it was not
> > ext2?
> > The default ext3 fs was used.
> > 
> > > All the above results are telling you is that your test involves
> > several
> > > processes contending for the same lock, and so all of them barring
> the
> > > one process that actually holds the lock are idle.
> > 
> > Yes. It is  flock_lock_file_wait.
> 
> That is the function which causes the sleep, yes. So what is your gripe?
> The kernel would appear to be doing exactly what is expected of it.
> 
> Trond

