Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288802AbSANGSJ>; Mon, 14 Jan 2002 01:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288809AbSANGSA>; Mon, 14 Jan 2002 01:18:00 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:37905 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288802AbSANGRo>;
	Mon, 14 Jan 2002 01:17:44 -0500
Date: Mon, 14 Jan 2002 04:17:31 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <m13d19qy9f.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0201140409260.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 2002, Eric W. Biederman wrote:
> Rik van Riel <riel@conectiva.com.br> writes:

> Rik while you are looking at your reverse mapping code, I would like
> to call to your attention the at least trippling of times for fork.

Dave McCracken has measured this on his system, it seems to vary
from between 10% for bash to 400% for a process with 10 MB of memory.

This is a problem which will need to be solved, a number of designs
on how to deal with this are ready, implementation needs to be done.

> I wouldn't be surprised if the reason your rmap vm handles things like
> gcc -j better than the stock kernel is simply the reduced number of
> processes, due to slower forking.

I really doubt this, since gcc spends so much more time doing
real work than forking that the time used in fork can be ignored,
even if it gets 3 times slower.

> Just my 2 cents so we don't forget the caveats of the reverse map
> approach.

The main way we can speed up fork easily is by not copying the
page tables at all at fork time but filling them in later at page
fault time. While this might look like it's just moving the overhead
from one place to another, but for the typical fork()+exec() case it
means (1) we don't copy the page tables at fork time (2) we don't
need to free them at exec time (3) after the exec, the parent can
just take back the complete page tables without having to take COW
faults on all its pages.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

