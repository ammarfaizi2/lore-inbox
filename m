Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSFKOda>; Tue, 11 Jun 2002 10:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317077AbSFKOd3>; Tue, 11 Jun 2002 10:33:29 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43780 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317081AbSFKOdI>; Tue, 11 Jun 2002 10:33:08 -0400
Message-Id: <200206111428.g5BES0L15607@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anton Altaparmakov <aia21@cantab.net>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Date: Tue, 11 Jun 2002 17:29:02 -0200
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <E17Hflq-0005Hf-00@wagner.rustcorp.com.au> <5.1.0.14.2.20020611114701.00aefec0@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 June 2002 08:57, Anton Altaparmakov wrote:
> At 08:42 11/06/02, Andrew Morton wrote:
> >Rusty Russell wrote:
> > > Linus, please apply.  Tested on my dual x86 box.
> > >
> > > This patch removes smp_num_cpus, cpu_number_map and cpu_logical_map
> > > from generic code, and uses cpu_online(cpu) instead, in preparation
> > > for hotplug CPUS.
> >
> >umm.  This patch does introduce a non-zero amount of bloat:
> > > ...
> > > -       ntfs_compression_buffers =  (u8**)kmalloc(smp_num_cpus *
> >
> > sizeof(u8*),
> >
> > > +       ntfs_compression_buffers =  (u8**)kmalloc(NR_CPUS *
> > > sizeof(u8*),
>
> This is crazy! It means you are allocating 2MiB of memory instead of just
> 128kiB on a 2 CPU system, which will be about 99% of the SMP systems in
> use, at my guess. So your change is throwing away 1920kiB of kernel ram for
> no reason at all. And that is just ntfs...

Wait a minute.
These buffers are allocated per CPU. Can we allocate additional ones when
new CPU is added? I do hope these buffers aren't allocated an boot time but
at mount time, are they?

I'm sorry it sounds like NTFS code needs rework, not Rusty's patch.
Feel free to enlighten me why I am wrong.
--
vda
