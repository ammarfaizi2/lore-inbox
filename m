Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293286AbSCEB4u>; Mon, 4 Mar 2002 20:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293299AbSCEB4l>; Mon, 4 Mar 2002 20:56:41 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24002 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293286AbSCEB4b>; Mon, 4 Mar 2002 20:56:31 -0500
Date: Mon, 04 Mar 2002 17:55:03 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Matt Dobson <colpatch@us.ibm.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <265890000.1015293303@flay>
In-Reply-To: <20020305024046.Y20606@dualathlon.random>
In-Reply-To: <20020305020546.W20606@dualathlon.random> <Pine.LNX.4.44L.0203042225340.2181-100000@imladris.surriel.com> <20020305024046.Y20606@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it's not more complex than the current way, it's just different and it's
> not strict, but it's the best one for allocations that doesn't "prefer"
> memory from a certain node, but OTOH we don't have an API to define
> 'waek' or 'strict' allocation bheaviour so the default would better be
> the 'strict' one like in oldnuma. Infact in the future we may want to
> have also a way to define a "very strict" allocation, that means it
> won't fallback into the other nodes at all, even if there's plenty of
> memory free on them.  An API needs to be built with some bitflag
> specifying the "strength" of the numa affinity required. Your layout
> provides the 'weakest' approch, that is perfectly fine for some kind of
> non-numa-aware allocations, just like "very strict" will be necessary
> for the relocation bindings (if we cannot relocate in the right node
> there's no point to relocate in another node, let's ingore complex
> topologies for now :).

Actually, we (IBM) do have a simple API to do this that Matt Dobson 
has been working on that's nearing readiness (& publication). I've 
been coding up a patch to _alloc_pages today that has both a strict 
and non-strict binding in it. It first goes through your "preferred" set of 
nodes (defined on a per-process basis), then again looking for any 
node that you've not strictly banned from the list - I hope that's 
sufficient for what you're discussing? I'll try to publish my part tommorow, 
definitely this week - it'll be easy to see how it works in conjunction with 
the API, though the rest of the API might be a little longer before arrival ....

Martin.

