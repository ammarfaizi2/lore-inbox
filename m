Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270752AbTG0LeV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270754AbTG0LeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:34:21 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:5292 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S270752AbTG0LdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:33:12 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Yury Umanets <umka@namesys.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1059303929.11755.160.camel@sonja>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
	 <1059203990.21910.13.camel@haron.namesys.com>
	 <1059228808.10692.7.camel@sonja>
	 <1059231274.28094.40.camel@haron.namesys.com>
	 <1059232897.10692.37.camel@sonja>
	 <1059301810.17567.98.camel@haron.namesys.com>
	 <1059303929.11755.160.camel@sonja>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1059306389.17567.165.camel@haron.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sun, 27 Jul 2003 15:46:29 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 15:05, Daniel Egger wrote:
> Am Son, 2003-07-27 um 12.30 schrieb Yury Umanets:
> 
> > So what? I mean, that if an IO request size does not equal to flash
> > erase size, then corresponding block device driver can't just submit
> > data to flash, but need maintain some cache, and cache size the same as 
> > erase size for particular flash device. And in the case when WRITE
> > request is encountered, and write sector does not equal to start sector
> > of cached data or cache is empty, block device driver should read data
> > from flash first to fill cache up. This is redundant IO operation.
> 

> Right, but it should be possible to ensure (by using a special encoding)
> that a part of the erased block can be detected as empty or already
> occupied by reading just a few bytes. Sure this is a tradeoff but one
> I'd be willing to make. :)

This is probably tradeoff for flash producers first of all.

> 
> > This is some misunderstanding :) First we've spoken about reiser4, then
> > you asked how does reiserfs behave on flash devices and is it convenient
> > for flash at all.
> 
> > Just make sure, that we're speaking about the same thing:
> 
> > Plugin-based architecture is used in reiser4, not in reiserfs (reiser3).
> > Reiser4 is fully different, written from the scratch filesystem. 
> 
> My bad, I thought you're using the term reiserfs also for reiser4. I was
> always talking about reiser4 when I said reiserfs.
Reiser4 will use compression. So, it will be more convenient or flash
devices. But using XIP is problematic in this case.
> 
> > > I don't see what the compression has to do with the limited number of
> > > erase/write cycles.
> 
> > Compressed data which should be written is smaller then uncompressed
> > one, thus, its writing affects smaller number of blocks. Each block will
> > be erased rarely, that will prolong flash live.
> 

> Only when the data is in motion. Considering that most of the data is
> quite fixed with only some bytes of configuration being written a few
> times and an update of a few packages every now and then I'm pretty sure
> the wear affect will hardly hit. It's more important, that the
> configuration bits are spread evenly over the full filesystem.

> 
> > So, you prefer speed? 
> 
> Yes. Especially startup times are important to us but also execution
> times for cachecold executables.
> 
> > What do you use for this x86 box with flash?
> 
> This are VIA Eden boxes with 667 Mhz fanless x86 compatible CPUs. They
> come in a booksize chassis and deliver pretty impressive performance for
> their size.

My friend used something like this for video player :) 
> 
> > > Convenient only insofar that it's more reliable.
> > I'd not say, that ext2 is too reliable though.
> 
> No it's not. Especially the fsck annoyance is a real killer because we
> can either not run it, thereby risking an inconsistent filesystem or run
> it unattended thereby risking a loss of files.
> 
> > You should take a look to reiser4, not to reiserfs. Don't forget :) 
> 
> I'm aware, thanks. :)

> 
> > But I don't understand, why do you want to make changes in current block
> > allocator plugin? In other words, what is wrong with current
> > implementation, which is willing to allocate blocks closer one to
> > another one? 
> 
> > I thought, if blocks lie side by side, as current block allocator does,
> > this increases probability of flash block device cache hitting (take a
> > look to drivers/mtd/mtdblock.c), what is definitely good. Isn't it?
> 

> I've some doubts that placing blocks close to another wears out all of
> the flash equally. I imagine something like circular or hashed block
> allocator which ensures equal wear leveling taking the erasesize of the
> flash into account.

Probably you are right in general. 

But erasesize is block device driver abstraction level related issue.
General purpose filesystem should not be concerned about it.


-- 
We're flying high, we're watching the world passes by...

