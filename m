Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281467AbRKZDNT>; Sun, 25 Nov 2001 22:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281448AbRKZDNJ>; Sun, 25 Nov 2001 22:13:09 -0500
Received: from [206.196.53.54] ([206.196.53.54]:18339 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S281464AbRKZDM7>;
	Sun, 25 Nov 2001 22:12:59 -0500
Date: Sun, 25 Nov 2001 21:15:05 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <3BFF06CA.71B99D3C@zip.com.au>
Message-ID: <Pine.LNX.4.40.0111252110490.2207-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Andrew Morton wrote:

> Oliver Xymoron wrote:
> >
> > > Tell me if this is joyful:
> >
> > Haven't tried it yet, but I'm afraid I don't see what makes it actually
> > sync with the dirty buffer flush. Wouldn't it be better to export a chain
> > of flush funcs hung off a timer?
>
> It doesn't sync with kupdate.
>
> If you want to do that, just defeat the journal timer altogether. So:
>
>         transaction->t_expires = jiffies + 1000000000;
>
> in get_transaction().   That way, kupdate's write_super() will
> run a commit every bdf_prm.b_un.interval jiffies.

Ok, so what's the theory behind the journal timer? Why would we want
ext3 journal flushed more or less often than ext2 metadata given that
they're of equivalent importance?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

