Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264070AbTEWOyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 10:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTEWOyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 10:54:52 -0400
Received: from fmr01.intel.com ([192.55.52.18]:30957 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264070AbTEWOyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 10:54:50 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A66470580D892@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Julien Oster'" <frodo@dereference.de>, linux-kernel@vger.kernel.org
Subject: RE: 2.5.69 won't mount root on md device
Date: Fri, 23 May 2003 08:12:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were some disk firmware updates for the IBM "DeathStar" drives (to
version A5BA/A6BA) that may prolong its life a bit, but over a sample of
about 20 drives, I still saw 80% fail within the first 18 months.  Hopefully
you didn't spend much on them ;-).  

Andy

-----Original Message-----
From: Julien Oster [mailto:frodo@dereference.de] 
Sent: Thursday, May 22, 2003 6:02 PM
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 won't mount root on md device


Christoph Hellwig <hch@infradead.org> writes:

Hello Christoph,

>> can't mount root filesystem "901" or "/dev/md1"
>> .config included. Any suggestions?

> You are using devfs so you need to tell your kernel the devfs name
> of the root device, /dev/md/1.  Or even better just turn devfs off.

Thanks, that did work out. I was confused, since the kernel also told
me the major and minor device number and so I thought it already
knows which device to mount.

But now another problem shows up:

May 22 23:34:01 frodo kernel: ide_dmaq_intr: stat=42, not expected
May 22 23:34:01 frodo kernel: ide_dmaq_intr: stat=40, not expected
May 22 23:34:01 frodo last message repeated 34 times

I get these messages from the kernel *a lot*, as you can see on the
repeat line. It's mostly stat=40, sometimes stat=42.

My two disks are attached to the onboard Promise RAID Controller (I
use it only as an IDE controller, not for RAID - Linux SoftRAID seems
faster).

I included my "lspci -v" output so you can read out the exact
mainboard and IDE/RAID controller chipset.

For my harddrives, here's a snipplet from hdparm -i /dev/hd[ac]:

 Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CMNT6A
 Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4L7D3XA

(Yes, two identical IBM Deskstars with 80GB - those IBM beasts that
tend to complete crash unrecoverably after some months, that's why I
have two of them on a RAID 1)

Regards,
Julien
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
