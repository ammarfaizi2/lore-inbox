Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRKHHWG>; Thu, 8 Nov 2001 02:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281480AbRKHHV5>; Thu, 8 Nov 2001 02:21:57 -0500
Received: from borderworlds.dk ([193.162.142.101]:30213 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S281255AbRKHHVm>; Thu, 8 Nov 2001 02:21:42 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 directory index, updated
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org>
	<m3hesatcgq.fsf@borg.borderworlds.dk>
	<20011105014225Z17055-18972+38@humbolt.nl.linux.org>
From: Christian Laursen <xi@borderworlds.dk>
Date: 08 Nov 2001 08:21:39 +0100
In-Reply-To: <20011105014225Z17055-18972+38@humbolt.nl.linux.org>
Message-ID: <m3vggliv7g.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> On November 4, 2001 11:09 pm, Christian Laursen wrote:
> > Daniel Phillips <phillips@bonn-fries.net> writes:
> > 
> > > ***N.B.: still for use on test partitions only.***
> > 
> > It's the first time, I've tried this patch and I must say, that
> > the first impression is very good indeed.
> > 
> > I took a real world directory (my linux-kernel MH folder containing
> > roughly 115000 files) and did a 'du -s' on it.
> >
> Which kernel are you using?  From 2.4.10 on ext2 has an accelerator in 
> ext2_find_entry - it caches the last lookup position.  I'm wondering how that 
> affects this case.

I ran the tests again and got some real numbers this time.

The accelerator should work as normal, when the filesystem is not
mounted with -o index, shouldn't it (Although it's on a kernel
with the directory index patch)?

xi@tam:~/Mail > uname -a
Linux tam 2.4.13-3um #1 Sun Nov 4 14:29:19 CET 2001 i686 unknown

xi@tam:~/Mail > mount
/dev/ubd0 on / type ext2 (rw,index)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/ubd2 on /mnt/flaf type ext2 (rw)

xi@tam:/mnt/flaf > time du -s linux-kernel/
685652  linux-kernel

real    19m14.689s
user    0m1.650s
sys     23m39.000s

xi@tam:~/Mail > time du -s linux-kernel/
686432  linux-kernel

real    1m8.363s
user    0m5.500s
sys     0m57.350s


-- 
Best regards
    Christian Laursen
