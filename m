Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311577AbSDUKkS>; Sun, 21 Apr 2002 06:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDUKkR>; Sun, 21 Apr 2002 06:40:17 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:33843 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S311577AbSDUKkP>; Sun, 21 Apr 2002 06:40:15 -0400
Message-Id: <5.1.0.14.2.20020421113007.04012810@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 21 Apr 2002 11:40:09 +0100
To: Sean Reifschneider <jafo@tummy.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: eNBD on loopback [was Re: [PATCH] 2.5.8 IDE 36]
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20020420212833.G2866@tummy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:28 21/04/02, Sean Reifschneider wrote:
> >Don't ask me, I'm not a user, I have just seen the patch submissions, and
> >I just want to get real user feedback before I'd merge a new "extended
> >nbd".
>
>I haven't used enbd, because the site was down the weekend I was evaluating
>the alternatives...  I did try NBD and DRBD, however.  My experience was
>that enbd could hardly be worse than nbd, for the following reasons:
>
>    The nbd server software referenced in the Configuration documentation
>    (the only I was able to find, and that only after some digging), would
>    fail rather quickly because the remote kernel would send a request much
>    larger than the server was expecting.

Indeed. The source code reference in th Configuration documentation is very 
much out of data and completely broken for anything that requires 64 bit 
sizes on a 32 bit architecture.

This is all fixed now (I know because I shared your frustration and went 
and fixed it myself (-:), if you want to get a properly working version 
which exhibits no problems under very intensive i/o on a 15GiB partition 
over a 100MBit lan just go to http://sf.net/projects/nbd/ and get the 
latest version from CVS or download the new 2.0 release tarball.

>   After a couple of days, the primary machine would just lock up when
>    running RAID-1 on top of the NBD.

I haven't tried RAID... Interesting idea though.

>   The NBD server code is, not pretty...  It sounds like that server was
>    written as just a hack, and really hasn't been looked at since then.

Yes, I had that impression, too. I hope I made the parts I touched look a 
bit better. (-8

>This was with kernel version 2.4.18.

Simillar here on server side (2.4.18-pre7-ac2+misc patches).

>DRBD is what I'm currently using and it's been running for a few weeks now
>without any problems.  It combines the mirroring and NBD functionality into
>a single combined package.  A nice feature of DRBD is that it understands
>about the second node and can do things like wait for a RAID mirror to
>finish before starting up other processes.
>
>enbd has some nice features, particularly it looks like the server code
>has had a lot more development in it.  Particularly nice is that the
>client/server will auto-negotiate an optimized mirror mode where they will
>exchange MD5 sums of each block, and only transmit the block if the MD5 is
>different...  It switches to and from this mode automatically.
>
>I can't really on wether enbd should be in the kernel...  It can't be worse
>than nbd, based on my experience.  It's active development makes it a
>better choice to include.

nbd is also actively developed. The only problem is nobody has bothered to 
update the kernel documentation to point to the website where development 
happens. )-:

While we are here, I will make patches for 2.4 and 2.5 in a minute and 
submit them...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

