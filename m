Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSG0Q6Y>; Sat, 27 Jul 2002 12:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318788AbSG0Q6Y>; Sat, 27 Jul 2002 12:58:24 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:54062 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318787AbSG0Q6X>; Sat, 27 Jul 2002 12:58:23 -0400
Date: Sat, 27 Jul 2002 20:01:25 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: DervishD <raul@pleyades.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About the need of a swap area
Message-ID: <20020727170124.GR1465@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	DervishD <raul@pleyades.net>, linux-kernel@vger.kernel.org
References: <3D42907C.mailFS15JQVA@viadomus.com> <20020727144228.GQ1548@niksula.cs.hut.fi> <3D42C62F.mail5XQ31DIAC@viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D42C62F.mail5XQ31DIAC@viadomus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 06:11:27PM +0200, you [DervishD] wrote:
> 
> >Where swap helps perfomance is when you can swap _inactive_ (parts of)
> >programs out, and use the freed memory for disk cache.
> 
>     Yes, that makes sense, obviously. My question is more: when an
> inactive page will be swapped out? Only when there is no more RAM
> left? 

No, it is smarter than that. The exact algorithms are not obvious - even the
linux VM gurus don't quite agree on them :) If you really want to know how
it works, browse at http://www.linux-mm.org - there you can find many
documents on it and plenty of good links.

> How to configure it?

Through the tunables in /proc/sys/vm/.

You can find some explanation for these in beginning of
/usr/src/linux/vm/vmscan.c etc (as of 2.4.19rc3) I don't know if there's
better documentation somewhere.

If you use -ac, recent 2.5 or vendor a kernel, you may find yourself with
Rik van Riel's vm implementation. It may have better documentation - in
different place.

>     Except when I'm compiling something large, the memory is almost
> entirely free. I have a lot of memory for having a lot of cache, so
> when I develope things go real fast. For example, I use gcc, make and
> binutils (and an editor) most of the time. Well, thanks to the disk
> cache, the first time they are run is the only disk access...

Yes, that's exactly where disk cache will help you.
 
>     But in such a case, highs are the chances of the program crashing
> due to a memory error if there is no swap. I really don't understan
> why swap may save me in this case O:)) Maybe the swap-in, swap-out
> will make that process slower and I have some spare CPU to be able to
> kill the program?

Well, there can be more than one process allocating memory. You shell is
then competing with all of them to get memory. Swap is no magic bullet in
this case either - it just adds more leeway for you.

Rik van Riel wrote:
> The latency difference seems to be on the order of 100000 times.  It is
> the latency we care about because that determines how long the CPU cannot
> do anything useful but has to wait.

I stand corrected - I wrote that without thinking.

 
-- v --

v@iki.fi
