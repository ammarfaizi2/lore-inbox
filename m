Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264197AbUFRAFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbUFRAFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbUFRAFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:05:23 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:45318 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S264197AbUFRAFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:05:13 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Using kernel headers that are not for the running kernel
Date: Thu, 17 Jun 2004 17:04:30 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMECEMLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 17 Jun 2004 16:42:17 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 17 Jun 2004 16:42:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a little distro that I am trying to upgrade to 2.6.x.

	Okay.

> The problem is that when I use the headers for 2.6.x, glibc 2.2.5 won't
> compile.  Eventually I want to upgrade glibc/gcc, but not at the moment.
> If I use the headers from 2.4.26 for the system, but just compile the
> 2.6.7 kernel, things do compile fine for everything.

	You should not be using the kernel headers to compile glibc.

> This distro is small, and I can rebuild the entire thing in about 90 mins,
> so if I change the kernel (or really anything that has other deps), I just
> rebuild the entire thing to make sure everything is in sync.

	The running kernel should not be in sync with glibc.

> I see that a lot of distros use a separate package for the kernel headers,
> which do not necessarily coincide with the running kernel.

	Right, there is no reason they should.

> I am wondering what (if any) are the side effects of doing this are,
> especially when the kernel versions are so different.  I was thinking that
> there may be issues with some progs if the prototypes for certain kernel
> functions weren't the same.  However people are doing it and it does seem
> to work, but I am wondering how it fends for stability.

	It creates a stable system. Things become much less stable if you mess
around with all of userspace just because the kernel changes. There is no
reason user space should be in sync with the running kernel. User space
should be stable.

	The later the kernel headers you use in user space, the less compatability
you will have with earlier kernels. A program compiled with 2.4.26 header
files should work with 2.6.x, but not vice versa. When new kernel interfaces
are added, the old ones are retained to keep compatability with user space,
but programs compiled against the newer headers may fail to work with older
kernels that lack the newer interfaces. Of course, user space programs
compiled against the older kernel header files can't get the advantages of
the newer interfaces.

	The kernel-user interface is supposed to stay stable, so you shouldn't need
to make significant user space changes when you upgrade the kernel. Only
specific applications that need to get specific new features that require
changes to the kernel-user interface need to change. It has been a very long
time since compiling user space programs against the header files for the
kernel you happened to be running was considered good practice.

	DS


