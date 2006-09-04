Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWIDLBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWIDLBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWIDLBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:01:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2944 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751395AbWIDLBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:01:15 -0400
Message-ID: <44FC0779.9030405@garzik.org>
Date: Mon, 04 Sep 2006 07:01:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: PATA drivers queued for 2.6.19
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just pulled the "pata-drivers" branch of libata-dev.git into the 
"upstream" branch, which means that Alan's libata PATA driver collection 
is now queued for 2.6.19.

Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for 
many months.  Community-wise, no one posted objections to the PATA 
driver merge plan, when Alan posted it on LKML and linux-ide.

The following must be in all caps, though:

drivers/ide IS STILL THE PATA DRIVER SET THAT USERS AND DISTROS SHOULD 
CHOOSE.

At this time, drivers/ide should not be added to 
Documentation/feature-removal-schedule.txt.  The libata PATA driver set 
should be considered experimental still, and there remains a few 
user-visible differences between the two trees:

* Host-protected area (HPA) not ignored in libata, which means disk 
sizes differ between drivers/ide (whole disk) and libata (whole disk 
minus HPA).

* The obvious change between /dev/hdX to /dev/sdX

* /dev/sdX supports fewer partitions than /dev/hdX (16 versus 64, IIRC)

* /dev/sdX does not support all the HDIO_xxx ioctls that /dev/hdX does. 
  In practice, the ioctls we ignored are ones that very few people care 
about.

* ARM, PPC and other non-x86 platform drivers are severely 
under-represented.

As an aside, I would love to see paride updated to use libata, but we 
can probably count the number of paride users on one hand these days...

	Jeff



-- 
VGER BF report: U 0.499983
