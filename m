Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTKIVeN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 16:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTKIVeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 16:34:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40685 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262740AbTKIVeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 16:34:12 -0500
Date: Sun, 9 Nov 2003 22:34:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031109213411.GV2831@suse.de>
References: <20031108124758.GQ14728@suse.de> <3FAEB1DC.7040608@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAEB1DC.7040608@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09 2003, Shailabh Nagar wrote:
> >A process has an assigned io nice level, anywhere from 0 to 20. Both of
> >these end values are "special" - 0 means the process is only allowed to
> >do io if the disk is idle, and 20 means the process io is considered
> >realtime. Realtime IO always gets first access to the disk. 
> >
> 
> >Values from 1 to 19 assign 5-95% of disk bandwidth to that process. Any io 
> >class is
> >allowed to use all of disk bandwidth in absence of higher priority io.
> > 
> >
> Currently, cfq is doing bandwidth allocation in terms of  number of 
> requests, not bytes. Hence priority inversion can happen if lower 
> priority levels submit larger requests on an average. Any plans to take 
> request sizes into consideration  in future ? 

Yes that needs to be taken into account as well. I'll get another
version out soonish that works around that too.

> Of course, request sizes alone don't determine actual disk bandwidth 
> consumed  since their seek position also matters.

Yeah that's where it gets tricky. It's basically impossible to get
absolutely right, it will always be just guidelines. I don't want to
over complicate matters.

> >About the patch: stuff like this really needs some resource management
> >abstraction like CKRM. Right now we just look at the tgid of the
> >process. 
> >
> Now thats music to our ears :-)  Though you've complicated matters by 
> calling the priority level a "class" ! Please consider renaming
> class  to something else  (say priolevel ).

Done.

> Thanks for separating the hashvalue as a macro. It should make it even 
> easier to convert cfq to use a  CKRM I/O classes ' priority
> rather than the submitting task's ioprio value.

Yup that was my intention, to make the transition as smooth as possible.

-- 
Jens Axboe

