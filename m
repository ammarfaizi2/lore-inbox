Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265758AbTFSKRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 06:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265759AbTFSKRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 06:17:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:23261 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265758AbTFSKRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 06:17:30 -0400
Date: Thu, 19 Jun 2003 12:30:56 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@digeo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.72 oops (scheduling while atomic)
In-Reply-To: <20030618224656.0f5639bb.akpm@digeo.com>
Message-ID: <Pine.SOL.4.30.0306191224440.3527-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

I think you wanted to cc: me not the other Bart :-).

I am aware of the problem and looking for solution.
Reverting to old non-taskfile code seems to help
(say N to IDE "Taskfile IO" option available in 2.5.72).

Thanks,
--
Bartlomiej
Linux IDE Maintainer

On Wed, 18 Jun 2003, Andrew Morton wrote:

> Greg Norris <haphazard@kc.rr.com> wrote:
> >
> > I'm getting the following oops when booting 2.5.72, preceded by a
> >  quite a few "bad: scheduling while atomic!" messages.  My .config and
> >  the decoded oops are attached.
>
> I was able to reproduce this.  Pid #0 (swapper) ends up with a preempt
> count of two and everything goes pear-shaped.
>
> This appears to be because you haven't selected any chip drivers in IDE
> config.  I selected PIIX and things started working better.
>
> Just to double-check I took my usual .config, enable preemption, disabled
> all IDE chip drivers and the same thing happened.  Over to Bart ;)
>
>
> Your .config seems broken in other ways btw.  Suggest you do
>
> 	cp arch/i386/defconfig .config
>
> and start again.


