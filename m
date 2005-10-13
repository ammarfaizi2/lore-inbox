Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbVJMKNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbVJMKNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 06:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbVJMKNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 06:13:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751499AbVJMKNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 06:13:53 -0400
Date: Thu, 13 Oct 2005 03:13:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Janak Desai <janak@us.ibm.com>, chrisw@osdl.org, viro@ZenIV.linux.org.uk,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] New System call unshare (try 2)
Message-ID: <20051013101347.GN5856@shell0.pdx.osdl.net>
References: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM> <20051012171914.GA8622@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012171914.GA8622@mail.shareable.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jamie Lokier (jamie@shareable.org) wrote:
> Janak Desai wrote:
> > 	Don't allow sighand unsharing if not unsharing vm
> 
> Why not?  It's permitted to clone with unshared sighand and shared vm,
> and it's useful too.

I think that one's just backwards.  Although I do question how useful it
is to unshare sighand.  Sharing vm is pretty intimate ;-)

> It's the combination shared sighand + unshared vm which is not
> allowed by clone - so I think that's what you should refuse.
> 
> > 	Don't allow vm unsharing if task cloned with CLONE_THREAD
> 
> It would be better to do what clone does, and say "don't allow sighand
> unsharing if task cloned with CLONE_THREAD".  This is because
> CLONE_THREAD tasks must have shared signals.

Yes, I agree.

> In combination with the rule above for sighand (my rule, not yours),
> that implies "don't allow vm unsharing.." as a consequence.
> 
> > 	Don't allow vm unsharing if the task is performing async io
> 
> Why not?
> 
> Async ios are tied to an mm (see lookup_ioctx in fs/aio.c), which may
> be shared among tasks.  I see no reason why the async ios can't
> continue and be waited in on in other tasks that may be using the old mm.

My concern was the case where there are no other tasks.  But I don't
think that's an issue other than having the aio effect of setting up
aio then exiting.

thanks,
-chris
