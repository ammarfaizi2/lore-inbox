Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbSAEEVx>; Fri, 4 Jan 2002 23:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287505AbSAEEVo>; Fri, 4 Jan 2002 23:21:44 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:60682 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S287502AbSAEEVf>;
	Fri, 4 Jan 2002 23:21:35 -0500
Message-ID: <3C367F18.4F879E3B@obviously.com>
Date: Fri, 04 Jan 2002 23:20:40 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl, util-linux@math.uio.no
CC: Lionel.Bouton@free.fr, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Why would a valid DVD show zero files on Linux?
In-Reply-To: <UTC200201050250.CAA232926.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Confirmed.  The DVD in question (DeLorme Topo USA) shows files when mounted
with "nojoliet". But when the application is run, the maps are scrambled.
It must be mounted as udf to work.

The original bug report incorrectly asserted that the iso9660 filesystem
was empty, sorry about that.

But this does seem to be an example (which
has been widely reported elsewhere) of a DVD with a differing udf and iso9660
filesystems.  Lots of people have reported that, since Windows no longer
uses the "iso9660 udf bridge", lots of mastered DVDs have unintentionally
corrupt versions of it.  Others have hinted this is done deliberately for
copy protection reasons.

			-Bryce

Solving the problem by documentation
------------------------------------
The patches already supplied to mount(8) and fstab (5) give give a sysadmin
the tools to learn about and solve the problem, thanks for applying them!

It just seems like there's a bit more to say about potentially differing udf
and iso9660 filesytems on the same disc... that's the thiking behind the extra
paragraph in the patch.



Solving the problem automatically (keeping the issue out of the users face)
---------------------------------------------------------------------------
Mastering houses will test their discs on Windows.  While in general emulating Windows
is something I hate, here it makes sense.  The more
closely the mount automounter emulates how windows automounts, the more likely 
this type of discussion will never need to come up. 

According to Alan Windows tries udf first, blindly, then falls back to iso9660.

As many people pointed out, this is not a kernel issue, it's a automount
isuse.


Andries.Brouwer@cwi.nl wrote:
> 
> > Here are the first 2048 1024 byte blocks.
> 
> Hmm. I am a bit slow, but just looked at this image.
> It looks fine in iso9660 style, provided you give the
> nojoliet option. I get:
> 
> # mount DeLorme_TopoUSA_DVD.head /mnt -t iso9660 -o loop,nojoliet
> # ls -l /mnt
> total 12
> dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
> drwxr-xr-x   31 root     root         4096 Jan  3 02:11 ..
> -r-xr-xr-x    1 root     root         2763 Feb 28  2001 cd.txt
> dr-xr-xr-x    1 root     root         2048 Feb 28  2001 data
> -r-xr-xr-x    1 root     root          196 Feb 28  2001 pdataset.txt
> 
> and
> 
> # mount DeLorme_TopoUSA_DVD.head /mnt -t udf -o loop
> # ls -l /mnt
> total 14
> dr-xr-xr-x    3 4294967295 4294967295      184 Feb 28  2001 .
> drwxr-xr-x   31 root     root         4096 Jan  3 02:11 ..
> -r--r--r--    1 4294967295 4294967295     2763 Feb 28  2001 CD.TXT
> dr-xr-xr-x    2 4294967295 4294967295      380 Feb 28  2001 DATA
> -r--r--r--    1 4294967295 4294967295      196 Feb 28  2001 PDATASET.TXT
> 
> so the iso9660 version looks a bit better than the udf version.
> (But I cannot look at the actual contents because the initial
> fragment is not large enough. You can check for yourself
> whether the nojoliet mount is OK.)
> 
> Thus, there do not seem reasons to change mount(2) or mount(8)
> in the way you suggested. There is no "empty iso9660 filesystem" here.
> 
> Andries
