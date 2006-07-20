Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWGTRRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWGTRRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWGTRRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:17:04 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:21767 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1750743AbWGTRRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:17:03 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Kevin Radloff" <radsaq@gmail.com>
Subject: Re: FAQ updated (was Re: XFS breakage...)
Date: Thu, 20 Jul 2006 17:51:40 +0100
User-Agent: KMail/1.9.3
Cc: "Nathan Scott" <nathans@sgi.com>, "Kasper Sandberg" <lkml@metanurb.dk>,
       "Justin Piszcz" <jpiszcz@lucidpixels.com>,
       "Torsten Landschoff" <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
References: <20060718222941.GA3801@stargate.galaxy> <20060720171310.B1970528@wobbly.melbourne.sgi.com> <3b0ffc1f0607200813q39ba2303l7623baedd924a5a1@mail.gmail.com>
In-Reply-To: <3b0ffc1f0607200813q39ba2303l7623baedd924a5a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607201751.40040.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 July 2006 16:13, Kevin Radloff wrote:
> On 7/20/06, Nathan Scott <nathans@sgi.com> wrote:
> > On Wed, Jul 19, 2006 at 12:21:08PM +0200, Kasper Sandberg wrote:
> > > On Wed, 2006-07-19 at 08:57 +1000, Nathan Scott wrote:
> > > > On Wed, Jul 19, 2006 at 12:29:41AM +0200, Torsten Landschoff wrote:
> > > > > Jul 17 07:33:53 pulsar kernel: xfs_da_do_buf: bno 16777216
> > > > > Jul 17 07:33:53 pulsar kernel: dir: inode 54526538
> > > >
> > > > I suspect you had some residual directory corruption from using the
> > > > 2.6.17 XFS (which is known to have a lurking dir2 corruption issue,
> > > > fixed in the latest -stable point release).
> >
> > Correction there - no -stable exists with this yet, I guess that'll
> > be 2.6.17.7 once its out though.
> >
> > > what action do you suggest i do now?
> >
> > I've captured the state of this issue here, with options and ways
> > to correct the problem:
> >         http://oss.sgi.com/projects/xfs/faq.html#dir2
> >
> > Hope this helps.
>
> I actually tried the xfs_db method to fix my / filesystem (as you had
> outlined in
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115070320401919&w=2), and
> while it's quite possible that I screwed it up, after a subsequent
> xfs_repair run (which completed successfully and moved lots of stuff to
> /lost+found, as I would expect), the XFS code had serious problems with
> various parts of my filesystem (like "ls /lost+found", which
> would cause lots of errors to be logged, although not a complete fs
> shutdown). After another run through xfs_repair resulted in a
> filesystem that would no longer even successfully boot.
>
> Unfortunately it was a mostly-full 74GB big-/ partition on my primary
> machine (a laptop), so I don't have a dump of it for you and my report
> is probably pretty useless. :( But on the bright side, virtually all
> of the filesystem was otherwise intact and I was able to get all my
> data off before rebuilding my system.

I've been hit by this on my root filesystem today, and when I followed the 
instructions, I was able to retrieve my data. It turned out that the only 
corrupted inode was /, which unfortunately meant I had to repair the 
filesystem with a boot-cd. However, it was obvious which inodes corresponded 
to which directories, and I was able to repair it.

I'm not sure this advice is sound, but it seems to me that if you're running 
an affected 2.6.17 kernel (or ever have) on an XFS volume, it's not worth 
risking destruction if you haven't had any oopses. The filesystem will get 
worse, but hopefully in a non-fatal way, and the XFS guys will hopefully have 
an xfs_repair up that works, soon.

Right now I'd highly recommend copying as much as possible from the corrupted 
filesystem )after following the instructions) to a new filesystem (with an 
unaffected kernel, of course) and destroying the old one. I still have 
inconsistencies on the filesystem I "repaired", and it was a fairly painful 
process.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
