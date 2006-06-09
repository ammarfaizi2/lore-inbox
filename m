Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWFIRuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWFIRuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWFIRuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:50:15 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:54162 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030328AbWFIRuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:50:13 -0400
Message-ID: <4489B4CB.7060001@garzik.org>
Date: Fri, 09 Jun 2006 13:50:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <m3y7w69s6v.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091018150.5498@g5.osdl.org> <20060609174146.GO1651@parisc-linux.org>
In-Reply-To: <20060609174146.GO1651@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Fri, Jun 09, 2006 at 10:30:06AM -0700, Linus Torvalds wrote:
>> And I'm not saying that just because it's a filesystem, and people get 
>> upset if they lose data. No, I'm saying it because from a maintenance 
>> standpoint, such a filesystem has almost zero cost.
> 
> One of the costs (and I'm not disagreeing with your main point;
> I think forking ext3 to ext4 at this point is reasonable), is that
> bugfixes applied to one don't necessarily get applied to the other.
> I found some recently between ext2 and ext3, and submitted those, but I
> only audited one file.  There's lots more to look at and I just haven't
> found the time recently.  Going to three variations is a lot more work
> for auditing, and it might be worth splitting some bits which genuinely
> are the same into common code.

With extents and 48bit, you have multiple code paths to audit, regardless.

If applied to ext3, you have to audit

	fs/ext3/*.c:
		if (extents)
			...
		else
			...

as opposed to

	fs/ext3/*.c:
		...	non-extent code
	fs/ext4/*.c:
		...	extent code


