Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWBVAEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWBVAEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWBVAEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:04:33 -0500
Received: from soundwarez.org ([217.160.171.123]:3715 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1161254AbWBVAEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:04:33 -0500
Date: Wed, 22 Feb 2006 01:04:29 +0100
From: Kay Sievers <kay.sievers@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222000429.GB12480@vrfy.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de> <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com> <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221153305.5d0b123f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 03:33:05PM -0800, Andrew Morton wrote:
> Kay Sievers <kay.sievers@suse.de> wrote:
> >
> > On Wed, Feb 22, 2006 at 12:51:01AM +0200, Pekka Enberg wrote:
> > > On Sun, 2006-02-19 at 17:02 -0800, Greg KH wrote:
> > > > If you revert this one patch, on top of a clean 2.6.16-rc4, do things
> > > > start working for you again?
> > > 
> > > Okey dokey, bisecting with mrproper took little longer than expected but
> > > I found the bad changeset:
> 
> Thanks - it helps heaps.
> 
> > > 033b96fd30db52a710d97b06f87d16fc59fee0f1 is first bad commit
> > > diff-tree 033b96fd30db52a710d97b06f87d16fc59fee0f1 (from 0f76e5acf9dc788e664056dda1e461f0bec93948)
> > > Author: Kay Sievers <kay.sievers@suse.de>
> > > Date:   Fri Nov 11 06:09:55 2005 +0100
> > > 
> > >     [PATCH] remove mount/umount uevents from superblock handling
> > 
> > Upgrade HAL, it's too old for that kernel.
> > 
> 
> We broke back-compatibility.  The changelog _failed to tell us_ that we
> were breaking back-compatibility.  The patch wouldn't have been applied if
> we'd been told that.  At least, not without a lot of careful thought.
> 
> The fact that the changelog failed to tell us this makes one suspect that
> the breakage was inadvertent.
> 
> 
> So no, upgrading HAL is not a good answer.  Please fix the kernel.

No, these events I added for HAL and they were wrong as pointed out by
Al Viro and with his help we replaced them by a better solution, which
actually is the "fix".

HAL was prepared to make use of the new events and needs to be upgraded
when the kernel gets upgraded. This happens all the time as long as we
try to find the right way to interact with the kernel and need to
change the interfaces.

HAL is tightly bound to the kernel and this will countinuously happen in
the future too, cause we can't solve the problem that you don't know how
an interface works without a user and if you don't put it in the kernel you
certainly don't have a user.

Interfaces get stable by becoming good enough and not by someone that
declares them as stable. If you have a problem with that, please introduce
a list of stable interfaces where people can rely on and I will not put
any of the new interfaces that are under construction on that list. We
need to be able to use new interfaces and change them until we know that
they are good enough. It is very unlikely to get complex interfaces
right in the first place. In the mount event case they have been identified
as the wrong way to do it and got replaced.

Thanks,
Kay
