Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281241AbRKPIe1>; Fri, 16 Nov 2001 03:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281242AbRKPIeR>; Fri, 16 Nov 2001 03:34:17 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:20498 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281241AbRKPIeM>; Fri, 16 Nov 2001 03:34:12 -0500
Message-ID: <3BF4CF5C.18CBE4BC@zip.com.au>
Date: Fri, 16 Nov 2001 00:33:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: synchronous mounts
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au> <20011115214525.C14221@redhat.com> <3BF45B9F.DEE1076B@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> As it stands, it seems like redefining 'sync' to sync less data than is
> currently done is not only changing current behavior, but providing less
> to users overall.
> 

Persuasively argued.  You appear to have your wish, as this
patch was merged in -pre5.

A `dirsync' option does make sense though, for the reasons which
Stephen outlined.

The whole handling of synchronous operations needs a rip-up-and-rewrite
anyway.  We're currently holding onto a stack of locks while waiting
for the disk to spin round and round.  It's a great scalability bottleneck
for multiple threads doing things in the same directory.   This is
something I shall look at when the kernel versions turn odd.

-
