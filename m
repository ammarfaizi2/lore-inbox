Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVCKM2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVCKM2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCKM2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:28:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3266 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262563AbVCKM1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:27:55 -0500
Date: Fri, 11 Mar 2005 12:27:47 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       willy@debian.org, nathans@sgi.com
Subject: Re: [PATCH, RFC 1/3] Add sem_getcount() to arches that lack it
Message-ID: <20050311122747.GL21986@parcelfarce.linux.theplanet.co.uk>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca> <20050310205503.6151ab83.akpm@osdl.org> <20050311053144.GP1111@conscoop.ottawa.on.ca> <20050310215652.76c47856.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310215652.76c47856.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 09:56:52PM -0800, Andrew Morton wrote:
> That's a nice application of semaphores.  I can see that there's also a
> need to be able to read the value back for reporting purposes.  Dang.
> 
> But I guess it's a bit hard to justify adding more infrastructure to
> support a single callsite which has a simple alternative.  So if you could
> please add the separate counter?

It's pretty *small* infrastructure, and it gives me something to whine at
people about when they use atomic_read on something that isn't an atomic.

> > ...
> > 
> > If this patch isn't accepted, we should get rid of the xfs and 1394
> > hacks and delete sem_getcount (parisc, frv) and sema_count (arm) as they
> > are unused.
> 
> True.

If we are going to get rid of sem_getcount, could we rename the 'count'
variables, at least on i386 and ppc to make it clear that you're not
supposed to do this ... maybe to 'count_$ARCH'?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
