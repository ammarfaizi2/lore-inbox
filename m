Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131259AbRAPSX2>; Tue, 16 Jan 2001 13:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132310AbRAPSXI>; Tue, 16 Jan 2001 13:23:08 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:47599 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S131259AbRAPSXB>; Tue, 16 Jan 2001 13:23:01 -0500
Date: Tue, 16 Jan 2001 12:22:56 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <200101161724.f0GHOnE01880@aslan.sc.steeleye.com>
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> of "Tue, 16 Jan 2001 12:04:57 EST." <3A647F39.EC62BB81@didntduck.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010116182307Z131259-403+875@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Eddie Williams <Eddie.Williams@steeleye.com> on Tue,
16 Jan 2001 12:24:49 -0500


> That is not totally true.  There are two problems here, one is where you have 
> different controllers in your system and the other is where you have multiples 
> of the same controller.  What you list above solves the different controller 
> problem.  By loading the drivers in the right order you will get predictable 
> results.  However when having multiples of the same controller you are only 
> loading one driver so you are at the mercy of the way that driver was 
> developed.  Some drivers give you ways to work around this others do not.
> 
> For example the aic7xxx.c (current one at least - I have not played with the 
> Beta one enough to know what it does) lets you play with the order by turning 
> BIOS off on the cards that you don't want to BOOT from.  So the aic7xxx driver 
> sorts the controllers with BIOS enabled first.  This solves the problem where 
> you have multiple adaptec controllers in the same box to make sure you have 
> the "boot" controller first.  This, however, does not solve a third problem 
> where you have multiple disks on that controller.  My recommendation is that 
> you always install on ID 0 since that will be the "first" one found.  If you 
> install on ID 1 and you add ID 0 then you just broke your boot.  If you 
> install on ID 1 where there was an ID 0 (so you install to sdb) then if ID 0 
> dies, get pulled, etc then you can boot because ID 1 is now ID 0.
> 
> So though I do agree that making all drivers modules usually simplifies 
> handling this there are still issues and solving these I do agree today is 
> beyond the scope for the unexperienced.

And this is a problem that has plagues all PC operating systems, but has never
been a problem on the Macintosh.  Why?  Because the Mac was designed to handle
this problem, but the PC never was.

The Mac never enumerates its devices like the PC does (no C: D: etc, no
/dev/sda, /dev/sdb, or anything like that).  It also remembers the boot device
in its EEPROM (the Startup Disk Control Panel handles this).

The only way to solve this problem is the DESIGN IT INTO THE OS!  Someone needs
to stand up and say, "This is a problem, and I'm going to fix it."  There needs
to be a "device mount order database" or some kind, and all the disk drivers
need to access that database to determine where to put the devices it finds.

The only problem is BIOS boot.  That information is, I believe, stored in the
ESCD, but I don't know if it's reliable enough and complete enough to be usable
by Linux.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
