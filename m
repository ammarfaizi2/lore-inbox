Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTB0GaN>; Thu, 27 Feb 2003 01:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTB0GaN>; Thu, 27 Feb 2003 01:30:13 -0500
Received: from daimi.au.dk ([130.225.16.1]:9617 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S261302AbTB0GaM>;
	Thu, 27 Feb 2003 01:30:12 -0500
Message-ID: <3E5DB2CA.32539D41@daimi.au.dk>
Date: Thu, 27 Feb 2003 07:40:10 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> 
> Kasper Dupont <kasperd@daimi.au.dk> writes:
> > I don't think you can put all the information from /etc/mtab
> > into /proc/mounts without breaking compatibility.
> 
> Why?  Since the option syntax is regular, presumably programs simply
> ignore options they don't understand.  No?

It is mostly the device field I had in mind.

> 
> > My suggestion would be to change it from /etc/mtab to /mtab.d/mtab.
> 
> Please, no.  don't pollute the root (_especially_ with little one-use
> directories like that).

Unfortunately it is the best solution I can come up with.

> 
> /var is clearly the right place for this;

Is it?

> if /var isn't mounted
> initially, I'd suggest that mount should simply not update any file at
> that point, and the init-script that mounts /var can be responsible from
> propagating information from /proc/mounts to /var/whatever.

Would you fsck /var while it is mounted?

I think part of the problem is that /var is used for both files
we want to keep across reboot, and files we do not want to keep
across reboot.

There are cases where it is undesirable to have mtab in /var,
but if mount expect to find mtab somewhere under /var, we can't
even use a symlink to get it out of there, because /var needs
to be mounted before the symlink can be followed.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
