Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274871AbRIVCOU>; Fri, 21 Sep 2001 22:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274890AbRIVCOK>; Fri, 21 Sep 2001 22:14:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36558 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274871AbRIVCOH>;
	Fri, 21 Sep 2001 22:14:07 -0400
Date: Fri, 21 Sep 2001 22:14:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Fuller <rfuller@nsisoftware.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <m1wv2t7y18.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0109212151590.9760-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Sep 2001, Eric W. Biederman wrote:

> Swapping is an important case.  But 9 times out of 10 you are managing
> memory in caches, and throwing unused pages into swap.  You aren't busily
> paging the data back an forth.  But if I have to make a choice in
> what kind of situation I want to take a performance hit, paging
> approaching thrashing or a system whose working set size is well
> within RAM.  I'd rather take the hit in the system that is paging.

It means that you prefer system dying under much lighter load.  At some
point any box will get into feedback loop, when slowdown from VM load
will make request handling slower, which will make temp. allocations
needed to handle these requests to be kept around for longer periods,
which will contribute to VM load.  The question being, at which point
will it happen and how graceful will the degradation be when we get
near that point.

