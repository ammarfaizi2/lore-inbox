Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275092AbRJAN6a>; Mon, 1 Oct 2001 09:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275094AbRJAN6U>; Mon, 1 Oct 2001 09:58:20 -0400
Received: from [200.203.199.88] ([200.203.199.88]:48391 "HELO netbank.com.br")
	by vger.kernel.org with SMTP id <S275092AbRJAN6L>;
	Mon, 1 Oct 2001 09:58:11 -0400
Date: Mon, 1 Oct 2001 10:57:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Load control  (was: Re: 2.4.9-ac16 good perfomer?)
In-Reply-To: <20011001111435Z16281-2757+2605@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0110011031050.4835-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Daniel Phillips wrote:

> Nice.  With this under control, another feature of his memory manager
> you could look at is the variable deactivation threshold, which makes
> a whole lot more sense now that the aging is linear.

Actually, when we get to the point where deactivating enough
pages is hard, we know the working set is large and we should
be _more careful_ in chosing what to page out...

When we go one step further, where the working set approaches
the size of physical memory, we should probably start doing
load control FreeBSD-style ... pick a process and deactivate
as many of its pages as possible. By introducing unfairness
like this we'll be sure that only one or two processes will
slow down on the next VM load spike, instead of all processes.

Once we reach permanent heavy overload, we should start doing
process scheduling, restricting the active processes to a
subset of all processes in such a way that the active processes
are able to make progress. After a while, give other processes
their chance to run.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

