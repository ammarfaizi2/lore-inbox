Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273464AbRIUMBy>; Fri, 21 Sep 2001 08:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRIUMBo>; Fri, 21 Sep 2001 08:01:44 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58129 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273455AbRIUMBd>;
	Fri, 21 Sep 2001 08:01:33 -0400
Date: Fri, 21 Sep 2001 09:01:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Fuller <rfuller@nsisoftware.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <m1wv2t7y18.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0109210859390.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Sep 2001, Eric W. Biederman wrote:

> Swapping is an important case.  But 9 times out of 10 you are managing
> memory in caches, and throwing unused pages into swap.  You aren't
> busily paging the data back an forth.  But if I have to make a choice
> in what kind of situation I want to take a performance hit, paging
> approaching thrashing or a system whose working set size is well
> within RAM.  I'd rather take the hit in the system that is paging.

> Besides I also like to run a lot of shell scripts, which again stress
> the fork()/exec()/exit() path.
>
> So no I don't think keeping those paths fast is silly.

Absolutely agreed.

Ben and I have already been thinking a bit about memory
objects, so we have both reverse mappings AND we can skip
copying the page tables at fork() time (needing to clear
less at the subsequent exec(), too) ...

Of course this means I'll throw away my pte-based reverse
mapping code and will look at an object-based reverse mapping
scheme like Ben made for 2.1 and DaveM made for 2.3 ;)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

