Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSHLJkX>; Mon, 12 Aug 2002 05:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSHLJkX>; Mon, 12 Aug 2002 05:40:23 -0400
Received: from dsl-213-023-043-075.arcor-ip.net ([213.23.43.75]:12456 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317622AbSHLJkW>;
	Mon, 12 Aug 2002 05:40:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Date: Mon, 12 Aug 2002 11:45:32 +0200
X-Mailer: KMail [version 1.3.2]
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
References: <3D5464E3.74ED07CC@zip.com.au> <Pine.LNX.4.44.0208091813470.1165-100000@home.transmeta.com> <20020812174530.398156a1.rusty@rustcorp.com.au>
In-Reply-To: <20020812174530.398156a1.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17eBlU-0001nX-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 August 2002 09:45, Rusty Russell wrote:
> On Fri, 9 Aug 2002 18:33:09 -0700 (PDT)
> Linus Torvalds <torvalds@transmeta.com> wrote:
> > 	repeat:
> > 		kmap_atomic(..); // this increments preempt count
> > 		nr = copy_from_user(..);
> 
> Please please please use a different name for "I know I'm not preemptible but
> I can handle it" or a flag or something.
> 
> That leaves us with the possibility of a BUG() in the "normal" copy_to/from_user
> for all those "I'm holding a spinlock while copying to userspace wheeee!" bugs.
> Very common mistake for new kernel authors.

That's the whole point of this: it's not a bug anymore.  (It's a feature.)

But agreed, a different name than preempt count would be nice, because it's
evolving away from its original function.  Is this a 'monitor'?  (I don't
think so.)  Perhaps 'atomic_count' is more accurate.

-- 
Daniel
