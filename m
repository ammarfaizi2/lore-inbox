Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbTIDUE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbTIDUE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:04:57 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:60812 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264904AbTIDUEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:04:55 -0400
Date: Thu, 4 Sep 2003 21:04:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030904200426.GB31590@mail.jlokier.co.uk>
References: <20030904183819.GF30394@mail.jlokier.co.uk> <Pine.LNX.4.44.0309041144110.6676-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309041144110.6676-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> >   * I contend that the user-visible behaviour of a mapping should
> >   * _not_ depend on whether the file was opened with O_RDWR or O_RDONLY.
> 
> And I violently agree. But I also add the _other_ requirement:
> 
>  * I contend that user-visible behaviour of a mapping should be 100% the 
>  * same for a unwritable MAP_SHARED and a unwritten MAP_PRIVATE
> 
> Put the two together, and see what you get. You get the requirement that 
> if MAP_SHARED works, then MAP_PRIVATE also has to work.

I'll add three more conditions to be explicit:

    * A futex on a MAP_PRIVATE must be mm-local: the canonical
    * example being MAP_PRIVATE of /dev/zero.

    * A FUTEX_WAIT on an unwritten mapping should be woken by a
    * FUTEX_WAKE to the same address after writing.

    * A FUTEX_WAIT on a read-only mapping should wait for the same
    * thing from other processes as if it were a writable mapping.

> That's my requirement. Consistency.

Unfortunately I think the above 5 conditions do not have a consistent
solution.  Please prove me wrong :)

-- Jamie
