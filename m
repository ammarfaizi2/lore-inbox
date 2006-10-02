Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWJBRLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWJBRLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWJBRLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:11:33 -0400
Received: from pat.uio.no ([129.240.10.4]:25318 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965133AbWJBRLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:11:33 -0400
Subject: Re: Postal 56% waits for flock_lock_file_wait
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Tim Chen <tim.c.chen@intel.com>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <3282373b0610020957u739392eekf8b78c7574e1a6e7@mail.gmail.com>
References: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411>
	 <1159723092.5645.14.camel@lade.trondhjem.org>
	 <3282373b0610020957u739392eekf8b78c7574e1a6e7@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 13:11:21 -0400
Message-Id: <1159809081.5466.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.831, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 09:57 -0700, Tim Chen wrote:
> On 10/1/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> >
> > I still don't get it. The job of the flock() system call is to sleep if
> > someone already holds the lock, and then grab the lock when it is
> > released. If that is not what the user expects, then the user has the
> > option of not calling flock(). This has nothing to do with open().
> >
> > Trond
> >
> 
> If I understand Leonid correctly, I think what he is saying is ext3
> does not scale very well when you have a large number of processes
> acessing file system because of locks in journal.    This is seen in
> the excessive idle time.  By comparison, ext2 does not have this
> issue.

Ext3 does not use flock() in order to lock its journal. The performance
issues that he is seeing may well be due to the journalling, but that
has nothing to do with flock_lock_file_wait.

Cheers,
  Trond

