Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUKDUor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUKDUor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUKDUk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:40:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11749 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262434AbUKDUim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:38:42 -0500
Date: Thu, 4 Nov 2004 15:31:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.28-rc1] Avoid oops in proc_delete_inode
Message-ID: <20041104173153.GA11097@logos.cnet>
References: <9663.1099535733@kao2.melbourne.sgi.com> <200411041629.17443@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041629.17443@WOLK>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:29:17PM +0100, Marc-Christian Petersen wrote:
> On Thursday 04 November 2004 03:35, Keith Owens wrote:
> 
> Marcelo,
> 
> I just saw you applied this to bk. Cool, but please apply a right version ;)
> 
> > Under heavy load, vmstat, top and other programs that access /proc can
> > oops.  PROC_INODE_PROPER(inode) is sometimes false for pid entries
> > (usually zombies), but inode->u.generic_ip is not NULL.
> >
> > Backport a fix by AL Viro from 2.5.7-pre2 to 2.4.28-rc1.
> >
> > Signed-off-by: Keith Owens <kaos@sgi.com>
> >
> > Index: 2.4.28-rc1/fs/proc/base.c
> > ===================================================================
> > --- 2.4.28-rc1.orig/fs/proc/base.c 2004-08-08 10:10:49.000000000 +1000
> > +++ 2.4.28-rc1/fs/proc/base.c 2004-11-04 13:25:16.402602459 +1100
> > @@ -780,6 +780,7 @@ out:
> >   return inode;
> >
> >  out_unlock:
> > + node->u.generic_ip = NULL;
> 
> has to be:
> 
>   + inode->u.generic_ip = NULL;

Done, thanks.

