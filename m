Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752157AbWCOXWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbWCOXWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbWCOXWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:22:17 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:14234 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752156AbWCOXWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:22:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IYOxUvlHvuEbLsOJd2SJmcRum0gS90AbKAGt2uk/srPysxlQFPTw1VKQZwtXodcEg1VsQlqsCLqsay9Tb5gOOd751GxLVmnAMqvtSFGUvTc+ZNk0kFiCaQil4IhVGMMudwqkGhub+bHtVqjRwjmEYpn9RPrLXZe8zyDdKjWzMmk=  ;
Message-ID: <4418A191.5010108@yahoo.com.au>
Date: Thu, 16 Mar 2006 10:21:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <4417FFC2.8040909@yahoo.com.au>  <44110E93.8060504@yahoo.com.au> <16835.1141936162@warthog.cambridge.redhat.com> <14886.1142421018@warthog.cambridge.redhat.com> <17625.1142430454@warthog.cambridge.redhat.com>
In-Reply-To: <17625.1142430454@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>
>>>Ah, but if the cache is on the CPU side of the dotted line, does that then
>>>mean that a write memory barrier guarantees the CPU's cache to have
>>>updated memory?
>>>
>>I don't think it has to[*]. It would guarantee the _order_ in which "global
>>memory" of this model ie. visibility for other "CPUs" see the writes,
>>whether that visibility ultimately be implemented by cache coherency
>>protocol or something else, I don't think matters (for a discussion of
>>memory ordering).
>>
>
>It does matter, because I have to make it clear that the effect of the memory
>barrier usually stops at the cache, and in fact memory barriers may have no
>visibility at all on another CPU because it's all done inside a CPU's cache,
>until that other CPU tries to observe the results.
>
>

But that's a cache coherency issue that is really orthogonal to the memory
consistency one. WHY, when explaining memory consistency, do they need to
know that a barrier "usually stops at cache" (except for alpha)?

They already _know_ that barriers may have no visibility on any other CPU
because you should tell them that barriers only imply an ordering over the
horizon, nothing more (ie. they need not imply a "push").

>>If anything it confused the matter for the case of Alpha.
>>
>
>Nah... Alpha is self-confusing:-)
>
>

Well maybe ;) But for better or worse, it is what kernel programmers now 
have to
deal with.

>>All the programmer needs to know is that there is some horizon (memory)
>>beyond which stores are visible to other CPUs, and stores can travel there
>>at different speeds so later ones can overtake earlier ones. And likewise
>>loads can come from memory to the CPU at different speeds too, so later
>>loads can contain earlier results.
>>
>
>They also need to know that memory barriers don't imply an ordering on the
>cache.
>
>

Why? I'm contending that this is exactly what they don't need to know.

>>[*] Nor would your model require a smp_wmb() to update CPU caches either, I
>>think: it wouldn't have to flush the store buffer, just order it.
>>
>
>Exactly.
>
>But in your diagram, given that it doesn't show the cache, you don't know that
>the memory barrier doesn't extend through the cache and all the way to memory.
>
>

What do you mean "extend"? I don't think that is good terminology. What 
it does is
provide an ordering of traffic going over the vertical line dividing CPU 
and memory.
It does not matter whether "memory" is actually "cache + coherency" or 
not, just
that the vertical line is the horizon between "visible to other CPUs" 
and "not".

Nick
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
