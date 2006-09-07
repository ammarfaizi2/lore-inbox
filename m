Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWIGPql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWIGPql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWIGPql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:46:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39592 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750879AbWIGPqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:46:40 -0400
Subject: Re: JFS - real deadlock and lockdep warning (2.6.18-rc5-mm1)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20060907153951.GB13103@inferi.kami.home>
References: <20060905203309.GA3981@inferi.kami.home>
	 <1157580028.8200.72.camel@kleikamp.austin.ibm.com>
	 <20060907153951.GB13103@inferi.kami.home>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 10:46:36 -0500
Message-Id: <1157643997.23883.4.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 17:39 +0200, Mattia Dongili wrote:
> On Wed, Sep 06, 2006 at 05:00:28PM -0500, Dave Kleikamp wrote:
> [...]
> > > I suspect JFS is guilty, anyway my HD has these partitions:
> > 
> > I haven't got around to instrumenting jfs properly with
> > mutex_lock_nested(), so I know jfs doesn't run clean with lockdep
> > enabled.  What that means is that these warnings don't necessarily point
> > to a real problem, and on the other hand, lockdep hasn't been run
> > correctly against jfs to prove that the mutex usage is safe.
> > 
> > That said, I'm not aware of any known problems in jfs resulting in a
> > deadlock.  Unfortunately, without being able to use sysrq, I don't have
> > any real good ideas for you off the top of my head to further track down
> > the problem.
> 
> yup... don't know if it could put some light but simply doing
> 
> $ mv ~/.firefox ~/.firefox.old
> $ cp ~/.firefox.old ~/.firefox
> 
> in order to allocate different inodes (right?) I can run Firefox
> with my favourite skin (the one that was causing the hang before).
> 
> > I'm pretty busy this week, but I'll try to get the lockdep stuff right
> > in jfs as soon as possible.  Who knows?  Maybe it will find a real
> > locking problem.
> 
> I'll try to keep the filesystem as is to be able to test any fix/test
> you'll propose (Eclipse still hangs the computer). Fortunately I have
> one more spare partition where I can move /home.

As long as you're going to try a different /home partition, why don't
you format it as something other than jfs.  This way if you see the
problem again, you can rule out jfs as the culprit.  Also, if jfs is the
problem, you can avoid it.

-- 
David Kleikamp
IBM Linux Technology Center

