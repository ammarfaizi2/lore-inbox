Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRAXQzi>; Wed, 24 Jan 2001 11:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbRAXQz2>; Wed, 24 Jan 2001 11:55:28 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:20635 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129811AbRAXQzQ>; Wed, 24 Jan 2001 11:55:16 -0500
Message-Id: <5.0.2.1.2.20010124162842.00a48720@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 24 Jan 2001 16:54:36 +0000
To: Cataldo Thomas <cataldo@essi.fr>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: NTFS safety and lack thereof - Was: Re: Linux 2.4.0ac11
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01012416081105.19999@nessie>
In-Reply-To: <E14LOAm-0006z0-00@the-village.bc.nu>
 <E14LOAm-0006z0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:05 24/01/01, Cataldo Thomas wrote:
>On Wed, 24 Jan 2001, Alan Cox wrote:
> > 2.4.0-ac11
> > o     Major NTFS updates                              (Anton Altaparmakov)
>
>Is read access safe ?

Of course read-only is safe. As long as you mount the partition READ-ONLY 
nothing can happen to it in any way, your NTFS data is at least safe. It is 
possible however that the driver might cause the kernel to crash in the 
worst case so you might loose unsaved data on other write mounted 
partitions. Note that this is an infrequent event and I have only over 
experienced it under extreme load of the driver! Casual use like playing 
mp3s from an NTFS partition works fine. On a production system, leaving 
NTFS partitions mounted will slowly eat your memory (reported by several 
people), mostly it will go into buffers which don't seem to get freed (I 
think this is better with more recent kernels but don't have a box with 
NTFS partitions which can stay up for more than a day, due to needing to 
use windows, to make sure). - There is no detectable memory leak I can see 
(I wrote a small memory debugger tracking facility and added it to the 
driver and all allocated memory was released when the unmount happened, so 
there is no leak, admittedly I need to have this run for longer to make 
sure, also none of the memory blocks were overrun in either direction).

To summarize: usage for read only is fine for general, not too heavy duty, 
workstation that gets rebooted once every few days, kind of use.

Note that some of the facilities from Windows 2000 NTFS are not available 
and the driver will either ignore them or do something stupid, but it will 
NOT damage your data.

Write mode is another matter completely! It is extremely DANGEROUS and NOT 
suitable for everyday use. I would recommend to never mount an NTFS 
partition read/write unless you are a developer and it is either a fully 
backed up partition which you can afford to have completely trashed OR your 
partition is already trashed / NT/2k isn't working and you are trying to 
fix it. Only then is it ok to use it. Also note that the current driver has 
no support whatsoever for deleting files/directories. So you can either 
create files or copy files on top of others but not delete any of them. And 
finally note that dealing with directories is not right so preferably stick 
to only creating/copying files without involving the creation of directories.

>I would really be interested by a link to ntfs status in linux. I mean 
>what is safe and what is not.

You will have to wait for that kind of thing I am afraid. I might put up 
some kind of status page up on sourceforge at some point but not now. More 
important things to do. If someone wants to make a web page just drop me a 
line and we can put it up on linux-ntfs.sourceforge.net (nothing there at 
the moment at all)...

Hope this answers your immediate questions.

Best regards,

         Anton


-- 
    "Programmers never die. They do a GOSUB without RETURN." - Unknown source
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / Home page: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
