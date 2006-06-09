Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbWFIPRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbWFIPRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWFIPRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:17:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37515 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965072AbWFIPRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:17:44 -0400
Message-ID: <44899113.3070509@garzik.org>
Date: Fri, 09 Jun 2006 11:17:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Christoph Hellwig <hch@infradead.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>	<44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>	<4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net>
In-Reply-To: <m3y7w6cr7d.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> PS. in the end this is just ext3 with one more feature ...

Incorrect.  You have to look at ext3 development over time.  This is a 
PATTERN with ext3 development:  mutating the metadata over time in a 
progressively incompatible manner.

You have this thing called "ext3", which fools an admin into thinking 
they can use their filesystem with any kernel that has "ext3" support. 
That's somewhat true today, but with extents it will become false. 
Having a mutating definition of "ext3" is a convenience for developers, 
and for users WHO ONLY MOVE FORWARD in kernel versions.

A 48bit ext3 filesystem with extents is completely unusable in 2.4.30's 
"ext3" or 2.6.10's "ext3".  Users are forced to hunt down the specific 
kernel version when an incompatible feature was added to ext3.  How can 
that possibly be described as "user friendly"?

"Which ext3 am I talking to, today?"
"And which kernels am I locked into, in order to talk to my filesystem?"

Not all users are big production houses that plan their filesystem 
metadata migration months in advance!  I _guarantee_ some users will 
boot into ext3-with-extents, use it for a while, and then try to 
downgrade for whatever reason...  only to find they have been LOCKED 
OUT.  That is a very real world situation, guys.

	Jeff


