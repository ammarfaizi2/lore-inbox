Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265512AbTIDTM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbTIDTM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:12:56 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10247
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265512AbTIDTMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:12:54 -0400
Date: Thu, 4 Sep 2003 12:12:55 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-ID: <20030904191255.GE13676@matchmail.com>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Andrew Morton <akpm@osdl.org>, reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com> <3F578656.60005@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F578656.60005@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:37:10PM +0400, Hans Reiser wrote:
> Mike Fedyk wrote:
> 
> >On Thu, Sep 04, 2003 at 08:25:18PM +0400, Hans Reiser wrote:
> > 
> >
> >>In data=journal and data=ordered modes ext3 also guarantees that the 
> >>metadata will be committed atomically with the data they point to.  
> >>However ext3 does not provide user data atomicity guarantees beyond the 
> >>scope of a single filesystem disk block (usually 4 kilobytes).  If a 
> >>single write() spans two disk blocks it is possible that a crash partway 
> >>through the write will result in only one of those blocks appearing in 
> >>the file after recovery.
> >>   
> >>
> >
> >And how does reiser4 do this without changing the userspace apps?
> >
> We don't.  We just make the hovercraft, we don't force you to go over 
> the water.....

So by default with no user space modifications, reiser4 will be atomic for
each write() call, and ext3 will if it aligns withing a single page.

Is that correct?

Then you can go on to specify that you can have larger transactions if you
make some changes to the userspace apps.
