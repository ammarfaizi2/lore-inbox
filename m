Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWHATLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWHATLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWHATLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:11:36 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:48317 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751811AbWHATLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:11:34 -0400
Message-ID: <44CFA762.2040508@slaphack.com>
Date: Tue, 01 Aug 2006 14:11:30 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: ric@emc.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de>	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com>
In-Reply-To: <44CF9BAD.5020003@emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ric Wheeler wrote:
> Alan Cox wrote:
>> Ar Maw, 2006-08-01 am 16:52 +0200, ysgrifennodd Adrian Ulrich:
>>
>>> WriteCache, Mirroring between 2 Datacenters, snapshotting.. etc..
>>> you don't need your filesystem beeing super-robust against bad sectors
>>> and such stuff because:
>>
>>
>> You do it turns out. Its becoming an issue more and more that the sheer
>> amount of storage means that the undetected error rate from disks,
>> hosts, memory, cables and everything else is rising.

> Most people use absolutely giant disks in laptops and desktop systems 
> (300GB & 500GB are common, 750GB on the way). File systems need to be as 
> robust as possible for users of these systems as people are commonly 
> storing personal "critical" data like photos mostly on these unprotected 
> drives.

Their loss.  Robust FS is good, but really, if you aren't doing backup, 
you are going to lose data.  End of story.

> Even for the high end users, array based mirroring and so on can only do 
> so much to protect you.
> 
> Mirroring a corrupt file system to a remote data center will mirror your 
> corruption.

Assuming it's undetected.  Why would it be undetected?

> Rolling back to a snapshot typically only happens when you notice a 
> corruption which can go undetected for quite a while, so even that will 
> benefit from having "reliability" baked into the file system (i.e., it 
> should grumble about corruption to let you know that you need to roll 
> back or fsck or whatever).

Yes, the filesystem should complain about corruption.  So should the 
block layer -- if you don't trust the FS, use a checksum at the block 
layer.  So should...

There are just so many other, better places to do this than the FS.  The 
FS should complain, yes, but if the disk is bad, there's going to be 
corruption.

> An even larger issue is that our tools, like fsck, which are used to 
> uncover these silent corruptions need to scale up to the point that they 
> can uncover issues in minutes instead of days.  A lot of the focus at 
> the file system workshop was around how to dramatically reduce the 
> repair time of file systems.

That would be interesting.  I know from experience that fsck.reiser4 is 
amazing.  Blew away my data with something akin to an rm -rf, and fsck 
fixed it.  Tons of crashing/instability in the early days, but only once 
-- before they even had a version instead of a date, I think -- did I 
ever have a case where fsck couldn't fix it.

So I guess the next step would be to make fsck faster.  Someone 
mentioned a fsck that repairs the FS in the background?

> In a way, having super reliable storage hardware is only as good as the 
> file system layer on top of it - reliability needs to be baked into the 
> entire IO system stack...

That bit makes no sense.  If you have super reliable storage failure 
(never dies), and your FS is also reliable (never dies unless hardware 
does, but may go bat-shit insane when hardware dies), then you've got a 
super reliable system.

You're right, running Linux's HFS+ or NTFS write support is generally a 
bad idea, no matter how reliable your hardware is.  But this discussion 
was not about whether an FS is stable, but how well an FS survives 
hardware corruption.
