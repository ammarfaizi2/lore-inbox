Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272773AbRIPUR7>; Sun, 16 Sep 2001 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272777AbRIPURu>; Sun, 16 Sep 2001 16:17:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5393 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272773AbRIPURf>;
	Sun, 16 Sep 2001 16:17:35 -0400
Date: Sun, 16 Sep 2001 17:17:37 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <9o2vct$889$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109161707280.21279-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Linus Torvalds wrote:

> The fact that the "use-once" logic didn't kick in is the problem. It's
> hard to tell _why_ it didn't kick in, possibly because the MP3 player
> read small chunks of the pages (touching them multiple times).

It's probably because it used mmap(), all mp3 players seem
to do that. If they also use MADV_SEQUENTIAL, I guess it'd
be easy to also do drop_behind on them, though...

> THAT is worth looking into. But blathering about "reverse mappings
> will help this" is just incredibly stupid. You seem to think that they
> are a panacea for all problems,

Absoluteley not, all reverse mappings allow us is an easier
framework to get the other decisions right. By implementing
_just_ the reverse mappings and leaving the other stuff the
same I've already found my desktop to be more usable. This
seems to be the effect of the fact that reverse mappings
allow us to get page aging right because we see all referenced
bits on a page. If you think we can do this without reverse
mappings I only have to point at linux 1.2, 2.0, 2.2 and 2.4
as a suggestion to the contrary. If it was possible, surely we
would have succeeded in 7 years of trying ?

Add to that the fact that reverse mappings makes it trivial to
do things like defragmenting memory a bit to make sure fork()
succeeds or sparc64 users can allocate page tables or being
able to keep the page tables mapped until the page is cleaned
in page_launder() (reducing soft page faults) or doing a physical
page scan to deal with gross imbalance between memory zones and
we'll have something which, IMHO, is worth experimenting with.

Sure, reverse mappings also have disadvantages, like one pointer
extra in the page_struct or as much as 2 pointers per mapping
for shared pages and a slight complication of the locking, but
I'm not convinced that these disadvantages are so severe we should
continue the VM the same way we failed to make it work right the
last 7 years.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

