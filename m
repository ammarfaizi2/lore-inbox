Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTKRN0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTKRN0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:26:10 -0500
Received: from gprs147-139.eurotel.cz ([160.218.147.139]:16257 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262564AbTKRN0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:26:06 -0500
Date: Tue, 18 Nov 2003 14:26:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031118132634.GB470@elf.ucw.cz>
References: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc> <20031109113928.GN2831@suse.de> <20031113125427.GB643@openzaurus.ucw.cz> <20031117081407.GI888@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117081407.GI888@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > OTOH it might make sense to make "nice" command set
> > both by default.
> 
> Yes, I can probably be talked into that.

Good.

> > > > > these end values are "special" - 0 means the process is only allowed to
> > > > > do io if the disk is idle, and 20 means the process io is considered
> > > > 
> > > > So a process with ioprio == 0 can be forever starved. As it's not
> > > 
> > > Yes
> > 
> > If semaphore is held over disk io somewhere (quota code? journaling?)
> > you have ugly possibility of priority inversion there.
> 
> Indeed yes. That's a general problem with all the io priorities though,
> RT io might end up waiting for nice 10 io etc. Dunno what to do about
> this yet...

Well, traditional (== scheduler) solution is not to have idle classes
and not guarantee anything about realtime classes.

At least idle class can not be used to hold important semaphore
forever (even low-priority prosses receive enough time not to hold
important semaphores too long)... I believe you should do the same (==
get rid of idle class for now, and clearly state that realtime ones
are not _guaranteed_ anything).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
