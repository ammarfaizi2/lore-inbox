Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTD0VCg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 17:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTD0VCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 17:02:36 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:25754 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261819AbTD0VCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 17:02:34 -0400
Date: Sun, 27 Apr 2003 14:14:42 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Nick Holloway <Nick.Holloway@pyrites.org.uk>
cc: linux-kernel@vger.kernel.org, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 30 potential dereference of user-pointer errors
In-Reply-To: <20030427201826.DCFCD7D45@bagpuss.pyrites.org.uk>
Message-ID: <Pine.GSO.4.44.0304271406180.9838-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, Nick Holloway wrote:

> In list.linux-kernel yjf@stanford.edu (Junfeng Yang) wrote:
> > [BUG] on VIDIOCGCAPUTRE and VIDIOCSCAPUTRE branches copy_*_user functions are called. on other branches not
> > /home/junfeng/linux-tainted/drivers/media/video/cpia.c:3432:cpia_do_ioctl: ERROR:TAINTED:3432:3432: dereferencing tainted ptr 'vp' [Callstack: ]
> >
> > 		DBG("VIDIOCSPICT\n");
> >
> > 		/* check validity */
> > 		DBG("palette: %d\n", vp->palette);
> > 		DBG("depth: %d\n", vp->depth);
> >
> > Error --->
> > 		if (!valid_mode(vp->palette, vp->depth)) {
> > 			retval = -EINVAL;
> > 			break;
> > 		}
> > ---------------------------------------------------------
>
> I can't see this.  This code fragment is from cpia_do_ioctl.  This is
> never called directly, the entry point is cpia_ioctl, which always passes
> ioctl calls to video_usercopy (which calls cpia_do_ioctl through the
> supplied function pointer).
>
> In video_usercopy, it calls copy_from_user for an _IOW ioctl (which
> VIDIOCSPICT is).  There is certainly no differentiation between the
> different ioctl calls made by video_usercopy.

Hi,

Our checker finds an inconsistencies in this function. For case branch
"VIDIOCSCAPTURE" and "VIDIOCGCAPTUER", copy_from_user is called on
argument "arg", which implies arg is a user-pointer. The checker isn't
smart enough to figure out if the dereferences in other branches are
errors or the copy_*_user calls are errors.

I checked videodev.h, where VIDIOCGCAPTURE and VIDIOCSCAPTUER are defined
as _IOR ... and _IOW. does that mean the copy_from_user calls on case
branch VIDIOCGCPAUTER and VIDIOCSCAPUTER are on kernel pointers?

-Junfeng

