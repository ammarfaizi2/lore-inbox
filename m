Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSJ0WWs>; Sun, 27 Oct 2002 17:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbSJ0WWs>; Sun, 27 Oct 2002 17:22:48 -0500
Received: from mail.atheros.com ([65.212.155.130]:40434 "EHLO atheros.com")
	by vger.kernel.org with ESMTP id <S262670AbSJ0WWr>;
	Sun, 27 Oct 2002 17:22:47 -0500
From: Jeff Kuskin <jsk@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15804.26796.800934.718945@byte.users.atheros.com>
Date: Sun, 27 Oct 2002 14:29:00 -0800
To: linux-kernel@vger.kernel.org
Subject: Finding a physical address from userspace?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assume I run this code from userspace as root (I'll omit all error checking
and assume the page size is known to be 4KB to keep the code short):

    #define PAGECNT  10
    #define PAGESIZE 4096

    int
    main(int argc, char *argv[])
    {
        char * cp;
	char * physaddr[PAGECNT];

        cp = malloc(PAGECNT*PAGESIZE);
        mlock(cp, PAGECNT*PAGESIZE);

        for (i = 0; i < PAGECNT; i++) {
	    physaddr[i] = USERSPACE_VIRT_TO_PHYS(cp + i * PAGESIZE);
        }
    }


Two questions:

(1) The mlock() manpage says only that it will lock the pages into memory.
    It's not clear if the pages also are guaranteed not to change physical
    addresses while the mlock() is in effect.  I realize that, in theory,
    the pages could move in physical memory, but in the real world of
    kernel 2.4.x, could the physical addresses of mlock()'ed pages ever
    change?

(2) Is there any way to write the 'USERSPACE_VIRT_TO_PHYS' function?  I
    realize I could write a simple character device driver to accomplish
    the task, but I was hoping there would be a purely userspace solution
    that would not require writing (and installing) a kernel module.
    Suggestions?  It seems like this would a FAQ, but I couldn't find a
    mention of it in the LKML archives.

    (How about something "insane" like mmap()'ing /dev/mem starting at
    offset zero, filling the block pointed to by 'cp' with a known pattern,
    and then running through the mmap()'ed /dev/mem looking for the known
    pattern?  Is this crazy/stupid enough to work?)

Thanks.
