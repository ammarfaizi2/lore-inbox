Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVC3TI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVC3TI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVC3TIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:08:52 -0500
Received: from mail.dif.dk ([193.138.115.101]:679 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262409AbVC3TIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:08:10 -0500
Date: Wed, 30 Mar 2005 21:10:14 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, jengelh@linux01.gwdg.de,
       penberg@gmail.com, rlrevell@joe-job.com, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <20050329184411.1faa71eb.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0503302105320.2463@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
 <1111881955.957.11.camel@mindpipe> <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
 <20050327065655.6474d5d6.pj@engr.sgi.com> <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
 <20050327174026.GA708@redhat.com> <1112064777.19014.17.camel@mindpipe>
 <84144f02050328223017b17746@mail.gmail.com> <Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>
 <courier.42490293.000032B0@courier.cs.helsinki.fi> <20050329184411.1faa71eb.pj@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005, Paul Jackson wrote:

> Pekka wrote:
> >  (4) The cleanups Jesper and others are doing are to remove the
> >      _redundant_ NULL checks (i.e. it is now checked twice). 
> 
> Even such obvious changes as removing redundant checks doesn't
> seem to ensure a performance improvement.  Jesper Juhl posted
> performance data for such changes in his microbenchmark a couple
> of days ago.
> 
> As I posted then, I could swear that his numbers show:
> 
> > Just looking at the third run, it seems to me that "if (likely(p))
> > kfree(p);" beats a naked "kfree(p);" everytime, whether p is half
> > NULL's, or very few NULL's, or almost all NULL's.
> 
> Twice now I have asked Jesper to explain this strange result.
> 
I've been kept busy with other things for a while and haven't had the time 
to reply to your emails, sorry.   As I just said in another post I don't 
know how valid my numbers are, but I'll try and craft a few more tests to 
see if I can get some more solid results.

> 
> Maybe we should be following your good advice:
> 
> > You don't know that until you profile! 
> 
> instead of continuing to make these code changes.
> 
I'll gather some more numbers and post them along with any conclusions I 
believe can be drawn from them within a day or two, untill then I'll hold 
back on the patches...


-- 
Jesper Juhl


