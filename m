Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUGZWae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUGZWae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUGZWae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:30:34 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:55777 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265999AbUGZWab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:30:31 -0400
Date: Tue, 27 Jul 2004 00:30:30 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       John S J Anderson <jacobs@genehack.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: bug with multiple mounts of filesystems in 2.6
Message-ID: <20040726223030.GA28901@MAIL.13thfloor.at>
Mail-Followup-To: Mike Waychison <Michael.Waychison@Sun.COM>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	John S J Anderson <jacobs@genehack.org>,
	linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <86oem2hgv8.fsf@mendel.genehack.org> <1090870651.6809.62.camel@lade.trondhjem.org> <41057893.1030006@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41057893.1030006@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 05:33:07PM -0400, Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Trond Myklebust wrote:
> > På må , 26/07/2004 klokka 12:29, skreiv John S J Anderson:
> >
> >>  Hi --
> >>
> >>  We're working on migrating to the 2.6 kernel series, and one big
> >>  problem has popped up: we have a number of NFS mounts that are
> >>  mounted read-only in one location and read-write in a distinct
> >>  location (on the same machine). With 2.4 series kernels, this worked
> >>  without issue, but with 2.6, it doesn't: it's not possible to mount
> >>  the same filesystem twice with different options for each mount; the
> >>  two mount points have to share the same mount options.
> >
> > That behaviour is no longer supported as it meant that you would have
> > different superblocks (and hence different out-of-sync caches) between
> > the 2 mountpoint. It is in any case not a behaviour that is supported on
> > any other Linux filesystems.
> 
> How is this any different than having two seperate nfs clients accessing
> the same nfs export?
> 
> > If you want readonly to be an exception, then you will have to move the
> > MS_RDONLY flag from being a superblock option to being a vfsmount
> > option, then propagate that vfsmount information down to all the tests
> > of IS_RDONLY(inode). Not a trivial task, and not one that looms high on
> > my list of priorities...
> 
> What ever happened to the bind ro patches that were floating around a
> couple months ago?
> (http://marc.theaimsgroup.com/?t=107932320200005&r=1&w=2)
> 
> What is left in getting this done?  Just the touch_file bit Viro
> commented on?

started with the noatime/nodiratime stuff for inclusion
but that patch was neither commented nor included, so
I put it on hold ... currently I'm planning to update 
this for 2.6.8 ... we'll see ...

best,
Herbert


> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> http://www.sun.com
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD4DBQFBBXiTdQs4kOxk3/MRAp2CAJ9hLA43GX7breEAuFJp++noSX7hAQCYn7yw
> FXXelAMC/NCetjqwC8Q67g==
> =rQRx
> -----END PGP SIGNATURE-----
