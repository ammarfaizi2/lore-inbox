Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312510AbSCYTNr>; Mon, 25 Mar 2002 14:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312513AbSCYTNj>; Mon, 25 Mar 2002 14:13:39 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:1973 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312510AbSCYTN1>; Mon, 25 Mar 2002 14:13:27 -0500
Message-Id: <5.1.0.14.2.20020325190440.03f99420@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 25 Mar 2002 19:13:58 +0000
To: Grogan <grogan@pcnineoneone.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ANN: New NTFS driver (2.0.0/TNG) now finished.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020325121725.71f6df02.grogan@pcnineoneone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:17 25/03/02, Grogan wrote:
>On Mon, 25 Mar 2002 02:26:41 +0000
>Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > Please everyone courageous enough to use a bleeding edge kernel and who is
> > also an NTFS user give this a try and let me know if you encounter any
> > problems! - Thanks!
>
>Hello everyone
>
>    I have been lurking here for a while on and off (to read the 
> interesting discussions and learn). Since I've got a Windows XP 
> installation on an NTFS partition on one of my hard disks, I went and got 
> the 2.5.7 source and applied this patch last night.
>
>It compiled cleanly with gcc 2.95.3 and is considerably faster than any of 
>the old NTFS drivers. Before, there was a bit of a CPU intensive delay 
>browsing directories in a file manager, like system32 and i386 with alot 
>of files when they have to be initially read from disk. The perceived 
>difference between the driver in 2.4.19-pre4 is certainly noticable on an 
>older system like this one. (PII @266 with 128 Mb RAM). I figured I'd best 
>measure something here, so I tried a bit of a test.

Great to hear! (-:

>Now, I realize this test is flawed because it also tests file creation and 
>buffers and cache and everything between the two kernels but it sure shows 
>that someone is on the right track, somewhere.

Yes it is flawed indeed but even if you would compare 2.5.7/old ntfs with 
2.5.7/new ntfs you would notice significant speed improvements.

>On a fresh boot with 2.4.19-pre4:
>
>bash-2.05$ time cp -r /mnt/windows3/windows/system32 /home/grogan/test
>
>real    8m45.256s
>user    0m0.730s
>sys     6m27.030s
>
>On a fresh boot with 2.5.7 with the new NTFS driver:
>
>bash-2.05$ time cp -r /mnt/windows3/windows/system32 /home/grogan/test
>
>real    3m13.190s
>user    0m0.610s
>sys     0m51.660s
>
>This "test" was repeated twice under the same conditions, with negligible 
>difference in the result (couple of seconds). Both of these disks are on 
>the same IDE controller (/home is /dev/hda8 and the NTFS partition is 
>/dev/hdb2). I must say I wasn't expecting such a drastic difference. The 
>data appears to be intact. (correct size and number of files, anyway)

The new driver has very significant advances in the way it accesses 
metadata as it is completely stored in the page cache which means that your 
directory contents are cached in memory so directory lookups take fractions 
of a second instead of seconds during which the device has to be accessed 
again and again.

Memory mapping and read ahead are further features which impact streaming 
performance such as copying files dramatically.

>I wanted to send  a "thumbs up". Thanks, Anton, and everyone else that 
>does what they do around here : - )

Thanks. (-:

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

