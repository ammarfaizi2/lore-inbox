Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSE0ShK>; Mon, 27 May 2002 14:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316581AbSE0ShJ>; Mon, 27 May 2002 14:37:09 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:16579 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S316580AbSE0ShI>; Mon, 27 May 2002 14:37:08 -0400
Date: Mon, 27 May 2002 11:37:06 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: ehci-hcd on CARDBUS hangs when stopping card service
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Cc: linux-kernel@vger.kernel.org
Message-id: <3CF27CD2.8040907@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <6134254DE87BD411908B00A0C99B044F02E89AF7@mowd019a.mow.siemens.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Borsenkow Andrej wrote:
> 
> It looks like discussion is focused on a problem how to detect a removed
> card.

Well, there are two issues.  That's a kind of "dirty shutdown" case, for
which there's a clear need to update the EHCI driver.  I'm working on
a fix for it, presumably someone can help test the patch.


 > While this problem definitely exists - I'd like to stress that the
> original report was about a normal shutdown case. Just do init 0 with
> card plugged in and system hangs. IMHO that should be dealt with in the
> first place.

... and that's the "clean shutdown" case, where it seems like the
CardBus code in the 2.4 kernels is clearly doing the wrong thing:
an operation sequence turns those into a dirty shutdown.  (Which
then trip over the EHCI "dirty shutdown" problem.)

It'd be nice if someone were to work on fixing that CardBus problem
too, since it's likely it'll break other drivers.  The fact that
nobody has stepped in there is why the discussion went the direction
it did ... :)

- Dave


