Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbSKFI4m>; Wed, 6 Nov 2002 03:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266008AbSKFI4m>; Wed, 6 Nov 2002 03:56:42 -0500
Received: from bozo.vmware.com ([65.113.40.131]:3335 "EHLO mailout1.vmware.com")
	by vger.kernel.org with ESMTP id <S266006AbSKFI4l>;
	Wed, 6 Nov 2002 03:56:41 -0500
Message-ID: <3C77B405ABE6D611A93A00065B3FFBBA080B3D@PA-EXCH2>
From: Christopher Li <chrisl@vmware.com>
To: "'Jeremy Fitzhardinge '" <jeremy@goop.org>,
       Christopher Li <chrisl@vmware.com>
Cc: "'Ext2 devel '" <ext2-devel@lists.sourceforge.net>,
       "'Linux Kernel List '" <linux-kernel@vger.kernel.org>
Subject: RE: [Ext2-devel] bug in ext3 htree rename: doesn't delete old nam
	e, leaves ino with bad nlink
Date: Wed, 6 Nov 2002 01:03:15 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

-----Original Message-----
From: Jeremy Fitzhardinge
To: chrisl@vmware.com
Cc: Ext2 devel; Linux Kernel List
Sent: 11/5/02 9:02 PM
Subject: Re: [Ext2-devel] bug in ext3 htree rename: doesn't delete old name,
leaves ino with bad nlink

On Tue, 2002-11-05 at 13:24, chrisl@vmware.com wrote:

>Thanks for looking at it so quickly.  I want ext3+htree to stabilise as
>quickly as possible, and since I had a nice reproducible bug, I may as
>well make the most of it.

That save me a lot of time to duplicate the bug. I want to make htree
stablilise quickly also.


>Yes, I would have guessed that it was related to a tree split.  The
>interesting thing to me is that it happened twice in this particular
>run, and yet it must be a fairly uncommon occurrence overall (otherwise
>it would have been reported before).  I wonder if it really is a rare
>event, or it has just gone unnoticed?

It is a relative rare event. Let's see. To make this happen, rename need to
add new entry and split the dir entry block. Depend on how much space left
on
your leaf block. Let's say your average filename length is 9. A dir entry
record is 24 bytes. A 4K block can have 170 entries. Given htree after split
is half full. Chance to hit a split on add an entry is about 1/85.
Assuem you have N leaf dir entry blocks in your dir. Chance of the old file
entry in the same block of new file entry is 1/N. Chance of old file
not in the same block after split is 1/2.

So total chance is about 1/(170*N). When you have relative small
direcotrys, the chance is bigger than huge directorys.


>Update it in what way?  In principle a rename is an atomic operation, so
>other things shouldn't be able to observe the directory in an
>intermediate state.

I mean when split dir entry blocks, it will move the dir entry inside
that block. I am not clear about do we need to invalidate the dentry
cache for those changed entry. I need to check the source.

Cheers

Chris





	J



