Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTJQWQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbTJQWQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:16:12 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:39637 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263614AbTJQWQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:16:09 -0400
Date: Fri, 17 Oct 2003 15:15:25 -0700
To: Jens Axboe <axboe@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: I/O errors in -test7-mm1 tree on ia64
Message-ID: <20031017221525.GA8348@sgi.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031016185505.GA1255@sgi.com> <20031016194934.GB711@holomorphy.com> <20031016204649.GA1778@sgi.com> <20031017101219.GD1128@suse.de> <20031017101357.GE1128@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017101357.GE1128@suse.de>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 12:13:57PM +0200, Jens Axboe wrote:
> > --- fs/xfs/pagebuf/page_buf.c	2003-10-17 12:11:30.000000000 +0200
> > +++ fs/xfs/pagebuf/page_buf.c~	2003-10-17 12:11:19.000000000 +0200
> > @@ -1406,10 +1406,8 @@
> >  		int cmd = WRITE;
> >  		if (pb->pb_flags & PBF_READ)
> >  			cmd = READ;
> > -#if 0
> >  		else if (pb->pb_flags & PBF_FLUSH)
> >  			cmd = WRITESYNC;
> > -#endif
> >  		submit_bio(cmd, bio);
> >  		if (size)
> >  			goto next_chunk;
> > 
> > it was a mistake to enable barriers unconditionally on XFS when it has
> > no fallback logic. If you apply the above on test7-mm1, it should work
> > fine for you.
> 
> Patch is reversed, you need to use -R. Funky.

That did the trick.  Thanks.

Jesse
