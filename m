Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSHLIR1>; Mon, 12 Aug 2002 04:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSHLIR0>; Mon, 12 Aug 2002 04:17:26 -0400
Received: from dp.samba.org ([66.70.73.150]:6889 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317482AbSHLIR0>;
	Mon, 12 Aug 2002 04:17:26 -0400
Date: Mon, 12 Aug 2002 17:45:30 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Message-Id: <20020812174530.398156a1.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0208091813470.1165-100000@home.transmeta.com>
References: <3D5464E3.74ED07CC@zip.com.au>
	<Pine.LNX.4.44.0208091813470.1165-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2002 18:33:09 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:

> 	repeat:
> 		kmap_atomic(..); // this increments preempt count
> 		nr = copy_from_user(..);

Please please please use a different name for "I know I'm not preemptible but
I can handle it" or a flag or something.

That leaves us with the possibility of a BUG() in the "normal" copy_to/from_user
for all those "I'm holding a spinlock while copying to userspace wheeee!" bugs.
Very common mistake for new kernel authors.

With the preempt count we have an easy way of detecting this at runtime: I'd
like to keep that.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
