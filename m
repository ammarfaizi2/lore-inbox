Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTDJMfa (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 08:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbTDJMfa (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 08:35:30 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:62726 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S264034AbTDJMf2 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 08:35:28 -0400
Date: Thu, 10 Apr 2003 14:47:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <1049941189.4467.186.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0304101033500.5042-100000@serv>
References: <1049913637.1993.73.camel@mulgrave>  <Pine.LNX.4.44.0304092202570.5042-100000@serv>
 <1049941189.4467.186.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9 Apr 2003, James Bottomley wrote:

> > Why do we need majors at all? There is no perfect way to partition the 
> > device number, it will always be some compromise. This partitioning 
> > creates more problems than it solves.
> 
> Because without them we need a user space tool or kernel policy add on
> that doesn't yet exist.
> 
> [..]
> 
> > These "enterprise device demands" certainly shouldn't break existing 
> > setups? The patches I've seen from Andries so far do exactly this.
> > What I'm mostly trying to get out of this discussion is how this large 
> > dev_t will be used during 2.6, as this requires decisions now, I'd like 
> > to know and talk about the possible consequences.
> 
> I don't see how the current patches break anything, yet.  I've already
> said how I plan to use a larger kernel dev_t in SCSI.

If you want to use only a single SCSI major, won't it change the device 
numbers? What will happen to setups, which already use more than 16 disks 
(but are still way below the 128 disk limit)?
Do you want to go to 64 partitions during 2.6? If yes, how? Won't that 
change the device numbers too?
Changes in these area require kernel policy, exactly like dynamic device 
numbers. If you want to maintain compatibility, you likely require user 
space support, exactly like dynamic device numbers. So why don't we even 
consider dynamic device numbers, especially as they have the promise of 
the simpler long term solution. The required kernel changes are certainly 
not more complex than the patches Andries got merged and still wants to 
get merged. If you actually look at the character device patches I posted, 
they already allow simple cleanups for 2.6.

> > In this mail 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=104928874409158&w=2
> > I demonstrated how new device numbers can be generated, without breaking 
> > backwards compatibility, it's quite trivial to complete this patch.
> 
> I said in my last mail that "thanks to the work of Al Viro and others,
> the problem of dynamic majors for block devices lies predominantly in
> user space".  The piece that you label "trivial" is the missing
> character device and user space components.  I don't happen to believe
> it is at all trivial, but you're welcome to prove me wrong.

The only nontrivial missing piece is how we want to map the sysfs and 
other information to static device names. OTOH if you only need a 
solution for scsi now, it should be rather simple to expand scsidev.
If you can live with dynamic device names (what scsi currently has), it's 
a simple shell script to generate the device nodes.
If you want to have thousands of disk, you need some kind of user support 
anyway, but I get surprisingly little answers, about how people want to 
actually manage that much devices? All I hear is "we want them and we 
want them now!", this makes it difficult to actually answer the question, 
how kernel should support this. In the kernel it's simpler to keep this 
dynamic, scsi does that already anyway. How will user space find these 
devices? Will it continue to scan thousands of nodes in /dev or will it 
just use the information already easily available via sysfs?

I know I'm asking a lot of annoying questions, but I have the feeling, 
that hardly anyone really thought all these problems through or someone 
withholds some important information (e.g. Peter's vague hints about "a 
fair number of the problems" for dynamic schemes or "collective global 
experience with numberspaces" don't really help without further 
explanation).
Considering all the information I currently have, dynamic device numbering 
is the better long term solution and is also usable for 2.6. I'm still 
looking for the deciding reason, which would give static device numbers a 
real advantage.

bye, Roman

