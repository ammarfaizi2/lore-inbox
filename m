Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbREPIdr>; Wed, 16 May 2001 04:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbREPIdh>; Wed, 16 May 2001 04:33:37 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:12758 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261829AbREPId3>; Wed, 16 May 2001 04:33:29 -0400
Message-Id: <5.1.0.14.2.20010516092326.00b217c0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 May 2001 09:34:53 +0100
To: "H. Peter Anvin" <hpa@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Getting FS access events
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B01D82B.8CAE38B5@transmeta.com>
In-Reply-To: <200105152231.f4FMVSC246046@saturn.cs.uml.edu>
 <5.1.0.14.2.20010516020702.00acce40@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:30 16/05/2001, H. Peter Anvin wrote:
>Anton Altaparmakov wrote:
> > And how are you thinking of this working "without introducing new
> > interfaces" if the caches are indeed incoherent? Please correct me if I
> > understand wrong, but when two caches are incoherent, I thought it means
> > that the above _would_ screw up unless protected by exclusive write locking
> > as I suggested in my previous post with the side effect that you can't
> > write the boot block without unmounting the filesystem or modifying some
> > interface somewhere.
>
>Not if direct device acess and the superblock exist in the same mapping
>space, OR an explicit interface to write the boot block is created.

True, but I was under the impression that Linus' master plan was that the 
two would be in entirely separate name spaces using separate cached copies 
of the device blocks. Putting them into the same cache would make things 
work of course, although direct access would probably give you a view of an 
inconsistent file system if the fs was writing around the page cache at the 
time (unless the fs and direct accesses lock every page on write access, 
perhaps by zeroing the uptodate flag on the page).

An explicit interface for the boot block would be interesting. AFAICS it 
would have to call down into the file system driver itself (a 
read/write_boot_block method in super_operations perhaps?) due to the 
differences in how the boot block is stored on different filesystems 
(thinking of the "boot block is a file" NTFS case).

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

