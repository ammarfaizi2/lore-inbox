Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289762AbSBSJne>; Tue, 19 Feb 2002 04:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290974AbSBSJnY>; Tue, 19 Feb 2002 04:43:24 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:39684 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S290966AbSBSJnI>; Tue, 19 Feb 2002 04:43:08 -0500
Date: Tue, 19 Feb 2002 10:43:05 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tom Holroyd <tomh@po.crl.go.jp>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
In-Reply-To: <Pine.LNX.4.44.0202191817330.26361-100000@holly.crl.go.jp>
Message-ID: <Pine.LNX.4.33.0202191035470.13852-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > /proc/stat:
> > > cpu  2427984276 2540057284 67737892 4296620451
> > > cpu0 2427984276 2540057284 67737892 4296620451
> > > ...
> > >
> > I'd suggest changing the declarations in kstat_read_proc to
> >
> >         unsigned long jif = jiffies, user = 0, nice = 0, system = 0;
> >         unsigned int sum = 0;
> >
> > so that ticks that are lost due to overflow count as "other".
> 
> Isn't it also necessary to change the sprintf() format strings to %lu?
> That is,
>         len = sprintf(page, "cpu  %lu %lu %lu %lu\n", user, nice, system,
>                       jif * smp_num_cpus - (user + nice + system));
> 

Sorry, I got it wrong. What I actually wanted to suggest is:
  leave the declarations as they are now, but do the "other"
  calculation with longs, i.e.:

    len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
                  jif * smp_num_cpus - ((unsigned long) user + nice + system));



