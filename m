Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVIWJpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVIWJpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 05:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVIWJpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 05:45:50 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:39066 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750856AbVIWJpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 05:45:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
Date: Fri, 23 Sep 2005 19:45:36 +1000
User-Agent: KMail/1.8.2
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
In-Reply-To: <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509231945.37057.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005 17:20, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 23 Sep 2005 10:36:16 +1000, Con Kolivas said:
>
> (Adding Andrea to the To: list...)
>
> > On Fri, 23 Sep 2005 05:59, Valdis.Kletnieks@vt.edu wrote:
> > > Am seeing reproducible wedging up when writing large (20M+) files to an
> > > ext3 file system.  Oddly enough, if something *else* writes files to
> > > the file system as well, it will unwedge for a while and make progress.
> > >  Also, a 'sync' command will relieve things temporarily - but after a
> > > few megabytes it comes to a halt again.  Looks like a borkage someplace
> > > not causing it to actually finish pushing dirty file pages out -
> > > gkrellm reports little/no disk activity in progress. File activity on
> > > *other* filesystems continues unimpeded.
> >
> > Could be the write throttling patches.
> >
> > Try backing these out (in this order I think):
> >
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2
> >/2.6
>
> .14-rc2-mm1/broken-out/per-task-predictive-write-throttling-1-tweaks.patch
>
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2
> >/2.6
>
> .14-rc2-mm1/broken-out/per-task-predictive-write-throttling-1.patch
>
> Bingo.  I haven't built a kernel with these excluded, but writing 0 to
> /proc/sys/vm/dirty_ratio_centisecs fixes the problem, so I'm pretty sure
> this is it.
>
> (For the record, I've noticed the starvation issue that Andrea is trying to
> address, where one process can lock out others, so I *do* think work is
> needed here...)

I don't disagree, which is why I was excited by this work as well. Like all 
things in the kernel it always ends up being more complicated than the 
original plan, requiring reworking. So I do not remotely see this as a 
problem at this early stage.

Cheers,
Con
