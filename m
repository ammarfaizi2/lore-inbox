Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWDOUrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWDOUrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 16:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWDOUrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 16:47:32 -0400
Received: from [212.33.180.25] ([212.33.180.25]:27655 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751451AbWDOUrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 16:47:31 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Sat, 15 Apr 2006 23:45:39 +0300
User-Agent: KMail/1.5
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604140616.33370.a1426z@gawab.com> <200604151705.18786.kernel@kolivas.org>
In-Reply-To: <200604151705.18786.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604152345.39850.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 14 April 2006 13:16, Al Boldi wrote:
> > Can you try the attached mem-eater passing it the number of kb to be
> > eaten.
> >
> >         i.e. '# while :; do ./eatm 9999 ; done'
> >
> > This will print the number of bytes eaten and the timing in ms.
> >
> > Assuming timeslice=100, adjust the number of kb to be eaten such that
> > the timing will be less than timeslice (something like 60ms).  Switch to
> > another vt and start another eatm w/ the number of kb yielding more than
> > timeslice (something like 140ms).  This eatm should starve completely
> > after exceeding timeslice.
> >
> > This problem also exists in mainline, but it is able to break out of it
> > to some extent.  Setting eatm kb to a timing larger than timeslice does
> > not exhibit this problem.
>
> Thanks for bringing this to my attention. A while back I had different
> management of forked tasks and merged it with PF_NONSLEEP. Since then I've
> changed the management of NONSLEEP tasks and didn't realise it had
> adversely affected the accounting of forking tasks. This patch should
> rectify it.

Congrats!

Much smoother, but I still get this choke w/ 2 eatm 9999 loops running:

9 MB 783 KB eaten in 131 msec (74 MB/s)
9 MB 783 KB eaten in 129 msec (75 MB/s)
9 MB 783 KB eaten in 129 msec (75 MB/s)
9 MB 783 KB eaten in 131 msec (74 MB/s)
9 MB 783 KB eaten in 133 msec (73 MB/s)
9 MB 783 KB eaten in 132 msec (73 MB/s)
9 MB 783 KB eaten in 128 msec (76 MB/s)
9 MB 783 KB eaten in 133 msec (73 MB/s)
9 MB 783 KB eaten in 129 msec (75 MB/s)
9 MB 783 KB eaten in 130 msec (74 MB/s)
9 MB 783 KB eaten in 2416 msec (3 MB/s)		<<<<<<<<<<<<<
9 MB 783 KB eaten in 197 msec (48 MB/s)
9 MB 783 KB eaten in 133 msec (73 MB/s)
9 MB 783 KB eaten in 132 msec (73 MB/s)
9 MB 783 KB eaten in 132 msec (73 MB/s)
9 MB 783 KB eaten in 126 msec (77 MB/s)
9 MB 783 KB eaten in 135 msec (72 MB/s)
9 MB 783 KB eaten in 132 msec (73 MB/s)
9 MB 783 KB eaten in 132 msec (73 MB/s)
9 MB 783 KB eaten in 134 msec (72 MB/s)
9 MB 783 KB eaten in 64 msec (152 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 64 msec (152 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 64 msec (152 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)
9 MB 783 KB eaten in 63 msec (154 MB/s)

You may have to adjust the kb to get the same effect.

Thanks!

--
Al

