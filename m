Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbTHBRmd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 13:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269967AbTHBRmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 13:42:33 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:6930 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269958AbTHBRmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 13:42:32 -0400
Date: Sat, 2 Aug 2003 19:42:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, axboe@suse.de
Cc: Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Message-ID: <20030802174229.GA3741@win.tue.nl>
References: <20030802124536.GB3689@win.tue.nl> <Pine.SOL.4.30.0308021506550.7779-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0308021506550.7779-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 03:10:43PM +0200, Bartlomiej Zolnierkiewicz wrote:

> On Sat, 2 Aug 2003, Andries Brouwer wrote:
> 
> > Maybe it is intended to protect against old disks that do not
> > understand these new commands. Andre? Bart? Alan?
> 
> Some Samsung disks lock up.  Probably we should check if HPA
> command set is supported instead of using IDE_STROKE_LIMIT.

OK, so we have to investigate. This strange test was inserted
in 2.4 and 2.5 via Alan, and google gives me Alan's changelog:

Linux 2.5.66-ac1
o Don't issue WIN_SET_MAX on older drivers (Jens Axboe)
  (Breaks some Samsung)

So, now the question is to Jens: what was the situation?
What disk, kernel, identify output?

If possible we would like to remove the test and test the
right bits instead. But if that Samsung disk claims it
supports HPA and doesnt..

Andries


[By the way, google also shows examples where this test
breaks a setup, so removing it might be a good idea
under all circumstances. The usual jumper goes from
above 32GB to 32GB, and from below 32GB to 2GB.
There are also examples of the latter kind solved
by STROKE, but no longer by STROKE + faulty test.]

