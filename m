Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVDICSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVDICSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 22:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVDICSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 22:18:50 -0400
Received: from mail.dif.dk ([193.138.115.101]:62353 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261258AbVDICSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 22:18:47 -0400
Date: Sat, 9 Apr 2005 04:21:18 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Paul Jackson <pj@engr.sgi.com>, Pekka J Enberg <penberg@cs.helsinki.fi>,
       jengelh@linux01.gwdg.de, penberg@gmail.com, rlrevell@joe-job.com,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <Pine.LNX.4.62.0503302105320.2463@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0504090417390.2455@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
 <1111881955.957.11.camel@mindpipe> <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
 <20050327065655.6474d5d6.pj@engr.sgi.com> <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
 <20050327174026.GA708@redhat.com> <1112064777.19014.17.camel@mindpipe>
 <84144f02050328223017b17746@mail.gmail.com> <Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>
 <courier.42490293.000032B0@courier.cs.helsinki.fi> <20050329184411.1faa71eb.pj@engr.sgi.com>
 <Pine.LNX.4.62.0503302105320.2463@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Jesper Juhl wrote:

> On Tue, 29 Mar 2005, Paul Jackson wrote:
> 
> > Pekka wrote:
> > >  (4) The cleanups Jesper and others are doing are to remove the
> > >      _redundant_ NULL checks (i.e. it is now checked twice). 
> > 
> > Even such obvious changes as removing redundant checks doesn't
> > seem to ensure a performance improvement.  Jesper Juhl posted
> > performance data for such changes in his microbenchmark a couple
> > of days ago.
> > 
> > As I posted then, I could swear that his numbers show:
> > 
> > > Just looking at the third run, it seems to me that "if (likely(p))
> > > kfree(p);" beats a naked "kfree(p);" everytime, whether p is half
> > > NULL's, or very few NULL's, or almost all NULL's.
> > 
> > Twice now I have asked Jesper to explain this strange result.
> > 
> I've been kept busy with other things for a while and haven't had the time 
> to reply to your emails, sorry.   As I just said in another post I don't 
> know how valid my numbers are, but I'll try and craft a few more tests to 
> see if I can get some more solid results.
> 
> > 
> > Maybe we should be following your good advice:
> > 
> > > You don't know that until you profile! 
> > 
> > instead of continuing to make these code changes.
> > 
> I'll gather some more numbers and post them along with any conclusions I 
> believe can be drawn from them within a day or two, untill then I'll hold 
> back on the patches...
> 
Ok, I never got around to doing some more benchmarks, mainly since it 
seems that people converged on the oppinion that the kfree() cleanups are 
OK and we can fix up any regressions by inlining kfree if needed (the 
difference these changes make to performance seem to be small and in the 
noice anyway).
If anyone would /like/ me to do more benchmarks, then speak up and I will 
do them - I guess I could also build a kernel with an inline kfree() as a 
comparison.. but, unless someone speaks up I'll just carry on making these 
kfree() cleanups and not bother with benchmarks...


-- 
Jesper


