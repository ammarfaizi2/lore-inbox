Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271687AbRIGKl3>; Fri, 7 Sep 2001 06:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271690AbRIGKlT>; Fri, 7 Sep 2001 06:41:19 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:27572 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271687AbRIGKlG>;
	Fri, 7 Sep 2001 06:41:06 -0400
Date: Fri, 07 Sep 2001 11:35:28 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Helge Hafting <helgehaf@idb.hist.no>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: page pre-swapping + moving it on cache-list
Message-ID: <1432630138.999862528@[169.254.198.40]>
In-Reply-To: <3B989E46.51C1E768@idb.hist.no>
In-Reply-To: <3B989E46.51C1E768@idb.hist.no>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge,

> somehow I don't think garbage collection runs will be that fun
> in a trashing situation.

Quite possibly

> Don't these algorithms look all over
> your stack & heap for pointers? That will surely cause lots
> of io as all the apps memory is paged in so the gc algorithm
> may look at it.

No - it would look through things like the free area
table, the buddy bitmaps, the page table & lists etc., all
of which are, of course, in kernel memory. So while
it may do unfortunate things to the cache, it doesn't
need to touch application memory in order to determine
which pages to twiddle with. Of course twiddling the
pages themselves requires access to them, but if they
are out on disk already they consume (or, if on
InactiveClean, could consume) no physical memory
so are the least of our problems w.r.t. memory
defragmentation.

--
Alex Bligh
