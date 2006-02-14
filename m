Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWBNTJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWBNTJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWBNTJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:09:20 -0500
Received: from verein.lst.de ([213.95.11.210]:64720 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422664AbWBNTJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:09:19 -0500
Date: Tue, 14 Feb 2006 20:09:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Horst Hummel <horst.hummel@de.ibm.com>
Cc: kernel <linux-kernel@vger.kernel.org>, heiko <heicars2@de.ibm.com>,
       Stefan Weinhuber <wein@de.ibm.com>, Martin <mschwid2@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, ihno@suse.de
Subject: Re: [PATCH 0/5] new dasd ioctl patchkit
Message-ID: <20060214190909.GA20527@lst.de>
References: <1139935988.6183.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139935988.6183.5.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 05:53:08PM +0100, Horst Hummel wrote:
> Unfortunately neither me nor Stefan W. got an answer on the question
> about being more precise on 'ioctl mess' or any other statements
> like 'adds more junk to already crappy code'.
> 
> We can't see - and you did not specify - reasons why the current
> approach does not work. Therefore I don't see any urgency to change
> that NOW instead of discuss the design change (consulting Martin - 
> he will be back next week) and do the ioctl change when we have an 
> agreed solution including ALL components. 

 (1) devices have pretty clear ownership.  Implementing ioctls in
     different modules means we get a very undefined API.  Given that
     ioctls are generally deprecated adding extensions to that is
     a bad idea.
 (2) cleaning up that mess reduced code size a lot
 (3) the cmb module had more glue code than actual ioctl implementation
     which speaks words at length.
 (4) adding new ioctls is not okay in general, you should be using
     better APIs.
 (5) you're not just adding new ioctls but also add them using the
     dynamic registration facility that I NACKed before and remove in
     earlier sent patches, but you copletly ignored all objections
     and just resent the patches anyway
 (6) in addition to the dynamic ioctls it's also adding a misc device,
     leading to a totally incoherent interface.

> I agree that you proposal is straight forward and looks more pretty,
> but I don't like the approach to just delete code that doesn't fit
> your ideas.

It's not code that doesn't fit mu ideas but code that was rushed in
despite my veto for good reasons.

> As I already said, I would like to wait for final solution and 
> don't apply the patches NOW.

that's totally fine with me.  As long as we backout the bogus eer
patch before 2.6.16 all the cleanups and even the eckd ioctl fix
can wait.  But don't put this crappy interface into 1.6.16 and thus
SLES10 so that applications start to rely on it.
