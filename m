Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbTBKE6h>; Mon, 10 Feb 2003 23:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbTBKE6h>; Mon, 10 Feb 2003 23:58:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53082 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265898AbTBKE6g>; Mon, 10 Feb 2003 23:58:36 -0500
To: Kenneth Sumrall <ken@mvista.com>
Cc: suparna@in.ibm.com, Corey Minyard <cminyard@mvista.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
	<3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
	<20030210174243.B11250@in.ibm.com>
	<m18ywoyq78.fsf@frodo.biederman.org> <3E48536B.272E5630@mvista.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Feb 2003 22:08:01 -0700
In-Reply-To: <3E48536B.272E5630@mvista.com>
Message-ID: <m1y94nxv4e.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Sumrall <ken@mvista.com> writes:

> > Suparna Bhattacharya <suparna@in.ibm.com> writes:

> > Agreed.  I guess the primary question is can we trust the current
> > device shutdown + reboot notifier path or do we need to make some
> > large changes to avoid it.
> > 
> So are the functions registered on the reboot notifier path guaranteed
> to be non-blocking?  In the kexec on panic case, calls that can block
> would obviously be a bad thing.  If they can block, perhaps we could add
> a new flag SYS_PANIC or something like that to tell the driver to only
> do a non-blocking shutdown of the chip.

I think there is some amount of blocking allowed.  But that has not be
clearly defined.  Note in 2.5.x there is a specific subset
of the reboot notifiers the shutdown() device method.  That you
don't need to register a notifier for.  The rules are the same
and it is just a little bit cleaner.

> > Not primarily.  Instead I am trying to address the possibility that
> > DMA is overwriting the recovery code due to a device not being shutdown
> > properly.  Though it would happen to cover many cases of the wrong
> > memory address being passed to a device.
> >
> The problem we were seeing was that rogue DMA from a network interface
> chip was corrupting dentry's in the dirent cache when the rebooted
> kernel was coming back up.  This caused a whole new set of panics. :-(

And this a reserved hunk of memory from of memory from say 16MB to 20MB
would handle.  As the DMA could never have been setup at that address
it obviously will never be used...

Eric



