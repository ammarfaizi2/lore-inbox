Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288246AbSAIR1g>; Wed, 9 Jan 2002 12:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSAIR12>; Wed, 9 Jan 2002 12:27:28 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:36349 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288246AbSAIR1Q>; Wed, 9 Jan 2002 12:27:16 -0500
Message-Id: <5.1.0.14.2.20020109171742.026b7580@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 09 Jan 2002 17:29:11 +0000
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Difficulties in interoperating with Windows
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, lkml@andyjeffries.co.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <200201091648.KAA19440@tomcat.admin.navo.hpc.mil>
In-Reply-To: <5.1.0.14.2.20020109152921.026ad0a0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:48 09/01/02, Jesse Pollard wrote:
> > To give a concrete example from ntfs, when collating attribute names (and
> > file names for the matter) in order to determine where to place them in an
> > inode, if you do not apply all collation criteria found in the windows
> > driver, you will inevitably do the collation wrong at least in some corner
> > cases and you have a broken filesystem on your hands when you are writing.
>
>I believe the collating sequence/filenames is documentd.

I tell you it isn't. The documentation you can find in layout.h in 
ntfs-driver-tng and linux-ntfs and in the tng source is written by _me_ 
based on reverse engineering the ntfs driver. It took me several months to 
do this. If you look at the collation code and particular the name 
collation you will see why... And no this is NOT documented anywhere AFAIK.

>What isn't documented is how the journal file is handled.

Yes, that isn't documented either. And according to Jeff Merkey there are 
patent infringement issues with the log file.

>How recovery is handled.

It's documented on a concept level in "Inside Windows NT/2000" 2nd/3rd Ed 
from Microsoft press. But that doesn't help zilch in understanding the 
on-disk layout.

>I think trying to make that compatable hits the trade secrets. Compatability
>is needed if you expect to take a partition from one OS to another and still
>have the possible crash conditions handled.

Yes. ntfs tng will just unconditionally empty the journal completely as 
soon as someone performs a write mount. Currently you need to run ntfsfix 
(from linux-ntfs package) in order to achieve this after writing with the 
current ntfs driver.

>NTFS write was (briefly) available until the lawyers came to the door.

This is simply not true. The Linux driver is able to write. The problem is 
it does so very badly and corrupts the partition which doesn't make it very 
useful. At present I have stable write support to normal, existing files 
but directory operations are still broken. However I have now abandoned 
trying to fix the old driver's write support. NTFS TNG will have full write 
support eventually (but read support is not quite finished yet...).

>Along with an external tool to recover NTFS file systems.

If you are refering to my ntfsfix that is available from sourceforge, 
linux-ntfs project and package of same name.

If you are refering to microsoft's diskedit that is available on the 
Windows NT 4 SP4 CDROM which one can obtain from various sources.

No other recovery tool has been made publically available AFAIK.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

