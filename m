Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273109AbRIXNim>; Mon, 24 Sep 2001 09:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273326AbRIXNic>; Mon, 24 Sep 2001 09:38:32 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:19689 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S273109AbRIXNiZ>; Mon, 24 Sep 2001 09:38:25 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE1008EBA5@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: 2.4.10pre10 aic7xxx problem 
Date: Mon, 24 Sep 2001 06:38:46 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin,

I've seen some pretty heinous bugs in Big Bear firmware of that vintage.
I'll bet that the aic debug info will indicate that the disk goes out to
lunch.  I used to support a large customer who had a large population of
these disks and we went through a lot of pain debugging these drives with
Seagate.
The solution will likely be one or both of these changes:
  1) Upgrade the disk firmware to 1497 or later 
         (I have a copy if it's not readily available to you.)
     The servo should also be 6246 or later.
  2) Turn off SMART in mode page 1C (88 00).  Also the default number of
retries for the factory settings are way too high.  The mode page settings
for ST34520W should look like this:
pg len ....
-- --  
01 0a c4 20 79 00 00 00 20 00 ff ff
02 0e e0 e0 00 00 00 00 00 00 00 00 00 00 00 00
03 16 00 00 1f 61 00 00 00 00 00 f6 02 00 00 01 00 24 00 34 40 00 00 00
04 16 00 23 2e 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1c 20 00 00
07 0a 0c 20 79 00 00 00 00 00 ff ff
08 12 90 00 ff ff 00 00 ff ff ff ff 80 01 00 00 00 00 00 00
0a 0a 00 00 00 00 00 00 ff ff 00 00
1c 0a 88 00 00 00 00 00 00 00 00 01

Let me know if you need more info.

Andy

-----Original Message-----
From: Justin T. Gibbs [mailto:gibbs@scsiguy.com]
Sent: Thursday, September 20, 2001 1:11 PM
To: Benjamin Herrenschmidt
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre10 aic7xxx problem 


>Hi Justin !
>
>I'm having a problem with the aic7xxx driver in 2.4.10pre10, it used to
>work fine with 2.4.10pre8. The card is a 2960 single channel SCSI2, the
>drive is a SEAGATE ST34520N rev. 1444.
>Weirdly, the 2 drivers have the same rev. (maybe you didn't change it ?),

If the version number didn't change, then the kernels are using the same
driver.  I haven't been tracking the 2.4.10pre series, so I don't even
know what version is in there.

Please upgrade to v6.2.3.  By default it will dump lots of interesting
debug info when a timeout occurs.  You may need to use a serial console
to catch all of it.  The driver can be found here:

http://people.FreeBSD.org/~gibbs/linux/

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
