Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbUKFKxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbUKFKxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUKFKxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:53:09 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:53980 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261363AbUKFKxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:53:05 -0500
Message-ID: <418CAD0C.3030109@cyberone.com.au>
Date: Sat, 06 Nov 2004 21:53:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrea Arcangeli <andrea@novell.com>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages /    all_unreclaimable
 braindamage
References: <Pine.LNX.4.44.0411060944150.2721-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0411060944150.2721-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hugh Dickins wrote:

>On Sat, 6 Nov 2004, Andrea Arcangeli wrote:
>
>>all allocations should have a failure path to avoid deadlocks. But in
>>the meantime __GFP_REPEAT is at least localizing the problematic places ;)
>>
>
>Problematic, yes: don't overlook that GFP_REPEAT and GFP_NOFAIL _can_
>fail, returning NULL: when the process is being OOM-killed (PF_MEMDIE).
>
>

Yeah right you are. I think NOFAIL is a bug and should really not fail.
It looks like it is only used in fs/jbd/*, and things will crash if it
fails. Maybe they're only called from the kjournald threads and can't
be OOM killed, but that is still a pretty subtle dependancy.

