Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVJVROO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVJVROO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVJVRON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:14:13 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:56236 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932212AbVJVRON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:14:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tqrmToJB+mUPQwcfbZz8fwWfnQunmLOXtV0tMux6B9+c7R83pw/I62ofG6gZ57iI0DfDOXDpk5Ux6hs8vpTLR6ExSjAVgE7R41K6SQeNwBAOR2wlCzLdPeFQYNk7gMJYqXD41z2YL6FJSx1uSBw3MjMgr2iOJ0EQrhikg+HYUMg=  ;
Message-ID: <20051022171412.16830.qmail@web31801.mail.mud.yahoo.com>
Date: Sat, 22 Oct 2005 10:14:12 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached PHYs)
To: Jeff Garzik <jgarzik@pobox.com>, dougg@torque.net,
       Luben Tuikov <luben_tuikov@adaptec.com>, Christoph Hellwig <hch@lst.de>,
       jejb@steeleye.com
Cc: Matthew Wilcox <matthew@wil.cx>, andrew.patterson@hp.com,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <4359B7CF.5060509@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jeff Garzik <jgarzik@pobox.com> wrote:
> Since people are having such a tough time grasping the use of 

Please drop the generalizaion and FUD.

You are missing the point, and the point is that using the
block layer for SMP is so, so heavyweight, that no sane OS engineer
would do that.

Ready to see example:
 - see "smp_portal" in the complete and working SAS Transport Layer/Stack
from the 1st link of my signature.  See that the overhead of sending an SMP
task from user space to the domain device is _zero_, zero overhead.  As soon
as the user process does a read(2), the SMP task it wrote(2), is immediately
sent to the domain device, using the interconnect.  No bloat, no going around
in circles.

SDI does exactly the same things as it binds to the controller, the PCI device
implementing the domain interconnect functions (exported via SDI).

> It remains an open question whether the _complexity_ of this approach is 
> more than is warranted for SMP.  But we've departed from that question, 
> in this sub-thread :)

Let everyone see what is happening:
1. The industry submits a driver which clearly shows that SMP is not a block
device and there is no technical merit to do it this way.  The industry shows
a proper implementation of SMP access to the domain.
2. Then the Linux SCSI community decides, on their own, without ANY TECHNICAL
MERIT, or knowlege of the technology that they should try to implement SMP as
a block device.  Then they see that this isn't viable since it adds bloat and
SMP doesn't warrant it, and then we're back to 1.

The parent says: here is how you do it.  The child though, ignores the parent's
advice and does it its own way only to find out that the parent was right
all along.

My question is: at what point is this process going to stop?

   Luben


-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
