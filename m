Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVC0Wyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVC0Wyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVC0Wyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:54:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:3503 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261616AbVC0Wyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:54:51 -0500
Date: Mon, 28 Mar 2005 00:56:53 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Dave Jones <davej@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pekka Enberg <penberg@gmail.com>,
       Paul Jackson <pj@engr.sgi.com>, rlrevell@joe-job.com,
       linux-os@analogic.com, Arjan van de Ven <arjan@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, Jesper Juhl <juhl-lkml@dif.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <20050327174026.GA708@redhat.com>
Message-ID: <Pine.LNX.4.62.0503280033130.2459@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
 <1111881955.957.11.camel@mindpipe> <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
 <20050327065655.6474d5d6.pj@engr.sgi.com> <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
 <20050327174026.GA708@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Mar 2005, Dave Jones wrote:

> Am I the only person who is completely fascinated by the
> effort being spent here micro-optimising something thats
> almost never in a path that needs optimising ?
> I'd be amazed if any of this masturbation showed the tiniest
> blip on a real workload, or even on a benchmark other than
> one crafted specifically to test kfree in a loop.
> 
> That each occurance of this 'optimisation' also saves a handful
> of bytes in generated code is it's only real benefit afaics.
> Even then, if a functions cache performance is better off because
> we trimmed a few bytes from the tail of a function, I'd be
> completely amazed.
> 

I agree, it's amazing that this is treated like a big issue, it's not, and 
I never meant for it to be a matter of such debate. 

The whole thing (viewed from where I'm sitting) started when I noticed a 
few of those redundant NULL checks while reading code, thought I'd clean 
them up since they were clearly not needed and submit those patches. When 
those patches then got merged I thought "ok, so this is something that's 
actually appreciated, guess I might as well do some more when I come 
across them or maybe even seek them out and get rid of them once and for 
all"... So I started doing that and more of the patches got merged which 
(at least to me) confirmed that it was a worthwhile activity, until at 
some point voices were raised in objection.

At that point I felt I needed to explain the "why" of why I was doing it 
and try and show that it might actually be a bennefit (and I believe the 
small test I wrote shows it to be either a bennefit in the usual case or 
at worst a trivial performance hit in the not-so-common case).
What I'm trying to find out now is if there's a general consensus that 
these patches are worthwile and wanted or if they are unwanted and I'm 
wasting my time.  If the patches are wanted I don't mind doing them, but 
if they are not wanted I don't want to waste my time (nor anyone elses) on 
them.  So, if I could just get peoples comment on that "wanted vs 
not-wanted" then I could get on with either producing some patches for 
people or get on with other things and drop this... Or I guess I could 
just go on making those patches, submit them and then just leave it in the 
hands of the individual maintainers (which was more or less how I started 
out)...


-- 
Jesper Juhl

