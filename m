Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTKFB7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 20:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTKFB6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 20:58:54 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:63477 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261686AbTKFB6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 20:58:52 -0500
Date: Wed, 5 Nov 2003 18:57:13 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
Message-ID: <20031105185713.U10197@schatzie.adilger.int>
Mail-Followup-To: Tomas Szepe <szepe@pinerecords.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Chad Kitching <CKitching@powerlandcomputers.com>,
	linux-kernel@vger.kernel.org
References: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com> <20031105230350.GB12992@work.bitmover.com> <20031106005224.GA7105@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031106005224.GA7105@louise.pinerecords.com>; from szepe@pinerecords.com on Thu, Nov 06, 2003 at 01:52:24AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov-05 2003, Wed, 15:03 -0800
Larry McVoy <lm@bitmover.com> wrote:

> > > > +       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
> > > > +                       retval = -EINVAL;
> > > 
> > > That looks odd
> > 
> > Setting current->uid to zero when options __WCLONE and __WALL are set?
> > The retval is dead code because of the next line, but it looks like an
> > attempt to backdoor the kernel, does it not?
> 
> It sure does.  Note "current->uid = 0", not "current->uid == 0". 
> Good eyes, I missed that.  This function is sys_wait4() so by passing in
> __WCLONE|__WALL you are root.  How nice.

First of all, thanks Larry for detecting this.  Your paranoia that made
you add extra checks on the export of data (also evident in the BK
checksums everywhere) probably saved Linux as a whole a lot of grief.  

Had something like this been submarined into the kernel without any
review it might have taken a good while to find, even though it wasn't
in the BK repository itself.  Are the incremental kernel patches on
kernel.org or anything else built from the BKCVS gateway?

Granted that this was not a break in BK itself the event is still alarming.
It makes me wonder if there is some way we can start using GPG signatures
with BK itself so that you can get proof-positive that a CSET annotated
as from davem really is from the David Miller we know and trust.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

