Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWG3TRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWG3TRV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWG3TRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:17:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:50633 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932441AbWG3TRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:17:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aj4nqTSv5+meD8S3sMHs3t898+O2Mjo8isfUwDv+AmroDC3HaH/FmUbjX0IUZzFBNIMi9q7XcBznQ78RqPPQ47319Y58tSk8yDdJsTILsh947UYIcmGLYa02CcqXGHiyKbmvHrE8YGSDDmmSZXDzC0f/MrUcbwaE8lllWh9yilM=
Message-ID: <9a8748490607301217g1edad85dre8a45457c57bee35@mail.gmail.com>
Date: Sun, 30 Jul 2006 21:17:18 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060730120631.9ee1ab09.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607301830.01659.jesper.juhl@gmail.com>
	 <200607301835.35053.jesper.juhl@gmail.com>
	 <20060730113416.7c1d8f80.pj@sgi.com>
	 <9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
	 <20060730120631.9ee1ab09.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 30 Jul 2006 20:48:23 +0200
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> > > Perhaps I am misreading this patch set?
> > >
> > i don't think you are. It's just that I want to take the least
> > intrusive route *now*, make us -Wshadow clean, get -Wshadow to be an
> > accepted part of the Makefile, *then* deal with the more
> > intrusive/controversial renamings, where I guess you'd have done
> > things in the opposite order - right?
>
> yup.  Experience tells us that it's better to get things right first time,
> because we don't get around to doing the intended second pass

I believe my (modest) track record would show that I do follow up on
these things...
But anyway, I believe the renames I've done are not bad one way or the
other and should be acceptable (and some of the long names for local
symbols are chosen based on maintainer feedback even)... but I'll
await more feedback and change the patches if needed.

> (looks at
> lock_cpu_hotplug())
>
Hmm, I'll take a look at lock_cpu_hotplug() - can you provide
additional details?


> That being said, no, we can't go and rename up().  Let us go through the
> patches one-at-a-time..
>
i figured as much. *But* won't you agree that up_sem() (or considering
the other locking function names, sem_up() would probably be better)
would be a much better name for a global like this one?

How about a plan like this:
We introduce sem_up() and sem_down() wrapper functions now. They could
go into 2.6.19 for example - and also add a note to
feature-removal-schedule.txt that the old function names will be
removed in 1 year. Then in a few kernel versions - say 2.6.21 - we
deprecate the old names and add a big fac comment in the source as
well.
Wouldn't that be doable?   Or do we have to live with up()/down() forever?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
