Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSFKOyU>; Tue, 11 Jun 2002 10:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSFKOyU>; Tue, 11 Jun 2002 10:54:20 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:55396 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317115AbSFKOyS>; Tue, 11 Jun 2002 10:54:18 -0400
Message-Id: <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 11 Jun 2002 15:54:09 +0100
To: vda@port.imtp.ilyichevsk.odessa.ua
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <200206111428.g5BES0L15607@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:29 11/06/02, Denis Vlasenko wrote:
>On 11 June 2002 08:57, Anton Altaparmakov wrote:
> > At 08:42 11/06/02, Andrew Morton wrote:
> > >Rusty Russell wrote:
> > > > Linus, please apply.  Tested on my dual x86 box.
> > > >
> > > > This patch removes smp_num_cpus, cpu_number_map and cpu_logical_map
> > > > from generic code, and uses cpu_online(cpu) instead, in preparation
> > > > for hotplug CPUS.
> > >
> > >umm.  This patch does introduce a non-zero amount of bloat:
> > > > ...
> > > > -       ntfs_compression_buffers =  (u8**)kmalloc(smp_num_cpus *
> > >
> > > sizeof(u8*),
> > >
> > > > +       ntfs_compression_buffers =  (u8**)kmalloc(NR_CPUS *
> > > > sizeof(u8*),
> >
> > This is crazy! It means you are allocating 2MiB of memory instead of just
> > 128kiB on a 2 CPU system, which will be about 99% of the SMP systems in
> > use, at my guess. So your change is throwing away 1920kiB of kernel ram for
> > no reason at all. And that is just ntfs...
>
>Wait a minute.
>These buffers are allocated per CPU. Can we allocate additional ones when
>new CPU is added?

Of course, see my suggestion for how to handle this in the post after the 
one you replied to.

>I do hope these buffers aren't allocated an boot time but at mount time, 
>are they?

At mount time and only if the volume supports compression. And they are 
ntfs global, i.e. not per mount point. That is still a big ram waste.

>I'm sorry it sounds like NTFS code needs rework, not Rusty's patch.

Sorry to disappoint you but my code is as efficient as possible while 
NR_CPUs is as ugly and inefficient as hell.

>Feel free to enlighten me why I am wrong.

I hope I have managed to do that. (-:

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

