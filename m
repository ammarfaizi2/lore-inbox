Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVBJLvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVBJLvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 06:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVBJLvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 06:51:24 -0500
Received: from village.ehouse.ru ([193.111.92.18]:16390 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262103AbVBJLvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 06:51:20 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc3-bk5: XFS: fcron: could not write() buf to disk: Resource temporarily unavailable
Date: Thu, 10 Feb 2005 14:51:16 +0300
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
References: <200502082051.36989.gluk@php4.ru> <200502091744.55137.gluk@php4.ru> <20050210045457.GB1206@frodo>
In-Reply-To: <20050210045457.GB1206@frodo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101451.16776.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 February 2005 07:54, Nathan Scott wrote:
> On Wed, Feb 09, 2005 at 05:44:54PM +0300, Alexander Y. Fomichev wrote:
> > On Wednesday 09 February 2005 04:29, Nathan Scott wrote:
> > > Is that an O_SYNC write, do you know?  Or a write to an inode
> > > with the sync flag set?
> >
> > Yes, it is O_SYNC, as i can see from fcron sources, and, no, kernel
>
> OK, thanks.
>
> > > I'm chasing down a problem similar to this atm, so far looks like
> > > something in the generic VM code below sync_page_range is giving
> > > back EAGAIN, and that is getting passed back out to userspace by
> > > XFS.  Not sure where/why/how its been caused yet though ... I'll
> > > let you know once I have a fix or have found the culprit change.
>
> Turns out it was actually XFS giving back this EAGAIN, indirectly -
> and some of the generic VM routines have been tweaked recently to
> propogate more sync write errors out to userspace.  Try this patch,
> it will fix your problem - we're still discussing if this is the
> ideal fix, so something else may be merged in the end.
>
> cheers.

Yes, it works. Thank you for quick patch.

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
