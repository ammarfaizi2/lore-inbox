Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWCGCt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWCGCt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWCGCt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:49:28 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:27958 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932143AbWCGCt1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:49:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N2VBiETYz0YSQ6n2PSpyoWxjp9clDxuuvtD1sMBiVAGzHQsPfAjLdpxWpq9yPnuB8kHQvstTeLfGsOjybkcKES6q73bP8a0LGk2lGH6ewl8lS2P9zN763Mh9k1FLQ6TJN6d7PLw4LHD7xoeXOGLkwj+kPNDnYqwQRHgb4owDMno=
Message-ID: <661de9470603061849t470b0709v1987385c9845710e@mail.gmail.com>
Date: Tue, 7 Mar 2006 08:19:26 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Olaf Hering" <olh@suse.de>, "Jan Blunck" <jblunck@suse.de>,
       "Kirill Korotaev" <dev@openvz.org>, "Al Viro" <viro@ftp.linux.org.uk>
In-Reply-To: <17420.59580.915759.44913@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17414.38749.886125.282255@cse.unsw.edu.au>
	 <17419.53761.295044.78549@cse.unsw.edu.au>
	 <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com>
	 <17420.59580.915759.44913@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No I haven't.  I like it.
>  - Holding the semaphore shouldn't be a problem.
>  - calling down_read_trylock ought to be fast
>  - I *think* the unwanted calls to prune_dcache are always under
>    PF_MEMALLOC - they certainly seem to be.
>
> And it is a nice small change.
> Have you had any other feedback on this?
>
>

Thanks, I do not have any feedback on it, but I am certainly hungry for it :-)

> >
> > Some top of the head feedback below. Will try and do a detailed review later.
> >
>
> > > +               /* avoid further wakeups */
> > > +               sb->s_pending_iputs = 65000;
> >
> > This looks a bit ugly, what is 65000?
>
> Just the first big number that came to by head... probably not needed.
>

ok, I would rather use a const or a #define and hide it under a
meaningful name, with comments. If it is not needed, then nothing like
avoiding magic numbers.

>
> NeilBrown
>
