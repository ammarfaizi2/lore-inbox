Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUH2Swo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUH2Swo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 14:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUH2Swj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 14:52:39 -0400
Received: from clusterfw.beeline3G.net ([217.118.66.232]:16856 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S268265AbUH2Sum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 14:50:42 -0400
Date: Sun, 29 Aug 2004 22:43:55 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Christoph Hellwig <hch@lst.de>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829184355.GQ5108@backtop.namesys.com>
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com> <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com> <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org> <20040826155744.GA4250@lst.de> <20040826160638.GJ5733@mail.shareable.org> <20040826161303.GA4716@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826161303.GA4716@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 06:13:03PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 26, 2004 at 05:06:38PM +0100, Jamie Lokier wrote:
> > Christoph Hellwig wrote:
> > > > There's bound to be some security issue, but I'm not sure what you're
> > > > getting at with /tmp.  What sort of sort of security problem arises
> > > > with a world-writeable directory such as /tmp, that cannot arise with
> > > > the standard fs semantics?
> > > 
> > > Actually you are right on that issue because it would open the
> > > device/fifo as directory and not device/fifo (in fact I'd had to look at
> > > the code again to see whether they actually do this only for files or
> > > also for special files)
> > 
> > Are you saying that with reiser4, you can open a device or fifo with
> > O_DIRECTORY?
> 
> That's what I thought, but as far as I can follow the code this is not
> actually true.

All reiser4 inodes have i_ops->lookup != NULL, so open(..., O_DIRECTORY) would
succeed on them (thanks Nikita for reminding me that).

It may be better to pass the control of that to ->i_op->permission() through 
explicit MAY_LOOKUP flag.  It can be possible to eliminate the race by some
more complex logic (strict ownership check, for example) in ->permission().

-- 
Alex.
