Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281514AbRKHKLo>; Thu, 8 Nov 2001 05:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281500AbRKHKLY>; Thu, 8 Nov 2001 05:11:24 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:4297 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S281501AbRKHKLS>; Thu, 8 Nov 2001 05:11:18 -0500
Date: Thu, 8 Nov 2001 11:14:21 +0100
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: linux-kernel@vger.kernel.org
Cc: Ville Herva <vherva@niksula.hut.fi>
Subject: Re: What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011108111421.A612@zodiak.ecademix.com>
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com> <20011107224824.G26218@niksula.cs.hut.fi> <20011107234025.A602@zodiak.ecademix.com> <20011108081006.S1504@niksula.cs.hut.fi> <20011108094637.B615@zodiak.ecademix.com> <20011108104634.T1504@niksula.cs.hut.fi> <20011108100014.A704@zodiak.ecademix.com> <20011108111330.U1504@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108111330.U1504@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Thu, Nov 08, 2001 at 11:13:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
the SIGXFSZ signal is produced in the file mm/filemap.c (linx-2.4.14) in
line 2771:

2769:	if (limit != RLIM_INFINITY) {
2770:		if (pos >= limit) {
2771:			send_sig(SIGXFSZ, current, 0);
2772:			goto out;
2773:		}

The valus at this point are
limit:         0x7fffffff
RLIM_INFINITY: 0xffffffff
pos:           0x80004000

where limit comes from:
unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;

but I did not yet detected the point(s) where
current->rlim[RLIMIT_FSIZE].rlim_cur
is(are) set/changed.
Peter

On Thu, Nov 08, 2001 at 11:13:30AM +0200, Ville Herva wrote:
> On Thu, Nov 08, 2001 at 10:00:14AM +0100, you [Peter Seiderer] claimed:
> > Hello,
> > first thank you for your effort.
> > 
> > Did the diff: nearly no difference till the failure point (only pid, time
> > etc.). Peter
> 
> And there really are no resource limits nor quota?
> 
> At this point you'll propably have to dig into glibc / kernel source and try
> to find out what might cause that...
> 
> 
> -- v --
> 
