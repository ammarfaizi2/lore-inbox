Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288833AbSAQOZB>; Thu, 17 Jan 2002 09:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSAQOYx>; Thu, 17 Jan 2002 09:24:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40731 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288804AbSAQOYl>; Thu, 17 Jan 2002 09:24:41 -0500
Date: Thu, 17 Jan 2002 15:25:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Diego Calleja <grundig@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: oom failures with mem=4m
Message-ID: <20020117152523.I4847@athlon.random>
In-Reply-To: <20020116200459.E835@athlon.random> <20020116215449Z289156-13996+7212@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020116215449Z289156-13996+7212@vger.kernel.org>; from grundig@teleline.es on Wed, Jan 16, 2002 at 10:58:45PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 10:58:45PM +0100, Diego Calleja wrote:
> On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> > attached) and most important I don't have a single bugreport about the
> > current 2.4.18pre2aa2 VM (except perhaps the bdflush wakeup that seems
> > to be a little too late and that deals to lower numbers with slow write
> > load etc.., fixable with bdflush tuning). Mainline VM kills too easily,
> 
> Well, I haven't reported it yet, but booting my box with mem=4M
> gave as result: (running 2.4.18-pre2aa2):
> diego# cat /var/log/messages | grep gfp
> Jan 13 15:37:10 localhost kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> Jan 15 16:06:28 localhost kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> Jan 15 18:37:21 localhost kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> Jan 15 21:58:32 localhost kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> Jan 15 21:58:33 localhost kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> diego# 

0xf0 shouldn't lead to an oom killing, there should be some other failure
before the killing. The above are normal warnings, they're KERN_NOTICE,
not KERN_WARNING nor KERN_ERROR.

> 
> Each script of /etc/rc.d was killed by VM when it was started, there wasn't
> any "OOM", just
> "VM killed..." or something similar.

That means there wasn't enough memory, sounds like your bootup
sequence is broken and startup something big before activating swap,
either that or you start something that takes more than 16+4m, note that
with any recent distribution it is very easy that you need 16+4 after a
little time after boot.

If you could provide a vmstat trace during the VM killing, that could
show better if the VM is the culprit or if it did the right thing.

I know for experience at the first VM killing people tends to point
the finger at the VM (me too sometime at first, see the pte-highmem
thread) but at least in my tree that never turned out to be the case
yet.

> As /etc/rc.d scripts were killed, I couldn't start swap.

Can you try to boot with emergency, then activate swap, and then check
if it runs oom again despite lots of free swap available etc...? thanks,

> 
> The gfp=0x... numbers were not always the same, but I can't remember them
> because syslogd wasn't running.
> I can repeat this if you want and I'll copy all messages.
> 
> ..I remember running 2.2.14 in a 386 box with 4MB of RAM and 8 or 16 of
> swap. It was veeery slow, but even I could run apache :-)...

:)

Andrea
