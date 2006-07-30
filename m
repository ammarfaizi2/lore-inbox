Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWG3UDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWG3UDj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWG3UDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:03:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:14611 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932459AbWG3UDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:03:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vt/k8HofJTN1ob808rnsEvTAjRn9eXWx12h9dxlHWWAW4olsqThm0P4ARBzmRLYNU8Mdt7G4MkMlERZrDaR1NVPqvFrt2KXCbWg7kZIQ8ldqYEjd8Yx+9bwJHbKyZURl6O4GNdyawvudpvKGgQZT9z22ebrFkbbLhHKrpdDNu04=
Message-ID: <9a8748490607301303v47442d56i9a3038b2d9e43e90@mail.gmail.com>
Date: Sun, 30 Jul 2006 22:03:37 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060730125115.d9f9d625.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607301830.01659.jesper.juhl@gmail.com>
	 <200607301835.35053.jesper.juhl@gmail.com>
	 <20060730113416.7c1d8f80.pj@sgi.com>
	 <9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
	 <20060730120631.9ee1ab09.akpm@osdl.org>
	 <9a8748490607301217g1edad85dre8a45457c57bee35@mail.gmail.com>
	 <20060730125115.d9f9d625.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 30 Jul 2006 21:17:18 +0200
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> > > (looks at
> > > lock_cpu_hotplug())
> > >
> > Hmm, I'll take a look at lock_cpu_hotplug() - can you provide
> > additional details?
> >
>
> eh.  We put the recursive-sem thing in there as a temp fix to cpufreq to
> get 2.6.something out the door, expressing fine intentions to fix it for
> real later on.  Then look what happened.  Don't go there.
>

Ok, that's probably way over my head, but I'll dig in none the less
and see what I can do to help. It'll probably land me in a world of
hurt, but I've taken flames before and I'm still here ;-)
Don't expect much, but I'll see if there's anything I can do at least.


> >
> > > That being said, no, we can't go and rename up().  Let us go through the
> > > patches one-at-a-time..
> > >
> > i figured as much. *But* won't you agree that up_sem() (or considering
> > the other locking function names, sem_up() would probably be better)
> > would be a much better name for a global like this one?
> >
> > How about a plan like this:
> > We introduce sem_up() and sem_down() wrapper functions now. They could
> > go into 2.6.19 for example - and also add a note to
> > feature-removal-schedule.txt that the old function names will be
> > removed in 1 year. Then in a few kernel versions - say 2.6.21 - we
> > deprecate the old names and add a big fac comment in the source as
> > well.
> > Wouldn't that be doable?   Or do we have to live with up()/down() forever?
>
> Well actually when struct mutex went in we decided to remove all
> non-counting uses of semaphores kernel-wide, migrating them to mutexes.

Makes sense.

> Then to remove all the arch-specific semaphore implementations and
> implement an arch-neutral version.  After that has been done would be an
> appropriate time to rename things.
>

Ok, that is (again) probably beyond me, but I'll still take a look at
it just for the hell of it.
If nothing else I can at least keep an eye out for when we reach the
point we want to be at and then submit renaming patches...  let's
see..


> But it never happened.  See "fine intentions", above ;)
>
Heh, The road to hell is paved with fine intentions ;-)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
