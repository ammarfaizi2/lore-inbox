Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWBMCxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWBMCxP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 21:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWBMCxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 21:53:15 -0500
Received: from node-4024215a.mdw.onnet.us.uu.net ([64.36.33.90]:62711 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S1751166AbWBMCxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 21:53:14 -0500
Date: Sun, 12 Feb 2006 20:53:22 -0600
From: Brandon Low <lostlogic@lostlogicx.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon 64 X2 cpuinfo oddities
Message-ID: <20060213025322.GW4394@lostlogicx.com>
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com> <p73r77gx36u.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r77gx36u.fsf@verdi.suse.de>
X-Operating-System: Linux found 2.6.11.12
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did the patch that fixes the out of sync cpufreq messages make it into
2.6.15 stable series?  I just acquired an athlon 64 x2 system, and was
having this:

Feb 12 15:33:33 [kernel] powernow-k8: error - out of sync, fix 0xa 0x2,
vid 0xa 0xa
Feb 12 15:33:59 [kernel] init_special_inode: bogus i_mode (300)
Feb 12 15:33:59 [kernel] ReiserFS: hda8: warning: vs-13075:
reiserfs_read_locked_inode: dead inode read from disk [283239 150550 0x0
SD]. This is likely to be race with knfsd. Ignore

Some filesystem corruptions have occurred as a result.  I'm testing
2.6.16-rc2 under the exact same conditions currently, and so far, no
errors.

Thanks,

Brandon Low


On Tue, 01/10/06 at 02:49:13 +0100, Andi Kleen wrote:
> Jesper Juhl <jesper.juhl@gmail.com> writes:
> > 
> > Well, first of all you'll notice that the second core shows a
> > "physical id" of 127 while the first core shows an id of 0.  Shouldn't
> > the second core be id 1, just like the "core id" fields are 0 & 1?
> 
> In theory it could be an uninitialized phys_proc_id (0xff >> 1), 
> but it could be also the BIOS just setting the local APIC of CPU 1
> to 0xff for some reason.
> 
> If you add a printk("PHYSCPU %d %x\n", smp_processor_id(), phys_proc_id[smp_processor_id()])
> at the end of arch/x86_64/kernel/setup.c:early_identify_cpu() what does
> dmesg | grep PHYSCPU output?
> 
> > 
> > Second thing I find slightly odd is the lack of "sse3" in the "flags" list.
> > I was under the impression that all AMD Athlon 64 X2 CPU's featured SSE3?
> > Is it a case of:
> >  a) Me being wrong, not all Athlon 64 X2's feature SSE3?
> >  b) The CPU actually featuring SSE3 but Linux not taking advantage of it?
> >  c) The CPU features SSE3 and it's being utilized, but /proc/cpuinfo
> > doesn't show that fact?
> >  d) Something else?
> 
> It's called pni (prescott new instructions) for historical reasons. We added
> the bit too early before Intel's marketing department could make up its
> mind fully, so Linux is stuck with the old codename.
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
