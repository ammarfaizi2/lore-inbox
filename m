Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUCSUMr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUCSUMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:12:47 -0500
Received: from ns.suse.de ([195.135.220.2]:52133 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261947AbUCSUMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:12:44 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Chris Mason <mason@suse.com>
To: reiser@namesys.com
Cc: Peter Zaitsev <peter@mysql.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <405B525D.6080006@namesys.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
	 <1079643740.11057.16.camel@watt.suse.com>
	 <1079644190.2450.405.camel@abyss.local>
	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com>
	 <1079704347.11057.130.camel@watt.suse.com>  <405B4BA3.2030205@namesys.com>
	 <1079726221.11058.174.camel@watt.suse.com>  <405B525D.6080006@namesys.com>
Content-Type: text/plain
Message-Id: <1079727308.11057.186.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Mar 2004 15:15:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 15:04, Hans Reiser wrote:
> Chris Mason wrote:
> >Lets look at actual scope of the problem:
> >
> >filesystem metadata
> >filesystem data (fsync, O_SYNC, O_DIRECT)
> >block device data (fsync, O_SYNC, O_DIRECT)
> >
> >Multiply the cases above times each filesystem and also times md and
> >device mapper, since the barriers need to aggregate down to all the
> >drives.
> >
> >In other words, just fixing fsync in 2.4 is not enough, and there is
> >still considerable development needed in 2.6.  Maybe after all the 2.6
> >changes are done and accepted we can consider backporting parts of it to
> >2.4.
> >
> In 2.6 does fsync always insert a write barrier when the metadata 
> journaling option is set for reiserfs?

Yes, fsync is done in the 2.6 patches.  O_SYNC, O_DIRECT and others are
not yet.  The important part right now is to get the IDE core bits
reviewed and all the FS guys to agree on how we want to use them.

It's much cleaner in 2.6, the filesystem can just request a flush after
the last data buffer goes down the pipe.

-chris


