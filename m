Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274352AbRITHGA>; Thu, 20 Sep 2001 03:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274353AbRITHFv>; Thu, 20 Sep 2001 03:05:51 -0400
Received: from t2.redhat.com ([199.183.24.243]:22257 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274352AbRITHFh>; Thu, 20 Sep 2001 03:05:37 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Thu, 20 Sep 2001 04:07:02 +0200." <20010920040702.J720@athlon.random> 
Date: Thu, 20 Sep 2001 08:05:57 +0100
Message-ID: <8353.1000969557@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli <andrea@suse.de> wrote:
> yes, one solution to the latency problem without writing the
> ugly code would be simply to add a per-process counter to pass to a
> modified rwsem api, then to hide the trickery in a mm_down_read macro.
> such way it will be recursive _and_ fair.

You'd need a counter per-process per-mm_struct. Otherwise you couldn't do a
recursive read lock simultaneously in two or more different processes, and
also allow any one process to lock multiple mm_structs.

David
