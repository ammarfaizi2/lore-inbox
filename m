Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSDUD2t>; Sat, 20 Apr 2002 23:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293187AbSDUD2s>; Sat, 20 Apr 2002 23:28:48 -0400
Received: from secure.tummy.com ([216.17.150.2]:4289 "HELO tummy.com")
	by vger.kernel.org with SMTP id <S293076AbSDUD2r>;
	Sat, 20 Apr 2002 23:28:47 -0400
Date: Sat, 20 Apr 2002 21:28:33 -0600
From: Sean Reifschneider <jafo@tummy.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Re: eNBD on loopback [was Re: [PATCH] 2.5.8 IDE 36]
Message-ID: <20020420212833.G2866@tummy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Don't ask me, I'm not a user, I have just seen the patch submissions, and
>I just want to get real user feedback before I'd merge a new "extended
>nbd".

I haven't used enbd, because the site was down the weekend I was evaluating
the alternatives...  I did try NBD and DRBD, however.  My experience was
that enbd could hardly be worse than nbd, for the following reasons:

   The nbd server software referenced in the Configuration documentation
   (the only I was able to find, and that only after some digging), would
   fail rather quickly because the remote kernel would send a request much
   larger than the server was expecting.

   After a couple of days, the primary machine would just lock up when
   running RAID-1 on top of the NBD.

   The NBD server code is, not pretty...  It sounds like that server was
   written as just a hack, and really hasn't been looked at since then.

This was with kernel version 2.4.18.

DRBD is what I'm currently using and it's been running for a few weeks now
without any problems.  It combines the mirroring and NBD functionality into
a single combined package.  A nice feature of DRBD is that it understands
about the second node and can do things like wait for a RAID mirror to
finish before starting up other processes.

enbd has some nice features, particularly it looks like the server code
has had a lot more development in it.  Particularly nice is that the
client/server will auto-negotiate an optimized mirror mode where they will
exchange MD5 sums of each block, and only transmit the block if the MD5 is
different...  It switches to and from this mode automatically.

I can't really on wether enbd should be in the kernel...  It can't be worse
than nbd, based on my experience.  It's active development makes it a
better choice to include.

Sean
-- 
 Fire at the celuloud factory.  No film at eleven.
                 -- _Kentucky_Fried_Movie_
Sean Reifschneider, Inimitably Superfluous <jafo@tummy.com>
tummy.com - Linux Consulting since 1995. Qmail, KRUD, Firewalls, Python
