Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271498AbRHZTj7>; Sun, 26 Aug 2001 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271501AbRHZTjt>; Sun, 26 Aug 2001 15:39:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:23056 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271498AbRHZTjh>;
	Sun, 26 Aug 2001 15:39:37 -0400
Date: Sun, 26 Aug 2001 16:38:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826125911.A20805@hq2>
Message-ID: <Pine.LNX.4.33L.0108261632520.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Victor Yodaiken wrote:

> And scheduling gets even more complex as we try to account for work
> done in this thread on behalf of other processes. And, of course, we
> have all sorts of wacky merge problems

Actually, readahead is always done by the thread reading
the data, so this is not an issue.

> BTW: maybe I'm oversimplifying, but since read-ahead is an optimization
> trading memory space for time, why doesn't it just turn off when there's
> a shortage of free memory?
> 		num_pages = (num_requestd_pages +  (there_is_a_boatload_of_free_space? readahead: 0)

When the VM load is high, the last thing you want to do is
shrink the size of your IO operations, this would only lead
to more disk seeks and possibly thrashing.

It would be nice to do something similar to TCP window
collapse for readahead, though...

This would work by increasing the readahead size every
time we reach the end of the last readahead window without
having to re-read data twice and collapsing the readahead
window if any of the pages we read in have to be read
twice before we got around to using them.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

