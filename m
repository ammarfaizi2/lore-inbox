Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264435AbTCXVfu>; Mon, 24 Mar 2003 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264436AbTCXVfu>; Mon, 24 Mar 2003 16:35:50 -0500
Received: from 67-122-122-226.ded.pacbell.net ([67.122.122.226]:39972 "EHLO
	siamese.engr.3ware.com") by vger.kernel.org with ESMTP
	id <S264435AbTCXVfs>; Mon, 24 Mar 2003 16:35:48 -0500
Message-ID: <A1964EDB64C8094DA12D2271C04B812672CB38@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'Steven Pritchard'" <steve@silug.org>, linux-kernel@vger.kernel.org
Subject: RE: 3ware driver errors
Date: Mon, 24 Mar 2003 13:44:23 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is fixed in driver 1.02.00.032, the scsi layer is looping on sense key
'aborted command' after you lost power to a jbod drive, and not checking the
ASC 
which is 0x04 (Logical Unit Not Ready).  If you want to fix it by hand in
your
driver before .032 comes out, in 3w-xxxx.h, change:

{0x37, 0x0b, 0x04, 0x00},

to:

{0x37, 0x02, 0x04, 0x00}

This will return sense key 'Not Ready', and you will will not infinitely
loop.
If I were you, I would jiggle the power cables on that box and replace flaky
ones.

-Adam

-----Original Message-----
From: Steven Pritchard [mailto:steve@silug.org]
Sent: Monday, March 24, 2003 1:28 PM
To: linux-kernel@vger.kernel.org
Subject: 3ware driver errors


(Apparently 3w-xxxx in the Subject gets caught as spam.  Somebody
might want to adjust that regular expression.  :-)

I have a server that is locking up every day or two with a console
full of this error:

    3w-xxxx: scsi0: Command failed: status = 0xcb, flags = 0x37, unit #0.

This is on a Dell PowerEdge 1400SC (dual PIII/1.13GHz, 1.1GB RAM),
with a 3ware Escalade 7000-2 and two WD1600JB drives, running Red Hat
8.0 with kernel-smp 2.4.18-27.8.0.

I plan to report this to Red Hat's bugzilla, but I'm hoping for some
ideas or big red flags to jump out at somebody here...  I use this box
for a UML hosting server, so all this downtime is affecting *way* too
many people.

This box has been having other stability problems, so I'm guessing
this might not be directly related to the 3ware card/driver.  It did
survive a memtest86 pass.

Steve
-- 
steve@silug.org           | Southern Illinois Linux Users Group
(618)398-7360             | See web site for meeting details.
Steven Pritchard          | http://www.silug.org/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
