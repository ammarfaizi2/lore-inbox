Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314671AbSD1DEB>; Sat, 27 Apr 2002 23:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSD1DEA>; Sat, 27 Apr 2002 23:04:00 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:4939 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314671AbSD1DD7>; Sat, 27 Apr 2002 23:03:59 -0400
Message-Id: <5.1.0.14.2.20020427191820.04003500@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 28 Apr 2002 04:03:56 +0100
To: Jan Harkes <jaharkes@cs.cmu.edu>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [prepatch] address_space-based writeback
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020427155323.GA1275@mentor.odyssey.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:53 27/04/02, Jan Harkes wrote:
>On Fri, Apr 12, 2002 at 08:57:17AM +0100, Anton Altaparmakov wrote:
> > Yet, this really begs the question of defining the concept of a file. I am
> > quite happy with files being the io entity in ntfs. It is just that each
> > file in ntfs can contain loads of different data holding attributes which
> > are all worth placing in address spaces. Granted, a dummy inode could be
> > setup for each of those which just means a lot of wasted ram but ntfs is
> > not that important so I have to take the penalty there. But if I also need
> > unique inode numbers in those dummy inodes then the overhead is becoming
> > very, very high...
>
>You could have all additional IO streams use the same inode number and
>use iget4. Several inodes can have the same i_ino and the additional
>argument would be a stream identifier that selects the correct 'IO
>identity'.

Great idea! I quickly looked into the implementation details and using 
iget4/read_inode2 perfectly reconciles my ideas of using an address space 
mapping for each ntfs attribute with the kernels requirement of using 
inodes as the i/o entity by allowing a clean and unique mapping between 
multiple inodes with the same inode numbers and their attributes and 
address spaces.

I need to work out exactly how to do it but I will definitely go that way. 
That will make everything nice and clean and get rid of the existing 
kludges of passing around other types of objects instead of struct file * 
to my various readpage functions. Also I will be able to have fewer 
readpage functions... (-:

Thanks for the suggestion!

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

