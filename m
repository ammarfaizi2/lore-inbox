Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264515AbRFUBo2>; Wed, 20 Jun 2001 21:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264523AbRFUBoS>; Wed, 20 Jun 2001 21:44:18 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:35553 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264515AbRFUBoI>; Wed, 20 Jun 2001 21:44:08 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mike Castle" <dalgoda@ix.netcom.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Why use threads ( was: Alan Cox quote?)
Date: Wed, 20 Jun 2001 18:43:52 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKMEOMPPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20010620154319.A15561@thune.mrc-home.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jun 20, 2001 at 03:18:58PM -0700, David Schwartz wrote:

> > 	As I said, you don't want to use one thread for each
> > client. You use, say,
> > 10 threads for the 16,000 clients. That way, if an occasional client
> > ambushes a thread (say by reading a file off an NFS server or
> > by using some
> > infrequently used code that was swapped to a busy disk), your
> > server will
> > keep on humming.

> This same approach can easily be used by multiple processes.

	Theoretically, pretty much everything you can do with a thread pool
architecture can be done with a process pool architecture. Sharing file
descriptors can be much harder. Some thread architectures (notably pthreads)
go out of their way to make some things hard for thread pools (like try
implementing Samba, since all the threads share there uids). But this is
more about bad threading specifications and implementations than threading
itself.

> I don't see what is gained by using threads over processes for such an
> architecture.

	I'll flip this back at you and ask you what's gained by using processes
over threads. It's certainly more difficult to implement a process pool
architecture than a thread pool architecture. Theoretically, performance for
a thread pool architecture will be slightly better (on some architectures at
least) due to the identical vm views.

	With a process pool architecture, you might have more control over what you
share. But this doesn't actually gain you anything because as long as you
share more than a small amount, you still have to consider your entire
environment tainted if one execution vehicle goes out of control.

	I would be very interested in seeing, for example, a web server based on a
'process pool' design. Does anybody know of any?

	DS

