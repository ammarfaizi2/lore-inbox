Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266350AbUFURmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266350AbUFURmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUFURmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 13:42:36 -0400
Received: from tor.morecom.no ([64.28.24.90]:49745 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S266350AbUFURma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 13:42:30 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use? Conclusion
From: Petter Larsen <pla@morecom.no>
To: ext3 <ext3-users@redhat.com>, linux-kernel@vger.kernel.org
Cc: albertogli@telpin.com.ar
In-Reply-To: <20040618120513.GA2394@linuxhacker.ru>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	 <1087322976.1874.36.camel@pla.lokal.lan>
	 <200406160734.i5G7YZwV002051@car.linuxhacker.ru>
	 <1087460837.2765.31.camel@pla.lokal.lan>
	 <20040617170939.GO2659@linuxhacker.ru> <40D2B8C3.8090908@hist.no>
	 <20040618101520.GA2389@linuxhacker.ru>
	 <1087558255.25904.14.camel@pmarqueslinux>
	 <20040618120513.GA2394@linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087839748.6288.165.camel@pla.lokal.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 21 Jun 2004 19:42:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I will summarise this thread and try to set the picture of what has been
discussed and concluded.

1. ext3 with mode data=journal in kernel 2.6.x is probably working as
intended. One has responded with using this mode heavily on 2.6.6
without corruption related to the fs code. Since nobody has said that
they have seen faults, we should belive that it is safe. It is in an
stable kernel...  

2. Mode data=journal will not gain much more than correct mtime compared
to mode data=ordered.

3. Applications that need a very consistent filesystem, e.g. consistent
writes, they need to do this by implementing there own
transaction/journaling system. Alberto Bertogli has written a library
that can assist with this. See URL,
http://users.auriga.wearlab.de/~alb/libjio/. I have not used it so I can
not say for sure how good it is, but it seems like a nice start and
worth to take a look at.

4.  Because mode data=journal does not gain much, it would be better to
use mode data=ordered and use any form of transaction/journaling itself.
Mode data=ordered is the default in ext3 and probably most used, and
therefor also best tested.

5. If, and only if, you have less than 1 block size updates (that do not
cross block boundaries), these operations (write)  can be done
atomically. (with help of fsync and stuff,(from Oleg and others)).

6. Wear leveling on a Compact Flash card:
Wear leveling is an important task. SanDisk has Industrial Grade support
for some of there CF-cards, see these links.
http://www.sandisk.com/pressrelease/020522_toughness.htm
http://www.sandisk.com/pressrelease/021112_igapps.htm
http://www.sandisk.com/pdf/oem/WPaperWearLevelv1.0.pdf
We are in the telecommunications and networking business and need this
kind of Compact Flash cards. From there site:
* Enhanced error correction and sophisticated wear leveling technology
* Card level MTBF >3 million hours
* 2 million program/erase cycle endurance per block 

We are not bound to SanDisk. We could use any suplier that meet these
criteria. 

I do not know the wear leveling algorithm in detail so how they shuffle
read-only data (or if they do) around the disk, and even how it does it
if we create partitions on this CF disk (partition are probably
transparent for the wear leveling algorithm), is an issue we need to
find out of.

Thanks for all your replies ( there are 32 threads:-) spread along the
ext3 ML and the LKML and a couple private ). It has helped me a lot.

Best regards
-- 
Petter Larsen
cand. scient.
moreCom as
913 17 222
