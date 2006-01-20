Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWATIJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWATIJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWATIJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:09:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44068 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750709AbWATIJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:09:03 -0500
Date: Fri, 20 Jan 2006 09:10:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Fall back io scheduler for 2.6.15?
Message-ID: <20060120081042.GC4213@suse.de>
References: <1114659912.16933.5.camel@mindpipe> <1114715665.18996.29.camel@localhost.localdomain> <1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com> <20060110212551.411a766d.akpm@osdl.org> <1137007032.4395.24.camel@localhost.localdomain> <20060111114303.45540193.akpm@osdl.org> <1137201135.4353.81.camel@localhost.localdomain> <20060113174914.7907bf2c.akpm@osdl.org> <20060116084309.GN3945@suse.de> <5c49b0ed0601191137u331a08a3sae8db27aac89d4c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0601191137u331a08a3sae8db27aac89d4c5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19 2006, Nate Diller wrote:
> On 1/16/06, Jens Axboe <axboe@suse.de> wrote:
> > On Fri, Jan 13 2006, Andrew Morton wrote:
> > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > >
> > > > On 2.6.14, the
> > > > fall back io scheduler (if the chosen io scheduler is not found) is set
> > > > to the default io scheduler (anticipatory, in this case), but since
> > > > 2.6.15-rc1, this semanistic is changed to fall back to noop.
> > >
> > > OK.  And I assume that AS wasn't compiled, so that's why it fell back?
> > >
> > > I actually thought that elevator= got removed, now we have
> > > /sys/block/sda/queue/scheduler.  But I guess that's not very useful with
> > > CONFIG_SYSFS=n.
> > >
> > > > Is there any reason to fall back to noop instead of as?  It seems
> > > > anticipatory is much better than noop for ext3 with large sequential
> > > > write tests (i.e, 1G dd test) ...
> > >
> > > I suspect that was an accident.  Jens?
> >
> > It is, it makes more sense to fallback to the default of course.
> 
> Not an accident at all, actually, because the original patch i
> submitted allowed you to select a scheduler as 'default' even if it
> were compiled as a module in kconfig.  Since noop is guaranteed to be
> present in any system, it is the obvious choice if the chosen or
> default scheduler is not loaded.

Yes and that was a bug in that patch. The default scheduler must be
builtin, that's a given. The Kconfig rules should make a default
selection as a module illegal. And they do, they have since been fixed.

> If you change it to fall back to the default, it will oops if the
> default is not available.

It must be.

-- 
Jens Axboe

