Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132377AbRAQSKt>; Wed, 17 Jan 2001 13:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135413AbRAQSKj>; Wed, 17 Jan 2001 13:10:39 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:42214 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S135341AbRAQSK3>; Wed, 17 Jan 2001 13:10:29 -0500
Message-Id: <5.0.2.1.2.20010117180018.00a60da0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 17 Jan 2001 18:11:06 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: [PATCH] 2.4.0-ac9: NTFS cleanup & assorted bugfixes
Cc: linux-ntfs-dev@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LK-ML & LND-ML,

I have produced a patch for the NTFS driver as described below which I have 
sent to Alan Cox for inclusion in the next 2.4.0-acX kernel. Patch is 
generated against -ac9. The patch is large due to a large K&R-ification of 
the whole NTFS driver as well as error code conversion to being negative. 
Due to the size the patch is not attached but can be found on the 
linux-ntfs project (which I have taken the freedom to register) on 
sourceforge in the anonymous ftp area as:

ftp://linux-ntfs.sourceforge.net/pub/linux-ntfs/patch-ntfs-010116-linux-2.4.0-ac9.bz2

*The patch doesn't touch any code outside the NTFS driver.*

*Patch is tested for compilation both as module and in kernel (both RO and 
RW)  and for functionality as module RW. - It compiles warning free on two 
different systems and runs at least as well as the original. My testing of 
write support didn't trash the partition I was writing to which is a big 
improvement from before. [Admittedly I used my NtfsFix utility (not yet 
publicly released but watch this space) before I rebooted into NT so this 
will have helped.]*

Detailed description of patch:

- Fix a *critical* bug in on disk structure laying out which always 
resulted in some certain attributes being corrupt!

- Convert all error codes to being negative and being returned negative to 
the VFS. Including modifying all error handling to be consistently using 
negative numbers. This was suggested by Matthew Wilcox <matthew@wil.cx>.

- Fix some other bugs, not as critical but help to make the driver more 
generally correct/stable (including on disk structures and in memory 
layout, such as fixing handling the update sequence number (or fixup as 
called in the  driver), fixing searching for attributes which had some 
wrong assumptions, fix for some of the unicode stuff including endianness 
handling [There was a function half with and half without handling 
endianness!, and some not doing handling at all], possibly other one liners 
I can't remember).

- Added several FIXMEs where the fix was not obvious/small.

- Removed non-linux kernel related #ifdef-ed code as the new utilities I 
have started on will have a separate code base from the kernel mode driver 
(except for some structural header files perhaps which will be 1-to-1 
copies of each other).

- Changed NTFS driver version number to 010116.

- Added new sourceforge mailing list for linux-ntfs development to the 
Maintainers file. List is: linux-ntfs-dev@lists.sourceforge.net It goes 
together with the linux-ntfs project I registered on sourceforge where I 
intend to upload my ntfs utilities together with documentation on NTFS as 
soon as they are enough developed to not have changing 
structures/functions/APIs on a daily basis...

- Changed NTFS status to "Maintained" rather than "Odd fixes" in 
Maintainers file. I also added myself to the CREDITS file.

IMO this patch makes the code a lot more readable, more stable according to 
my testing, (even though it still is not as good as it should be but at 
least it holds up a lot more then it did before, it managed to sift through 
more than 10Gb of NTFS disk running md5sum on each file before it 
collapsed, doing it on two different SCSI disks simultaneously whereas it 
used to collapse a lot more quickly just using a single disk before), and 
last but not least gives me a good basis to begin hacking on it more 
intensely. - The next big step will be to replace the IMHO ugly 
NTFS_PUT*(ptr + ofs) = value and var = NTFS_GET*(ptr + ofs) to actual use 
of structures describing the ntfs on-disk structures (the header files and 
utilities for NTFS access and testing are cooking nicely, if a bit slowly).

Best regards,

         Anton Altaparmakov
         Linux NTFS Maintainer


-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
