Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268687AbTBZJIt>; Wed, 26 Feb 2003 04:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268688AbTBZJIt>; Wed, 26 Feb 2003 04:08:49 -0500
Received: from daimi.au.dk ([130.225.16.1]:51621 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S268687AbTBZJIs>;
	Wed, 26 Feb 2003 04:08:48 -0500
Message-ID: <3E5C8682.F5929A04@daimi.au.dk>
Date: Wed, 26 Feb 2003 10:18:58 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
> 
>     Hi all :))
> 
>     I would like to know if adding the bits of information that
> /etc/mtab has and /proc/mount doesn't needs a lot of work. The
> problem here is that /etc/mtab, although traditional, does not make
> sense in systems where /etc is mounted read-only. Usually, the only
> reason for mounting it read-write is the mtab...

We are also discussing that from time to time on c.o.l.d.system.
You could take a look on the thread starting with
<news:3E5A343D.186F3074@daimi.au.dk>

I don't think you can put all the information from /etc/mtab
into /proc/mounts without breaking compatibility. So perhaps a
new /proc/mtab would be a better aproach?

However some of the fields written to mtab by mount is not
easilly known by the kernel, so perhaps we could have mount
write them to /proc/mtab.

A simpler solution, that does not require changes to the kernel
would be to just move mtab to a more apropriate location. My
suggestion would be to change it from /etc/mtab to /mtab.d/mtab.
Then you could mount a tmpfs filesystem on /mtab.d. Or by making
/mtab.d a symlink, you can get the mtab file whereever you want,
including /etc.

> 
>     Well, nowadays is very usual to see systems where /etc/mtab is
> just a symlink to /proc/mounts, but then you lose some information.
> That is, you can live without that info, but if it can be easily
> added I think that it would worth the effort.

I agree with that. Some of it may be easy, but not all of it.

> 
>     Unfortunately, some of this information is obtained from
> /etc/fstab but IMHO the kernel has that info too in some table, I
> suppose...
> 
>     Well, if someone familiar with this part of the kernel gives me
> the information I think I can write the code for the 'extra'
> information ;))
> 
>     I give an example of this extra information:
> 
>     in /etc/mtab we have:
>         pts /dev/pts devpts rw,gid=5,mode=620 0 0
> 
>     in /proc/mounts we have:
>         pts /dev/pts devpts rw 0 0
> 
>     Other filesystems, as tmpfs, has the size information, for
> example, etc...

Some more interesting cases are loopback mounts and bind mounts,
in which case the device field is completely different. But the
filesystem specific options are not trivial either. The fact that
you can use a remount to change some of the options but not all
of them means that only the filesystem itself can tell you what
exactly the options are right now. (And since I remember remount
bugs in tmpfs in early 2.4 kernels, it is not going to get easier
to put more requirements on the filesystem.)

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
