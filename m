Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUBGBcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbUBGB3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:29:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3208 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265796AbUBGB3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:29:07 -0500
Date: Sat, 7 Feb 2004 01:29:04 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: James Simmons <jsimmons@infradead.org>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
Message-ID: <20040207012904.GU21151@parcelfarce.linux.theplanet.co.uk>
References: <20040207011916.GD4492@kroah.com> <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 01:23:29AM +0000, James Simmons wrote:
> 
> > This function will not get called until the sysfs node stops being busy,
> > so it should all work properly.  But only if that fb_info structure was
> > allocated dynamically, unlike all of the current fb drivers (see my
> > other comment about this patch.)
> > 
> > So in that case, this will cause us to try to call kfree on a static
> > structure :(
> 
> I plan to move every driver to framebuffer_alloc. 

Erm...  You know, it would be much better to do that _before_ sysfs-related
merge.  With framebuffer_release() being originally defined as kfree(),
so that no breakage would happen during the transition.  Once everything is
using dynamic allocation with framebuffer_alloc()/framebuffer_free(), add
sysfs bits.  That way you get the same total size of patches in the series
and avoid the breakage on intermediate stages...
