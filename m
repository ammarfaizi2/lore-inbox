Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVC3OUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVC3OUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVC3OUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:20:30 -0500
Received: from mail.dif.dk ([193.138.115.101]:27008 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261909AbVC3OUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:20:17 -0500
Date: Wed, 30 Mar 2005 16:20:04 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: P Lavin <lavin.p@redpinesignals.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <424A51F5.1050501@redpinesignals.com>
Message-ID: <Pine.LNX.4.62.0503301612510.5933@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
            <1111825958.6293.28.camel@laptopd505.fenrus.org>           
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>           
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>           
 <1111881955.957.11.camel@mindpipe>           
 <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>           
 <20050327065655.6474d5d6.pj@engr.sgi.com>           
 <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>           
 <20050327174026.GA708@redhat.com>            <1112064777.19014.17.camel@mindpipe>
            <84144f02050328223017b17746@mail.gmail.com>           
 <Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>           
 <courier.42490293.000032B0@courier.cs.helsinki.fi>           
 <20050329184411.1faa71eb.pj@engr.sgi.com> <courier.424A43A5.00002305@courier.cs.helsinki.fi>
 <424A51F5.1050501@redpinesignals.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, P Lavin wrote:

> Date: Wed, 30 Mar 2005 12:45:01 +0530
> From: P Lavin <lavin.p@redpinesignals.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
> 
> Hi,
> In my wlan driver module, i allocated some memory using kmalloc in interrupt
> context, this one failed but its not returning NULL , 

kmalloc() should always return NULL if the allocation failed.


>so i was proceeding
> further everything was going wrong... & finally the kernel crahed. Can any one
> of you tell me why this is happening ? i cannot use GFP_KERNEL because i'm
> calling this function from interrupt context & it may block. Any other

If you need to allocate memory from interrupt context you should be using 
GFP_ATOMIC (or, if possible, do the allocation earlier in a different 
context).


> solution for this ?? I'm concerned abt why kmalloc is not returning null if
> its not a success ??
> 
I have no explanation for that, are you sure that's really what's 
happening?


> Is it not necessary to check for NULL before calling kfree() ??

No, it is not nessesary to check for NULL before calling kfree() since 
kfree() does    

void kfree (const void *objp)
{
	... 
        if (!objp)
                return;
	...
}

So, if you pass kfree() a NULL pointer it deals with it itself, you don't 
need to check that explicitly before calling kfree() - that's redundant.


-- 
Jesper Juhl


