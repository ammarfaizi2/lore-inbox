Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTD0URy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 16:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTD0URy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 16:17:54 -0400
Received: from alfie.demon.co.uk ([158.152.44.128]:64523 "EHLO
	bagpuss.pyrites.org.uk") by vger.kernel.org with ESMTP
	id S261722AbTD0URx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 16:17:53 -0400
Newsgroups: list.linux-kernel
References: <20030421142624.B11886@figure1.int.wirex.com> <Pine.GSO.4.44.0304251855390.21961-100000@elaine24.Stanford.EDU>
X-Newsreader: NN version 6.5.0 CURRENT #120
X-Mailer: Mail User's Shell (7.2.6unoff2-mime 8/31/96)
To: yjf@stanford.edu (Junfeng Yang)
Subject: Re: [CHECKER] 30 potential dereference of user-pointer errors
Cc: linux-kernel@vger.kernel.org
Message-Id: <20030427201826.DCFCD7D45@bagpuss.pyrites.org.uk>
Date: Sun, 27 Apr 2003 21:18:26 +0100 (BST)
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In list.linux-kernel yjf@stanford.edu (Junfeng Yang) wrote:
> [BUG] on VIDIOCGCAPUTRE and VIDIOCSCAPUTRE branches copy_*_user functions are called. on other branches not
> /home/junfeng/linux-tainted/drivers/media/video/cpia.c:3432:cpia_do_ioctl: ERROR:TAINTED:3432:3432: dereferencing tainted ptr 'vp' [Callstack: ]
> 
> 		DBG("VIDIOCSPICT\n");
> 
> 		/* check validity */
> 		DBG("palette: %d\n", vp->palette);
> 		DBG("depth: %d\n", vp->depth);
> 
> Error --->
> 		if (!valid_mode(vp->palette, vp->depth)) {
> 			retval = -EINVAL;
> 			break;
> 		}
> ---------------------------------------------------------

I can't see this.  This code fragment is from cpia_do_ioctl.  This is
never called directly, the entry point is cpia_ioctl, which always passes
ioctl calls to video_usercopy (which calls cpia_do_ioctl through the
supplied function pointer).

In video_usercopy, it calls copy_from_user for an _IOW ioctl (which
VIDIOCSPICT is).  There is certainly no differentiation between the
different ioctl calls made by video_usercopy.

Is there something I have missed?

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
