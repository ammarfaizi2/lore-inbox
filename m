Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTKRNcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKRNcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:32:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29595 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262591AbTKRNcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:32:53 -0500
Date: Tue, 18 Nov 2003 14:32:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031118133253.GK888@suse.de>
References: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc> <20031109113928.GN2831@suse.de> <20031113125427.GB643@openzaurus.ucw.cz> <20031117081407.GI888@suse.de> <20031118132634.GB470@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118132634.GB470@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18 2003, Pavel Machek wrote:
> > > If semaphore is held over disk io somewhere (quota code? journaling?)
> > > you have ugly possibility of priority inversion there.
> > 
> > Indeed yes. That's a general problem with all the io priorities though,
> > RT io might end up waiting for nice 10 io etc. Dunno what to do about
> > this yet...
> 
> Well, traditional (== scheduler) solution is not to have idle classes
> and not guarantee anything about realtime classes.
> 
> At least idle class can not be used to hold important semaphore
> forever (even low-priority prosses receive enough time not to hold
> important semaphores too long)... I believe you should do the same (==
> get rid of idle class for now, and clearly state that realtime ones
> are not _guaranteed_ anything).

That's not doing something about it, that's giving up... I'm not giving
any guarentees in the first place, just 'best effort'.

You could allow idle prio to proceed, if it holds a resource that could
potentially block others.

-- 
Jens Axboe

