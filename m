Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTKQIOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 03:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTKQIOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 03:14:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10179 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263387AbTKQIOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 03:14:09 -0500
Date: Mon, 17 Nov 2003 09:14:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031117081407.GI888@suse.de>
References: <SRLGXA875SP047EDQLEC055ZHDZX2V.3fae1da3@monpc> <20031109113928.GN2831@suse.de> <20031113125427.GB643@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113125427.GB643@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13 2003, Pavel Machek wrote:
> Hi!
> 
> > > OK, I ask THE question : why not using the normal nice level, via
> > > current->static_prio ?
> > > This way, cdrecord would be RT even in IO, and nice -19 updatedb would have
> > > a minimal impact on the system.
> > 
> > I don't want to tie io prioritites to cpu priorities, that's a design
> > decision.
> 
> OTOH it might make sense to make "nice" command set
> both by default.

Yes, I can probably be talked into that.

> > > > these end values are "special" - 0 means the process is only allowed to
> > > > do io if the disk is idle, and 20 means the process io is considered
> > > 
> > > So a process with ioprio == 0 can be forever starved. As it's not
> > 
> > Yes
> 
> If semaphore is held over disk io somewhere (quota code? journaling?)
> you have ugly possibility of priority inversion there.

Indeed yes. That's a general problem with all the io priorities though,
RT io might end up waiting for nice 10 io etc. Dunno what to do about
this yet...

-- 
Jens Axboe

