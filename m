Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265385AbUBFXrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUBFXrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:47:40 -0500
Received: from smtp07.auna.com ([62.81.186.17]:26272 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S265385AbUBFXrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:47:37 -0500
Date: Sat, 7 Feb 2004 00:47:35 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: HFSPLus driver for Linux 2.6.
Message-ID: <20040206234735.GC2771@werewolf.able.es>
References: <402304F0.1070008@thock.com> <20040205191527.4c7a488e.akpm@osdl.org> <40231076.7040307@thock.com> <20040205200217.360c51ab.akpm@osdl.org> <1076051611.885.25.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1076051611.885.25.camel@gaston> (from benh@kernel.crashing.org on Fri, Feb 06, 2004 at 08:13:32 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.06, Benjamin Herrenschmidt wrote:
> On Fri, 2004-02-06 at 15:02, Andrew Morton wrote:
> > Dylan Griffiths <dylang+kernel@thock.com> wrote:
> > >
> > > 	I don't remember where I grabbed this driver, I only know it's much 
> > >  more current than the one at 
> > >  http://sourceforge.net/projects/linux-hfsplus.
> > 
> > Sorry, that's a showstopper.  We need to understand who the maintenance
> > team is, and evaluate their preparedness to maintain this code long-term.
> > 
> > We don't want to be adding yet another rarely-used filesystem which has no
> > visible maintenance team.
> 
> It's a not-that-rarely used filesystem actually :) Been in my tree for
> a few monthes and it's used by pmac users either for iPod's or for
> accessing the MacOS X partitions.
> 
> It's written & maintained by Roman Zippel, and the latest snapshot is
> available at http://www.ardistech.com/hfsplus/ but you probably want
> to ask Roman if it's really the latest version before merging :)
> 
> One thing we absolutely need too is a port of Apple's fsck for HFS+,
> currently, the driver will refuse to mount read/write a "dirty"
> HFS+ filesystem to avoid corruption, but that means we have to reboot
> MacOS to fsck it then... But that limitation shouldn't prevent merging
> it.
> 

You got it ;)

Look at http://www.opensource.apple.com/darwinsource/10.2.5/.
Get the diskdev_cmds.tar.gz, plus a patch from Roman at
http://www.ardistech.com/hfsplus/diskdev_cmds.diff.gz.

With this, I built a fsck.hfsplus + mkfs.hfsplus. I have been using them
on USB flash drives and zip disks. No real test on a several Gb disk.
But I think they will work.

There is even the source from the 10.3.2 (Panther) version for the commands,
but the current patch from Ardistech page does not apply.

But you can have a real fsck and mkfs for hfsplus.

I think it is suitable for 2.6, but of course Roman Zippel has the last
word (and should update the patch for the Panther version, if possible...)

I would really like to see this in -mm or mainline ;). It helps moving
data around...no more VFAT for me.

Hope all this helps.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc3-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
