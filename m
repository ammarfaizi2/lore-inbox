Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289757AbSA2Q5y>; Tue, 29 Jan 2002 11:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289761AbSA2Q5o>; Tue, 29 Jan 2002 11:57:44 -0500
Received: from waste.org ([209.173.204.2]:60102 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289757AbSA2Q52>;
	Tue, 29 Jan 2002 11:57:28 -0500
Date: Tue, 29 Jan 2002 10:57:04 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33L.0201290859040.32617-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0201291044060.25443-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Rik van Riel wrote:

> On Mon, 28 Jan 2002, Oliver Xymoron wrote:
>
> > Somewhere in here, the pages have got to all be marked read-only or
> > something. If they're not, then either parent or child writing to
> > non-faulting addresses will be writing to shared memory.
>
> Either that, or we don't populate the page tables of the
> parent and the child at all and have the page tables
> filled in at fault time.

That's very nearly what I proposed in the second half of my message (with
the exception that we ought to pre-fault the current stack and code page
tables as we're sure to need these immediately).

Daniel's approach seems to be workable (once he's spelled out all the
details) but it misses the big performance win for fork/exec, which is
surely the common case. Given that exec will be throwing away all these
mappings, we can safely assume that we will not be inheriting many shared
mappings from parents of parents so Daniel's approach also still ends up
marking most of the pages RO still.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

