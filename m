Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSKMOAF>; Wed, 13 Nov 2002 09:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSKMOAF>; Wed, 13 Nov 2002 09:00:05 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:39849 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261561AbSKMOAE>; Wed, 13 Nov 2002 09:00:04 -0500
Subject: Re: Kill obsolete and  unused suspend/resume code from IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021113134208.GD10168@atrey.karlin.mff.cuni.cz>
References: <20021112175154.GA6881@elf.ucw.cz>
	<200211121801.gACI1ro25294@devserv.devel.redhat.com> 
	<20021113134208.GD10168@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 14:32:22 +0000
Message-Id: <1037197942.11996.67.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 13:42, Pavel Machek wrote:
> > The code is not obsolete, it is not unused.
> 
> Can you point out what uses it? I certainly could not find it and
> killing standby/etc produced no compilation errors.
>
You were right - actually the code that uses it isnt committed into the
tree. Its also not going to be now you are doing sysfs

> As of obsolete... It is doing power managment outside of sysfs
> framework... Which is not how it should be done.
> 
> > > +	do_idedisk_standby(drive);
> > >  	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
> > >  		if (do_idedisk_flushcache(drive))
> > >  			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
> > 
> > What locking rules are you using here ?

flushcache takes the ide lock which is already held at that point. The
code splits the unregister/standby path in two so that the unregister
doesnt deadlock

> Linus actually asked me for the patch, and discussion about it was
> public, then he silently droped it. This was "only" retransmit.

Ok.

I think your flushcache thing is safe in the new code, and I'm more than
happy for the PM changes against the new code to use sysfs to go into
the tree. 2.5.47-ac2 has pretty current ide - there isnt anything going
to get moved around dramatically again just yet (I wamt to move the
disk, tape, floppy,... drivers into a subdir later but not yet)

Alan

