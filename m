Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbRFQKZx>; Sun, 17 Jun 2001 06:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264712AbRFQKZl>; Sun, 17 Jun 2001 06:25:41 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14596 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264711AbRFQKZ3>; Sun, 17 Jun 2001 06:25:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
Date: Sun, 17 Jun 2001 12:28:17 +0200
X-Mailer: KMail [version 1.2]
Cc: Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106161853510.2056-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.21.0106161853510.2056-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <0106171228170M.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 June 2001 23:54, Rik van Riel wrote:
> On Sat, 16 Jun 2001, Daniel Phillips wrote:
> > > Does the patch below do anything good for your laptop? ;)
> >
> > I'll wait for the next one ;-)
>
> OK, here's one which isn't reversed and should work ;))
>
> --- fs/buffer.c.orig	Sat Jun 16 18:05:29 2001
> +++ fs/buffer.c	Sat Jun 16 18:05:15 2001
> @@ -2550,7 +2550,8 @@
>  			   if the current bh is not yet timed out,
>  			   then also all the following bhs
>  			   will be too young. */
> -			if (time_before(jiffies, bh->b_flushtime))
> +			if (++flushed > bdf_prm.b_un.ndirty &&
> +					time_before(jiffies, bh->b_flushtime))
>  				goto out_unlock;
>  		} else {
>  			if (++flushed > bdf_prm.b_un.ndirty)

No, it doesn't, because some way of knowing the disk load is required and 
there's nothing like that here.

There are two components to what I was talking about:

  1) Early flush when load is light
  2) Preemptive cleaning when load is light

Both are supposed to be triggered by other disk activity, swapout or file 
writes, and are supposed to be triggered when the disk activity eases up.

--
Daniel
