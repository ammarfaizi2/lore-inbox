Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264416AbRGWXPP>; Mon, 23 Jul 2001 19:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbRGWXPF>; Mon, 23 Jul 2001 19:15:05 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:7200
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264416AbRGWXO7>; Mon, 23 Jul 2001 19:14:59 -0400
Date: Mon, 23 Jul 2001 16:14:54 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        linux-fsdev@vger.kernel.org, martizab@libertsurf.fr,
        rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010723161454.C14425@work.bitmover.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
	linux-fsdev@vger.kernel.org, martizab@libertsurf.fr,
	rusty@rustcorp.com.au
In-Reply-To: <3B5CA2EC.2498775@wanadoo.fr> <Pine.LNX.4.33L.0107231925040.20326-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33L.0107231925040.20326-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Jul 23, 2001 at 07:29:36PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 07:29:36PM -0300, Rik van Riel wrote:
> Now if you want to make this kernel-accessible, why
> not make a userland NFS daemon which uses something
> like bitkeeper or PRCS as its backend ?
> 
> The system would then look like this:
> 
>  _____    _______    _____    _____
> |     |  |       |  |     |  |     |
> | SCM |--| UNFSD |--| NET |--| NFS |
> |_____|  |_______|  |_____|  |_____|
> 
> 
> And there, you have a transparent SCM filesystem
> that works over the network ... without ever having
> to modify the kernel or implement SCM.

I like the way you think, Rik.  About 2 years ago I did a very quick and ugly
version of exactly this, just as a proof of concept.  You could mount old
versions of the repositories and diff them, etc.  Quite cool.  It's long
since out of date and it adds a layer of caching and performance loss that
I wasn't willing to live with, but it's a cool idea.  When we have more time
than problems I might get back to that.  I think it is the right approach.

As to the comments he made about mixing files, that's not a problem.  You
do need some way to tell UNFDS that this file is to be revision controlled
and that one is not, but with that you can let .o's be created and just 
managed in the backing file system.  Works fine.  The interface to 
revision control stuff seems ugly because you have to be explicit, but that
can be made nice.  Suppose we used fake subdirectories as a way of doing
operations, such that

	mv *.c ./.checkin

does a checkin, etc.  That's not so bad and you need the interface anyway 
to tell the system you are ready to check things in. You don't want it to 
check in a new version every time you modify the file, that's excessive.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
