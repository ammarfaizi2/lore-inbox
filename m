Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTFDKJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTFDKJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:09:09 -0400
Received: from ns.suse.de ([213.95.15.193]:2833 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262169AbTFDKJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:09:08 -0400
Date: Wed, 4 Jun 2003 12:22:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Message-ID: <20030604102241.GM3412@x30.school.suse.de>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <20030529140025.61f991d4.georgn@somanetworks.com> <Pine.LNX.4.55L.0305291609580.14835@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305291609580.14835@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 04:11:12PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Thu, 29 May 2003, Georg Nikodym wrote:
> 
> > On Wed, 28 May 2003 21:55:39 -0300 (BRT)
> > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> >
> > > Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's
> > > fix for the IO stalls/deadlocks.
> >
> > While others may be dubious about the efficacy of this patch, I've been
> > running -rc6 on my laptop now since sometime last night and have seen
> > nothing odd.
> >
> > In case anybody cares, I'm using both ide and a ieee1394 (for a large
> > external drive [which implies scsi]) and I do a _lot_ of big work with
> > BK so I was seeing the problem within hours previously.
> 
> Great!

are you really sure that it is the right fix?

I mean, the batching has a basic problem (I was discussing it with Jens
two days ago and he said he's already addressed in 2.5, I wonder if that
could also have an influence on the fact 2.5 is so much better in
fariness)

the issue with batching in 2.4, is that it is blocking at 0 and waking
at batch_requests. But it's not blocking new get_request to eat requests
in the way back from 0 to batch_requests. I mean, there are two
directions, when we move from batch_requests to 0 get_requests should
return requests. in the way back from 0 to batch_requests the
get_request should block (and it doesn't in 2.4, that is the problem)

> 
> -rc7 will have to be released due to some problems :(
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
