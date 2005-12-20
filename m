Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVLTU1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLTU1f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVLTU1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:27:35 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:18142 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932076AbVLTU1f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:27:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L8jx5TeTK0+bWhFcJqhCFOJITyDzytTZnDJRioomJb90U9ENyQM6iJUrLhOCXuYyYTTmLt6BQYFzTvtWTtHQH3KvSeUIC2sUCxo75kOnqmLEGwggm+GFD2wtvmkwW6LdIHwFtpl8EkQIt3u5yVpL9Roq3AWqEqw3WTIsb158Kj4=
Message-ID: <9a8748490512201227m755d1009k9c40358de7baece0@mail.gmail.com>
Date: Tue, 20 Dec 2005 21:27:34 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Cc: David Lang <dlang@digitalinsight.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@ines.ro>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
In-Reply-To: <122020051953.9002.43A861470004E9E70000232A220702095300009A9B9CD3040A029D0A05@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <122020051953.9002.43A861470004E9E70000232A220702095300009A9B9CD3040A029D0A05@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/05, Parag Warudkar <kernel-stuff@comcast.net> wrote:
> >
> > by goig to 4k stacks they are able to be allocated even when memory is
> > badly fragmented, which is not the case while they are 8k.
> >
> > David Lang
> >
>
> It's hard to believe all i386 people have a problem with 8K stacks. What you said may be a problem domain bound to a specific workload on i386 with insane amounts of memory and fragmented LOWMEM. - These people can certainly use 4K stacks and no one is preventing that.
>

There are more bennefits to 4K stacks than just that.
Arjan posted a nice list a while back :
http://www.ussg.iu.edu/hypermail/linux/kernel/0511.2/0042.html


> But normal people with <=1Gb RAM and using i386 on desktop (I am sure there are many of them) may do OK with 8K stacks if they had a need to do so. (Like running ndiswrapper,

ndiswrapper is not safe even with 8K stacks since Windows allow more
than that, so ndiswrapper can still break with 8K stack - the
ndiswrapper people would be a lot better off by biting the bullet and
implementing their own large stack for the drivers they run and not
depend on the size of the Linux kernels stack.


>or some other thing which requires bigger stacks for that matter.)
>
If that something is in the mainline kernel it should be fixed, if it
is not in mainline then mainline doesn't need to care.


> Why take away the 8K option which already exists and works for people who need it? Let people choose what suits their needs. Forcing 4K stacks on people and asking them to sacrifice functionality while *gaining nothing* - sure sounds illogical. (You gain from 4K stacks - you have it as default, but technically you gain NOTHING from taking away the 8k option.)
>

By taking away the 8K stack option (after a while, we need to make
damn sure all in-kernel code is safe first) I can think of these
bennefits in addition to the technical bennefits of 4K stacks :

 - less code bloat.
 - fewer config options (there are IMHO way too many already).
 - more testing of 4K stacks (since it's the only option everyone will
be using it).
 - pressure on vendors to get their drivers merged into mainline.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
