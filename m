Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUDUW5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUDUW5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 18:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUDUW5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 18:57:45 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45771
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262756AbUDUW5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 18:57:39 -0400
Date: Thu, 22 Apr 2004 00:57:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: updated-fbmem-patch.patch
Message-ID: <20040421225744.GW29954@dualathlon.random>
References: <20040421021008.GM29954@dualathlon.random> <20040421154153.O22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421154153.O22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 03:41:53PM -0700, Chris Wright wrote:
> * Andrea Arcangeli (andrea@suse.de) wrote:
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm4/broken-out/updated-fbmem-patch.patch
> > 
> > this uses get_user for the set_cmap operation too.
> > 
> > --- 2.6.5-aa3/drivers/video/fbmem.c.~1~	2004-04-04 08:09:23.000000000 +0200
> > +++ 2.6.5-aa3/drivers/video/fbmem.c	2004-04-21 03:11:05.878951424 +0200
> > @@ -1034,11 +1034,11 @@ fb_ioctl(struct inode *inode, struct fil
> >  	case FBIOPUTCMAP:
> >  		if (copy_from_user(&cmap, (void *) arg, sizeof(cmap)))
> >  			return -EFAULT;
> > -		return (fb_set_cmap(&cmap, 0, info));
> > +		return (fb_set_cmap(&cmap, 1, info));
> 
> 0 is userspace, 1 is kernel space.  this change looks wrong.
> 
> Perhaps the change below so comment is in sync with code.

yes, I was mislead by the comment, that's why you will never ever see a
single comments describing parameters in my code (except if the stuff
really isn't obvious and it cannot be trivially deduced by the code and
in turn it _deserves_ a fat comment, definitely not in this case).
There's no way I can trust comments anyways, I perfectly know I cannot
stop after reading a comment, I went ahead and I checked if the comment
was right but it was too late and I was already biased by what I read in
the comment so I didn't notice the comment was wrong. This isn't a good
excuse, it's still my bad mistake, shame on me, but it certainly gives
more strenght to my no-comment-for-obvious-parameters policy. I don't
care if you cannot do a pdf of the whole kernel anymore, that pdf is
likely buggy anyways and you'd better not attempt to read it in the
first place.

Arjan and Andrew also notified me privately. thanks to all for noticing
and sorry for the stupid mistake of being influenced by a worthless
comment.
