Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSFLOgO>; Wed, 12 Jun 2002 10:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSFLOgN>; Wed, 12 Jun 2002 10:36:13 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9480 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317180AbSFLOgM>; Wed, 12 Jun 2002 10:36:12 -0400
Message-Id: <200206121431.g5CEV6L20571@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Date: Wed, 12 Jun 2002 17:32:04 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <5.1.0.14.2.20020611114701.00aefec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 June 2002 12:54, Anton Altaparmakov wrote:
> > > This is crazy! It means you are allocating 2MiB of memory instead of
> > > just 128kiB on a 2 CPU system, which will be about 99% of the SMP
> > > systems in use, at my guess. So your change is throwing away 1920kiB of
> > > kernel ram for no reason at all. And that is just ntfs...
> >
> >Wait a minute.
> >These buffers are allocated per CPU. Can we allocate additional ones when
> >new CPU is added?
>
> Of course, see my suggestion for how to handle this in the post after the
> one you replied to.
>
> >I do hope these buffers aren't allocated an boot time but at mount time,
> >are they?
>
> At mount time and only if the volume supports compression. And they are
> ntfs global, i.e. not per mount point. That is still a big ram waste.

It's optimal to allocate buffers when they are needed.
Thnk about an NTFS volume without any compressed files at all.

CPU hotswap higlights the fact that per CPU allocation needs to be smarter 
about doing its job (i.e. don't allocate if it won't be used ever,
defer allocation to CPU hotswap event).

OTOH, smarter code is longer, more difficult code. One have to weigh
memory benefits for small population of 'hot swappers'
versus code simplicity.
--
vda
