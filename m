Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbTBJVG4>; Mon, 10 Feb 2003 16:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTBJVG4>; Mon, 10 Feb 2003 16:06:56 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:37642 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP
	id <S265154AbTBJVGw>; Mon, 10 Feb 2003 16:06:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: isofs hardlink bug (inode numbers different) 
From: James Pearson <jcpearso@ge.ucl.ac.uk>
Date: Mon, 10 Feb 2003 21:16:29 +0000
Message-ID: <565559.1044911789@ourhome.freeserve.co.uk>
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I am trying to back up directory trees on CD, preserving hard links.
>> newer versions of mkisofs are supposedly able to do this, but although
>> the data is written to the isofs only once, the resulting directory
>> entries have differing inode numbers thus making restore operations
>> impossible.
>> 
>> When I sent a bug report to the author of mkisofs, Jörg Schilling, I
>> got the reply
>> 
>> >>mkisofs 2.01a01 (i686-pc-linux-gnu)
>> >>mkisofs 2.0 (i686-pc-linux-gnu)
>> >>mkisofs 1.15a27 (i686-suse-linux) 
>> >>Google shows no reference to anything which tells me that this is not
>> >>supposed to work, therefore I assume it's a bug.
>> >
>> >Nachdenken hilft wie in vielen Fällen auch hier:
>> >
>> >Der Bug auch hier ist da, wo es wegen schlechter SW Qualität wahrscheinlicher
>> >ist: Im Linux Kernel.
>> 
>> (Translation: thinking helps here too, like in many other cases: the bug
>> is in the linux kernel, where it is more likely to be due to lower
>> software quality.)
>
>[FWIW, Jörg is well-known for thinking that anything that isn't
>Solaris is complete crap.  He's entitled to his opinions.]
>
>> Insults aside, is it true that the kernel's isofs can't produce correct
>> inode numbers for hardlinked files? If that is the case it would
>> somewhat reduce the usefulness of isofs for backups.
>
>It's sort of true.
>
>There are inode numbers stored in RockRidge attributes, but using them
>comes with some humongous caveats:
>
>First: You have absolutely no guarantee that they are actually
>unique.  Broken software could easily have written them with all
>zeroes.
>
>Second: If there are files on the CD-ROM *without* RockRidge
>attributes, you can get collisions with the synthesized inode numbers
>for non-RR files.
>
>Third: If you actually rely on inode numbers to be able to find your
>files, like most versions of Unix including old (but not current)
>versions of Linux, then they are completely meaningless.
>
>The basic problem is that the RR attributes are arbitrary numbers,
>instead of any kind of pointer saying "I'm a hard link to this other
>file over here."
>
>There is another way to generate consistent inodes for hard links,
>which is to use the data block pointer as the "inode number."  This,
>however, has the problem that *ALL* zero-lenght files become "hard
>links" to each other.

In fact, for isofs file systems created with mkisofs, zero length files
would be hard links to the next file with data written to the CD.

You would also have the problem that there is nothing to prevent files
with different owner, permissions, dates, etc. sharing the same file data
...

James Pearson
