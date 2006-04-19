Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWDST5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWDST5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWDST5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:57:52 -0400
Received: from silver.veritas.com ([143.127.12.111]:777 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751208AbWDST5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:57:51 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="37366211:sNHT22685564"
Date: Wed, 19 Apr 2006 20:57:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Greg KH <greg@kroah.com>
cc: David Wilk <davidwilk@gmail.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
In-Reply-To: <20060419192803.GA19852@kroah.com>
Message-ID: <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com>
 <20060419192803.GA19852@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Apr 2006 19:57:50.0533 (UTC) FILETIME=[89B34750:01C663EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Greg KH wrote:
> On Wed, Apr 19, 2006 at 12:52:33PM -0600, David Wilk wrote:
> > 
> > I think an issue was introduced with mprotect (the first patch in
> > 2.6.16.6).  With 2.6.16.5, tomcat runs fine (in sun-1.5), but in
> > 2.6.16.7, the JVM bails out complaining that it couldn't allocate
> > enough heap space.
> > 
> > If I remove '-Xmx768m' from JAVA_OPTS, then the JVM is able to
> > startup.  The machine had 1GB of RAM and 2GB of swap, so it should
> > have had plenty to give the JVM the 1GB it expects to get with an Xmx
> > of 768MB, and this worked in 2.6.16.5 and below.
> > 
> > I don't know if this is expected and satisfactory behavior, but I
> > figured I should give ya'll the heads up.
> 
> Odds are it isn't "expected", but Hugh would be the best judge of that.
> Hugh?

Neither expected nor satisfactory.  Sorry about that.  We were hoping
the straightforward shm/mprotect fix would be good enough, but it
appears not.  JVM is probably doing something we can allow with a
more complicated patch, but it _might_ turn out to be doing something
we simply cannot allow: I'll hope for the first and work out a patch
for that; but won't be ready to post it until tomorrow.

If you can get an strace of what it's doing, David, please mail that
to me; but I'm guessing that it may be hard to get, and dispiritingly
large: so don't worry unless it's easy for you.

> thanks for letting us know about this,

Indeed, and sorry for the inconvenience.

Hugh
