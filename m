Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWENLZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWENLZy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 07:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWENLZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 07:25:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750779AbWENLZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 07:25:53 -0400
Date: Sun, 14 May 2006 04:22:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: paul.clements@steeleye.com, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
Message-Id: <20060514042239.7a503508.akpm@osdl.org>
In-Reply-To: <17511.4439.350553.687518@cse.unsw.edu.au>
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
	<20060512104750.0f5cb10a.akpm@osdl.org>
	<17509.22160.118149.49714@cse.unsw.edu.au>
	<20060512235934.4f609019.akpm@osdl.org>
	<4465FB5C.6070808@steeleye.com>
	<20060513084208.0857ff52.akpm@osdl.org>
	<17511.4439.350553.687518@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> On Saturday May 13, akpm@osdl.org wrote:
> > Paul Clements <paul.clements@steeleye.com> wrote:
> > >
> > > Andrew Morton wrote:
> > > 
> > > > The loss of pagecache coherency seems sad.  I assume there's never a
> > > > requirement for userspace to read this file.
> > > 
> > > Actually, there is. mdadm reads the bitmap file, so that would be 
> > > broken. Also, it's just useful for a user to be able to read the bitmap 
> > > (od -x, or similar) to figure out approximately how much more he's got 
> > > to resync to get an array in-sync. Other than reading the bitmap file, I 
> > > don't know of any way to determine that.
> > 
> > Read it with O_DIRECT :(
> 
> Which is exactly what the next release of mdadm does.
> As the patch comment said:
> 
> : With this approach the pagecache may contain data which is inconsistent with 
> : what is on disk.  To alleviate the problems this can cause, md invalidates
> : the pagecache when releasing the file.  If the file is to be examined
> : while the array is active (a non-critical but occasionally useful function),
> : O_DIRECT io must be used.  And new version of mdadm will have support for this.

Which doesn't help `od -x' and is going to cause older mdadm userspace to
mysteriously and subtly fail.  Or does the user<->kernel interface have
versioning which will prevent this?


