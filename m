Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVC3Cre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVC3Cre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 21:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVC3Crd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 21:47:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42172 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261721AbVC3Cr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 21:47:27 -0500
Date: Tue, 29 Mar 2005 18:44:11 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Cc: jengelh@linux01.gwdg.de, penberg@gmail.com, rlrevell@joe-job.com,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
Message-Id: <20050329184411.1faa71eb.pj@engr.sgi.com>
In-Reply-To: <courier.42490293.000032B0@courier.cs.helsinki.fi>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	<1111825958.6293.28.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	<Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	<1111881955.957.11.camel@mindpipe>
	<Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
	<20050327065655.6474d5d6.pj@engr.sgi.com>
	<Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
	<20050327174026.GA708@redhat.com>
	<1112064777.19014.17.camel@mindpipe>
	<84144f02050328223017b17746@mail.gmail.com>
	<Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>
	<courier.42490293.000032B0@courier.cs.helsinki.fi>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka wrote:
>  (4) The cleanups Jesper and others are doing are to remove the
>      _redundant_ NULL checks (i.e. it is now checked twice). 

Even such obvious changes as removing redundant checks doesn't
seem to ensure a performance improvement.  Jesper Juhl posted
performance data for such changes in his microbenchmark a couple
of days ago.

As I posted then, I could swear that his numbers show:

> Just looking at the third run, it seems to me that "if (likely(p))
> kfree(p);" beats a naked "kfree(p);" everytime, whether p is half
> NULL's, or very few NULL's, or almost all NULL's.

Twice now I have asked Jesper to explain this strange result.

I have heard no explanation (not even a terse "you idiot ;)"),
nor anyone else comment on these numbers.

Maybe we should be following your good advice:

> You don't know that until you profile! 

instead of continuing to make these code changes.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
