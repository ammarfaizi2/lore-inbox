Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbTLFTvM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTLFTvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:51:12 -0500
Received: from tantale.fifi.org ([216.27.190.146]:55448 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S265746AbTLFTu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:50:57 -0500
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS client] NFS locks not released on abnormal process termination
References: <20031206044852.26806.qmail@web20021.mail.yahoo.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 06 Dec 2003 11:50:55 -0800
In-Reply-To: <20031206044852.26806.qmail@web20021.mail.yahoo.com>
Message-ID: <87n0a5sp28.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Simpson <theonetruekenny@yahoo.com> writes:

> I have a up-to-date RH9 (kernel 2.4.20-24.9, nfs utils 1.0.1-3.9) I'm using as
> an NFS client (the server is a NetApp), and I'm trying to use advisory locking
> of a file.
> If the process that locks the file exits normally, the lock is released, and
> everything is fine.
> However, if the process aborts, the lock is left with no clear way to remove
> it.  I must remove the file to get rid of the lock.
> 
> Details:
> Here is a test case:
> int main()
> {
>   int fd = open("file", O_RDWR);
>   if (lockf( fd, F_TLOCK, 0 ) < 0)
> ....  print error message query owner
>   pause();
>   close( fd );
> }
> 
> If I run this, when it gets to the pause(), I can clearly see in /proc/locks
> the process owning the lock.
> If I then kill -ABRT <pid>, the entry in /proc/locks goes away, but the lock is
> not removed from the server.
> When I run the program a second time, the lock acquire failes, and it says the
> (now defunct) old process still owns the lock.  Since I cannot easily make
> another process with the id of the original, I seem to have no way to
> explicitly release the lock.

I've also seen this behavior witht the stock 2.4.22 and 2.4.23
kernels.

See the thread:

 http://sourceforge.net/mailarchive/forum.php?thread_id=3213117&forum_id=4930
 
 
> I even ran ethereal to watch which NLM requests were being made.  No unlock
> request was ever sent, so I don't think this can be a server issue.
> 
> Any ideas?  Is it supposed to work this way?

No and no.

Phil.
