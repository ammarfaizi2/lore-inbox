Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWCAWY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWCAWY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWCAWY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:24:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3970 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbWCAWY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:24:27 -0500
Date: Wed, 1 Mar 2006 14:26:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: pj@sgi.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301142631.22738f2d.akpm@osdl.org>
In-Reply-To: <20060301213048.GA17251@kroah.com>
References: <20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Wed, Mar 01, 2006 at 12:58:02PM -0800, Paul Jackson wrote:
> > Greg wrote:
> > > As reported this is expected, and can be ignored safely.  It's just scsi
> > > being bad :)
> > 
> > Yeah - so I eventually realized.
> > 
> > > >  [<a0000001001eac90>] sysfs_create_group+0x30/0x2a0
> > > >                                 sp=e00002343bd97d50 bsp=e00002343bd91120
> > > >  [<a000000100809190>] topology_cpu_callback+0x70/0xc0
> > > >                                 sp=e00002343bd97d60 bsp=e00002343bd910f0
> > > >  [<a000000100809260>] topology_sysfs_init+0x80/0x120
> > > >                                 sp=e00002343bd97d60 bsp=e00002343bd910d0
> > > 
> > > This points at the sysfs cpu patches that are in -mm, which are not in
> > > my tree...
> > 
> > So ... what does that mean for who should be looking at this?
> 
> Hm, looks like that stuff went into mainline already, sorry I thought it
> was still in -mm.
> 
> Look at changeset 69dcc99199fe29b0a29471a3488d39d9d33b25fc for details.

But Paul bisected it down to a particular not-merged patch,
gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch, which I'll
admit doesn't look like it'll cause this.

Paul, did you test
http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz?  That has the
sysfs-pollable patches reverted.

> I've cced Yanmin, who did that work.

You missed.  I've added Yanmin now.
