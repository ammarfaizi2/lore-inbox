Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268676AbTBZLel>; Wed, 26 Feb 2003 06:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268716AbTBZLel>; Wed, 26 Feb 2003 06:34:41 -0500
Received: from daimi.au.dk ([130.225.16.1]:60118 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S268676AbTBZLek>;
	Wed, 26 Feb 2003 06:34:40 -0500
Message-ID: <3E5CA89C.10A8D3DA@daimi.au.dk>
Date: Wed, 26 Feb 2003 12:44:28 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?M=E5ns=20Rullg=E5rd?= <mru@users.sourceforge.net>
CC: Olaf Dietsche <olaf.dietsche@t-online.de>,
       Miquel van Smoorenburg <miquels@cistron-office.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
		<b3i4nv$sud$1@news.cistron.nl> <87u1er71d0.fsf@goat.bogus.local> <yw1xwujn2t0v.fsf@manganonaujakasit.e.kth.se>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> 
> Olaf Dietsche <olaf.dietsche@t-online.de> writes:
> 
> > >>A simpler solution, that does not require changes to the kernel
> > >>would be to just move mtab to a more apropriate location. My
> > >>suggestion would be to change it from /etc/mtab to /mtab.d/mtab.
> > >>Then you could mount a tmpfs filesystem on /mtab.d. Or by making
> > >>/mtab.d a symlink, you can get the mtab file whereever you want,
> > >>including /etc.
> > >
> > > /dev/shm ? Supposed to be there on many systems anyway. Fix
> > > 'mount' and 'umount' so that if they see /etc/mtab is a symlink,
> > > they follow it and create the temp files etc in the destination
> > > directory of the link instead of in /etc. Then
> > > ln -sf /dev/shm/mtab /etc/mtab et voila
> >
> > I thought, this is what /var is for. So, /var/run, /var/lib/misc or
> > /var/etc might be more appropriate?
> 
> What if /var is mounted separately?

I agree with all of you.

/dev/shm is widely available, and is a filesystem of the desired type.
/var is intended for this kind of data, and /var/run seems intuitively
the right location. But /dev as well as /var are often mountpoints. So
to use those locations would introduce more mountpoints that will need
special care early in the startup scripts. And mounting them before
running fsck is a problem.

All of those thoughts is what lead me to the suggestion of a new
directory or symlink in the root. You can point it anywhere you want
mtab. And you don't need to mount any filesystems before the symlink
can be used. A symlink in the other direction would not work that well.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
