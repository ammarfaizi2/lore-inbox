Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136393AbREDOH4>; Fri, 4 May 2001 10:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136394AbREDOHu>; Fri, 4 May 2001 10:07:50 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:53429 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136393AbREDOHj>; Fri, 4 May 2001 10:07:39 -0400
Message-Id: <5.1.0.14.2.20010504144007.00a12ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 04 May 2001 15:07:36 +0100
To: Anders Karlsson <anders.karlsson@meansolutions.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: FS Structs
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20010503222904.A505@inspiron.ssd.hursley.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:29 03/05/01, Anders Karlsson wrote:
>I am not subscribed to the list, so if I could be CC'd on eventual
>replies I would be grateful.

Sure.

>I have a question regarding some of the parts of the overall
>filesystem structure in the 2.4 kernel. (Kernel 2.4.[34].)
>In the file fs/super.c the structure `sb' is used, that is the
>superblock. As a part of that structure (reference include/linux/fs.h)
>is `struct list_head s_locked_inodes;'.
>
>The thing I can not understand at the moment is the `struct list_head'
>(reference include/linux/list.h) which looks very odd. How can I find
>which inodes are in the `s_locked_inodes' list?? All I want to do is
>to loop through the list and see each open inode in turn, is there any
>documentation for this, or is there any helpful soul out there that
>could give me any pointers?

This is how Linux kernel implements generic, circular, doubly-linked lists. 
The struct list_head is used both as the beginning of the list - i.e. for 
example sb->s_dirty is the beginning of the list of dirty inodes - and also 
as the anchor into the list of each dirty inode - i.e. looking at the 
struct inode it contains a field struct list_head i_list. This is the 
anchor into the list.

To walk the list you usually use list_for_each(). In the above example you 
would use:

struct list_head *tmp;
struct inode *ino;

list_for_each(tmp, &sb->s_dirty) {
         ino = list_entry(tmp, struct inode, i_list);
         /* do what you want with the inode */
}

If that wasn't clear enough you should consider reading up on this subject. 
For example "Linux Kernel Internals" contains a chapter on the Linux kernel 
linked list implementation. The URL for the online version 
is:  http://www.moses.uklinux.net/patches/lki.html

Hope this helps,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

