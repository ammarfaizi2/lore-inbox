Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTIKRdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTIKRcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:32:16 -0400
Received: from angband.namesys.com ([212.16.7.85]:46484 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261457AbTIKR1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:27:45 -0400
Date: Thu, 11 Sep 2003 21:27:40 +0400
From: Oleg Drokin <green@namesys.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Reiser3/4 & Ext2/3 was: First impressions of reiserfs4
Message-ID: <20030911172740.GK29357@namesys.com>
References: <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl> <20030908101704.GE10487@namesys.com> <20030908222457.GB17441@matchmail.com> <20030909070421.GJ10487@namesys.com> <20030909191044.GB28279@matchmail.com> <20030911102938.GE29357@namesys.com> <20030911171513.GA18399@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911171513.GA18399@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Sep 11, 2003 at 10:15:13AM -0700, Mike Fedyk wrote:
> > Well, in fact empty files do not need this block.
> True.  Do you know if ext2/3 allocates the block even for empty files?  So

No. But I guess it is not allocated. It would be stupid to allocate it.
"du" agrees with me that no block is allocated :)

> if you create the file, it should be sparse until you write something to it,
> right?  Does the touch command do this?

Yes. I tried touch and du reports file takes zero bytes.

> > Ok. I looked at the script. There should be 182900000 files created. (182.9M)
> > 100 files per dir.
> > the dir structure was like this (in number of dirs per level):
> > 31/59/25/40
> > Files were only created at the end of hierarchy.
> > See the script at the end if you are interested or want to try it yourself.
> > (script was donated to us by somebody, only it was shell script,
> > also I changed variable-names to hide identity).
> Hmm, any experiments with more files per dir (maybe 500 or 1000)?  I'm not

Feel free to perform ;)

> sure if you're going to use a directory full block with 100 files per dir in
> ext2/3.

There is no such problem in reiserfs and also so were requirements of those
people.
Anyway as I said, I had problem creating ext3 filesystem that can hold this
many inodes just because I had not big enough block device.

> > header overhead). Each metadata block has header of 24 bytes.
> > If you write to file (not looking at tail case yet), you create "indirect"
> > items in which block pointers are stored.
> > (4 bytes per pointer, when you use all space in metadata block, next block is
> > allocated (24 bytes of overhead + pointer in higher level block) plus
> > new indirect item (24 bytes of overhead again))
> Are these indirects stored in the tree, or do you have many partially filled
> indirect blocks?

They are stored in tree.

> > Also bitmaps are static (1 block per 128M of space in case of 4k blocksize)
> > as are superblock, journal and journal header.
> How many superblocks are there in reiser3?  Also, the bitmap locations are

One superblock.

> static, and allocated at mkfs time?  How is that done so fast for large
> filesystems?

Bitmap locations are indeed static and allocated at mkfs time (and at resize
time if you happen to grow the volume after creating)

This is not fast at all. And also we load those bitmaps at mount time,
this leads to a lot of complains about "reiserfs mounts large volumes slowly".

Bye,
    Oleg
