Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313220AbSDOUin>; Mon, 15 Apr 2002 16:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313224AbSDOUim>; Mon, 15 Apr 2002 16:38:42 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:15628 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313220AbSDOUil>; Mon, 15 Apr 2002 16:38:41 -0400
Message-ID: <3CBB3A41.8E94C8A@zip.com.au>
Date: Mon, 15 Apr 2002 13:38:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] writeback daemons
In-Reply-To: <3CB3DE1E.5F811D77@zip.com.au> <20020408203839.C540@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > The number of threads is dynamically managed by a simple
> > demand-driven algorithm.
> 
> So... when we are low on free memory, we try to create more threads... Possible
> deadlock?

Nope.  The number of threads is never allowed to fall below two,
for this very reason.

If the machine is super-low on memory, attempts to start more threads
fail (usually due to the 1-order allocation for the kernel stack).
I've seen this happen.  But the existing two threads are safe,
and that's plenty to get the machine out of trouble.

-
