Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUH3Gdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUH3Gdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 02:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUH3Gdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 02:33:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267452AbUH3Gdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:33:35 -0400
Date: Mon, 30 Aug 2004 07:33:31 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Hans Reiser <reiser@namesys.com>, flx@msu.ru, Paul Jackson <pj@sgi.com>,
       riel@redhat.com, ninja@slaphack.com, diegocg@teleline.es,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040830063331.GI16297@parcelfarce.linux.theplanet.co.uk>
References: <41323751.5000607@namesys.com> <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org> <1093821430.8099.49.camel@lade.trondhjem.org> <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org> <1093830135.8099.181.camel@lade.trondhjem.org> <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org> <20040830030157.GE16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408292042380.2295@ppc970.osdl.org> <20040830044637.GF16297@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830044637.GF16297@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 05:46:37AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Arguments about O_NOFOLLOW on the intermediate stages are bullshit, IMNSHO -
> if they want to make some parts of tree inaccessible, they should simply
> mkdir /tmp/FOAD; chmod 0 /tmp/FOAD; mount --bind /tmp/FOAD <blocked path>
> in the namespace their daemon is running in.  And forget all that crap
> about filtering pathnames and blocking symlinks on intermediate stages
> (the latter is obviously worthless without the former since one can simply
> substitute the symlink body in the pathname).

Ehh...  After looking at that for a while...  No, it's not that simple
and removing the stuff that way won't do what these guys want, at least
not without something else.  Frankly, what I've seen worries me a lot -
it looks like there is a missing primitive here that would be saner
than this sort of filtering.

It appears that most of this stuff would be covered by a fast way to tell
if the resulting object belongs to given subtree.  That could be arranged
(not without some changes, but doable), but I'm not sure that it's enough
to cover the stuff they are really trying to do.  It does look like an
interesting problem and current solutions certainly suck.  And I very
much doubt that "do a lookup if it doesn't run into anything that could
be too tricky for our pathname-based checks, otherwise let's do it step-by-step
from userland" is the right approach here.
